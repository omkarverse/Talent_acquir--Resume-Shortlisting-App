import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'homepage.dart';
import 'recruiterpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  // Form data
  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  DateTime? _birthDate;
  String _jobRole = '';
  String _location = '';
  bool _isRecruiter = false;
  String _otherJobRole = '';
  String _otherCity = '';

  // Job Role and Location Options
  final List<String> _jobRoles = [
    'Software Developer',
    'Tester',
    'QA Engineer',
    'Manager',
    'HR',
    'Data Scientist',
    'UI/UX Designer',
    'Project Manager',
    'Business Analyst',
    'DevOps Engineer',
    'Other'
  ];

  final List<String> _locations = [
    'Pune',
    'Bangalore',
    'Mumbai',
    'Hyderabad',
    'Delhi',
    'Chennai',
    'Kolkata',
    'Ahmedabad',
    'Jaipur',
    'Lucknow',
    'Other'
  ];

  // Function to handle sign-up and navigation
  Future<void> _handleSignUp(BuildContext context) async {
    if (_isRecruiter) {
      // Navigate to RecruiterPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecruiterPage()),
      );
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        //  Here, you would typically send the data to your backend and get a response.
        await Future.delayed(
            const Duration(seconds: 2)); // Simulate network delay

        print('--- Regular User Sign Up Data ---');
        print('Email: $_email');
        print('Password: $_password');
        print('Phone: $_phoneNumber');
        print('Birthdate: $_birthDate');
        print('Job Role: $_jobRole');
        if (_jobRole == 'Other') {
          print('Other Job Role: $_otherJobRole');
        }
        print('Location: $_location');
        if (_location == 'Other') {
          print('Other City: $_otherCity');
        }
        print('Recruiter: $_isRecruiter');

        // After successful signup, navigate to the HomePage.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(isRecruiter: _isRecruiter),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: IconButton(
        icon:  Image.asset(
          'images/backarrow.png', // Replace with your back arrow icon path
          width: 24,
          height: 24,
        ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.green.shade700,
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24),
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 32),
                // Email
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Password
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Phone Number
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _phoneNumber = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Birth Date (Keep this, but we won't save it if it's a recruiter)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      labelText: 'Birth Date',
                      hintText: 'Enter your birth date (DD/MM/YYYY)',
                      border: InputBorder.none,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: Image.asset(
                        'images/calendar.png', // Replace with your calendar icon path
                        width: 74,
                        height: 24,
                      ), //Added calender icon
                    ),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _birthDate = pickedDate;
                          _birthDateController.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (!_isRecruiter && (value == null || value.isEmpty)) {
                        return 'Please enter your birth date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (!_isRecruiter && value != null && value.isNotEmpty) {
                        _birthDate = DateFormat('dd/MM/yyyy').parse(value);
                      } else {
                        _birthDate =
                        null; // Don't save birthdate for recruiters
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Job Role (Keep this, but we won't save it if it's a recruiter)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value:
                    _jobRole.isNotEmpty && !_isRecruiter ? _jobRole : null,
                    decoration: InputDecoration(
                      labelText: 'Job Role',
                      border: InputBorder.none,

                      suffixIcon: Image.asset(
                        'images/job.png', // Replace with your job icon path
                        width: 5,
                        height: 5,
                      ), //Added job role icon
                    ),
                    items: _jobRoles.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _jobRole = value!;
                      });
                    },
                    validator: (value) {
                      if (!_isRecruiter && (value == null || value.isEmpty)) {
                        return 'Please select your job role';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                    _jobRole = _isRecruiter ? '' : (value ?? ''),
                  ),
                ),
                if (!_isRecruiter && _jobRole == 'Other') ...[
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Other Job Role',
                        hintText: 'Enter your job role',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (!_isRecruiter && (value == null || value.isEmpty)) {
                          return 'Please enter your job role';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                      _otherJobRole = _isRecruiter ? '' : (value ?? ''),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Location (Keep this, but we won't save it if it's a recruiter)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value:
                    _location.isNotEmpty && !_isRecruiter ? _location : null,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: InputBorder.none,

                      suffixIcon: Image.asset(
                        'images/locationpp.png', // Replace with your location icon path
                        width: 10,
                        height: 10,
                      ), //Added location icon
                    ),
                    items: _locations.map((location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _location = value!;
                      });
                    },
                    validator: (value) {
                      if (!_isRecruiter && (value == null || value.isEmpty)) {
                        return 'Please select your location';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                    _location = _isRecruiter ? '' : (value ?? ''),
                  ),
                ),
                if (!_isRecruiter && _location == 'Other') ...[
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Other City',
                        hintText: 'Enter your city',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (!_isRecruiter && (value == null || value.isEmpty)) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                      _otherCity = _isRecruiter ? '' : (value ?? ''),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Recruiter/Employer Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Employer'),
                    Switch(
                      value: _isRecruiter,
                      onChanged: (value) {
                        setState(() {
                          _isRecruiter = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    const Text('Recruiter'),
                  ],
                ),
                const SizedBox(height: 24),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    _handleSignUp(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



