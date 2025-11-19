import 'package:flutter/material.dart';
import 'homepage.dart'; // Import the HomePage

class RecruiterPage extends StatefulWidget {
  const RecruiterPage({Key? key}) : super(key: key);

  @override
  State<RecruiterPage> createState() => _RecruiterPageState();
}

class _RecruiterPageState extends State<RecruiterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  String _companyName = '';
  List<String> _selectedJobRolesToHire =
  []; // To store selected job roles

  // List of job roles to select from (you can fetch this dynamically)
  final List<String> _allJobRoles = [
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
  ];

  // --- Navigation Handler for Skip ---
  void _handleSkipSignIn() {
    // Navigate directly to HomePage as a Recruiter, replacing this page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(isRecruiter: true), // Go to HomePage as Recruiter
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Maintain light blue background
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700, // Maintain blue AppBar
        title: const Text('Recruiter Sign Up',
            style: TextStyle(color: Colors.white)),
        // Added: Keep the back arrow if needed, otherwise remove if this is the first recruiter screen
        leading: IconButton( // <-- Uncommented this section
          icon: Image.asset(
            'images/backarrow.png', // Use your back arrow icon image
            width: 24, height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
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
                  "Recruiter Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900, // Maintain dark blue text
                  ),
                ),
                const SizedBox(height: 32),

                // --- Form Fields (Email, Password, etc.) ---
                // Email
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Email field configuration ... */
                    decoration: const InputDecoration( labelText: 'Email', hintText: 'Enter your email', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your email'; } if (!value.contains('@')) { return 'Please enter a valid email address'; } return null; },
                    onSaved: (value) => _email = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Password
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Password field configuration ... */
                    decoration: const InputDecoration( labelText: 'Password', hintText: 'Enter your password', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    obscureText: true,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your password'; } if (value.length < 6) { return 'Password must be at least 6 characters'; } return null; },
                    onSaved: (value) => _password = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Phone Number
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Phone number field configuration ... */
                    decoration: const InputDecoration( labelText: 'Phone Number', hintText: 'Enter your phone number', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    keyboardType: TextInputType.phone,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your phone number'; } if (value.length < 10) { return 'Please enter a valid 10-digit phone number'; } return null; },
                    onSaved: (value) => _phoneNumber = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Company Name
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Company name field configuration ... */
                    decoration: const InputDecoration( labelText: 'Company Name', hintText: 'Enter your company name', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your company name'; } return null; },
                    onSaved: (value) => _companyName = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),

                // --- Job Role Selection ---
                const Text( 'Looking to hire for:', style: TextStyle(fontWeight: FontWeight.bold), ),
                Wrap( /* ... FilterChip configuration ... */
                  spacing: 8.0,
                  children: _allJobRoles.map((jobRole) {
                    return FilterChip(
                      label: Text(jobRole),
                      selected: _selectedJobRolesToHire.contains(jobRole),
                      backgroundColor: Colors.blue.shade100, // Maintain light blue chip background
                      selectedColor: Colors.blue.shade200, // Slightly darker blue when selected
                      checkmarkColor: Colors.blue.shade800,
                      labelStyle: TextStyle(color: Colors.blue.shade900),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedJobRolesToHire.add(jobRole);
                          } else {
                            _selectedJobRolesToHire.remove(jobRole);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // --- Sign Up Button ---
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Simulate saving data
                      print("Recruiter Sign Up Data:");
                      print("Email: $_email, Phone: $_phoneNumber, Company: $_companyName");
                      print("Hiring for: $_selectedJobRolesToHire");
                      // Navigate to HomePage as Recruiter after sign up
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(isRecruiter: true),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom( // Style maintained from your code
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Sign Up as Recruiter'),
                ),

                // --- ADDED: Skip Sign In Button ---
                const SizedBox(height: 16), // Add spacing
                Align( // Center the button
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: _handleSkipSignIn, // Call the skip handler
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade800, // Use a blue color for text
                    ),
                    child: const Text('Skip Sign In'),
                  ),
                ),
                // --- End of Added Button ---

              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*/import 'package:flutter/material.dart';
import 'homepage.dart'; // Import the HomePage

class RecruiterPage extends StatefulWidget {
  const RecruiterPage({Key? key}) : super(key: key);

  @override
  State<RecruiterPage> createState() => _RecruiterPageState();
}

class _RecruiterPageState extends State<RecruiterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  String _companyName = '';
  List<String> _selectedJobRolesToHire =
  []; // To store selected job roles

  // List of job roles to select from (you can fetch this dynamically)
  final List<String> _allJobRoles = [
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
  ];

  // --- Navigation Handler for Skip ---
  void _handleSkipSignIn() {
    // Navigate directly to HomePage as a Recruiter, replacing this page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(isRecruiter: true), // Go to HomePage as Recruiter
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Maintain light blue background
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700, // Maintain blue AppBar
        title: const Text('Recruiter Sign Up',
            style: TextStyle(color: Colors.white)),
        // Optional: Keep the back arrow if needed, otherwise remove if this is the first recruiter screen
        // leading: IconButton(
        //   icon: Image.asset(
        //     'images/backarrow.png', // Replace with your back arrow icon path
        //     width: 24, height: 24,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
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
                  "Recruiter Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900, // Maintain dark blue text
                  ),
                ),
                const SizedBox(height: 32),

                // --- Form Fields (Email, Password, etc.) ---
                // Email
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Email field configuration ... */
                    decoration: const InputDecoration( labelText: 'Email', hintText: 'Enter your email', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your email'; } if (!value.contains('@')) { return 'Please enter a valid email address'; } return null; },
                    onSaved: (value) => _email = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Password
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Password field configuration ... */
                    decoration: const InputDecoration( labelText: 'Password', hintText: 'Enter your password', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    obscureText: true,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your password'; } if (value.length < 6) { return 'Password must be at least 6 characters'; } return null; },
                    onSaved: (value) => _password = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Phone Number
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Phone number field configuration ... */
                    decoration: const InputDecoration( labelText: 'Phone Number', hintText: 'Enter your phone number', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    keyboardType: TextInputType.phone,
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your phone number'; } if (value.length < 10) { return 'Please enter a valid 10-digit phone number'; } return null; },
                    onSaved: (value) => _phoneNumber = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                // Company Name
                Container(
                  decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8), ),
                  child: TextFormField( /* ... Company name field configuration ... */
                    decoration: const InputDecoration( labelText: 'Company Name', hintText: 'Enter your company name', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ),
                    validator: (value) { if (value == null || value.isEmpty) { return 'Please enter your company name'; } return null; },
                    onSaved: (value) => _companyName = value ?? '',
                  ),
                ),
                const SizedBox(height: 16),

                // --- Job Role Selection ---
                const Text( 'Looking to hire for:', style: TextStyle(fontWeight: FontWeight.bold), ),
                Wrap( /* ... FilterChip configuration ... */
                  spacing: 8.0,
                  children: _allJobRoles.map((jobRole) {
                    return FilterChip(
                      label: Text(jobRole),
                      selected: _selectedJobRolesToHire.contains(jobRole),
                      backgroundColor: Colors.blue.shade100, // Maintain light blue chip background
                      selectedColor: Colors.blue.shade200, // Slightly darker blue when selected
                      checkmarkColor: Colors.blue.shade800,
                      labelStyle: TextStyle(color: Colors.blue.shade900),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedJobRolesToHire.add(jobRole);
                          } else {
                            _selectedJobRolesToHire.remove(jobRole);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // --- Sign Up Button ---
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Simulate saving data
                      print("Recruiter Sign Up Data:");
                      print("Email: $_email, Phone: $_phoneNumber, Company: $_companyName");
                      print("Hiring for: $_selectedJobRolesToHire");
                      // Navigate to HomePage as Recruiter after sign up
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(isRecruiter: true),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom( // Style maintained from your code
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Sign Up as Recruiter'),
                ),

                // --- ADDED: Skip Sign In Button ---
                const SizedBox(height: 16), // Add spacing
                Align( // Center the button
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: _handleSkipSignIn, // Call the skip handler
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade800, // Use a blue color for text
                    ),
                    child: const Text('Skip Sign In'),
                  ),
                ),
                // --- End of Added Button ---

              ],
            ),
          ),
        ),
      ),
    );
  }
}*/