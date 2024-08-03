import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:topswimmer/auth/auth_controller.dart';
import 'Customer_signup.dart';
import 'home_page.dart';
import 'coach_home_page.dart';
import 'package:iconly/iconly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String selectedOption = 'User';
  List<String> options = ['User', 'Seller', 'Coach', 'Expert'];

  Future<void> loginUser(String email, String password) async {
    // Authenticate user login
    // Replace this with your authentication logic for the 'User' login option
    bool isLoggedIn = await UserAuthController.instance.loginUser(
        context, // Pass context here
        email,
        password);

    // Navigate to home page only if authentication was successful
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Show login error
    }
  }


  Future<void> loginCoach(String email, String password) async {
    // Authenticate coach login
    // Replace this with your authentication logic for the 'Coach' login option
    if (email == 'coach@example.com' && password == 'password') {
      // Coach login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CoachHomePage()),
      );
    } else {
      // Show login error
    }
  }

  void performLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    switch (selectedOption) {
      case 'User':
        await loginUser(email, password);
        break;
      case 'Coach':
        await loginCoach(email, password);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70,),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: w,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the Row's children
                                children: [
                                  const Text(
                                    'Green',
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Image.asset(
                                    'img/green-icon2.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Think Clean, Think Green',
                      style: TextStyle(
                        fontFamily: "times new roman",
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      width: 1000,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green[700],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.green[700],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: w * 0.23),
                        const Text(
                          'Login as:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 20),
                        DropdownButton<String>(
                          value: selectedOption,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 40,
                          elevation: 16,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue!;
                            });
                          },
                          items: options.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: w * 0.23),
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        Spacer(), // Pushes the text to the left
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: performLogin,
                      child: Container(
                        width: w * 0.5,
                        height: h * 0.08,
                        margin: const EdgeInsets.only(top: 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image: AssetImage('img/green-rectangle.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.08),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                        children: [
                          TextSpan(
                            text: ' Create Account',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: FilledButton.tonalIcon(
                onPressed: () async {
                  try {
                    final user = await UserAuthController.loginWithGoogle();
                    if (user != null && mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    }
                  } on FirebaseAuthException catch (error) {
                    print(error.message);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      error.message ?? "Something went wrong",
                    )));
                  } catch (error) {
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      error.toString(),
                    )));
                  }
                },
                icon: const Icon(IconlyLight.login),
                label: const Text("Continue with Google"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
