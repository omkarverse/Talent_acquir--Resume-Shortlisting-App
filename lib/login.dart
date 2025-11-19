import 'package:flutter/material.dart';
import 'package:talent_acquire/screen/signup.dart';
import 'package:talent_acquire/screen/forgotpassword.dart';
import 'homepage.dart'; // Import the HomePage

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Simulate the authentication process and getting user role
    Future<void> _handleSignIn() async {
      // Simulate a successful login.  Replace this with your actual authentication logic.
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      //  Replace this with your actual logic to determine the user's role.
      bool isRecruiter =
      false; //  For now, I'm defaulting to false.  You MUST change this.

      // Navigate to the HomePage and pass the user's role.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(isRecruiter: isRecruiter),
        ),
      );
    }

    void _handleSkipSignIn() {
      // Simulate skipping sign-in and navigate to the home page.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            isRecruiter:
            false, // Or true, depending on the default role for skipped login
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green.shade50, // Light green background
      body: Center(
        child: SingleChildScrollView(
          // Added for scrolling on smaller screens
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch children horizontally
            children: <Widget>[
              // Logo or App Icon (replace with your actual asset)
              Image.asset(
                'images/login_logo.png', // Replace with your logo path
                height: 100,
                //color: Colors.green.shade800, // Optional: Colorize the logo
              ),
              const SizedBox(height: 24),

              Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900, // Dark green text
                ),
              ),
              const SizedBox(height: 32),

              // Email Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24),

              // Sign In Button
              ElevatedButton(
                onPressed: _handleSignIn, // Call the sign-in function
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16),

              // Sign Up and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.green.shade800),
                    child: const Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()),
                      );
                      // Add forgot password navigation
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.green.shade800),
                    child: const Text('Forgot Password'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Skip Sign In Button
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: _handleSkipSignIn,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade600),
                  child: const Text('Skip Sign In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

