import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:topswimmer/auth/auth_controller.dart';
import 'package:topswimmer/welcome_page.dart';

import 'home_page.dart';
import 'GardnerHomePage.dart';
import 'SellerHomePage.dart';
import 'ExpertHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String selectedOption = 'User';
  List<String> options = ['User', 'Seller', 'Gardner', 'Expert'];

  Future<void> loginUser(String email, String password) async {
    // Authenticate user login
    // Replace this with your authentication logic for the 'User' login option
    bool isLoggedIn = await AuthController.instance.loginUser(
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

  Future<void> loginSeller(String email, String password) async {
    // Authenticate seller login
    // Replace this with your authentication logic for the 'Seller' login option
    if (email == 'seller@example.com' && password == 'password') {
      // Seller login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SellerHomePage()),
      );
    } else {
      // Show login error
    }
  }

  Future<void> loginGardner(String email, String password) async {
    // Authenticate gardner login
    // Replace this with your authentication logic for the 'Gardner' login option
    if (email == 'gardner@example.com' && password == 'password') {
      // Gardner login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GardnerHomePage()),
      );
    } else {
      // Show login error
    }
  }

  Future<void> loginExpert(String email, String password) async {
    // Authenticate expert login
    // Replace this with your authentication logic for the 'Expert' login option
    if (email == 'expert@example.com' && password == 'password') {
      // Expert login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpertHomePage()),
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
      case 'Seller':
        await loginSeller(email, password);
        break;
      case 'Gardner':
        await loginGardner(email, password);
        break;
      case 'Expert':
        await loginExpert(email, password);
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
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60, top: 125),
                      child: Row(
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
                      //we created a row to put the forgot password text to the right
                      //by putting an empty container in the left
                      children: [
                        Expanded(child: Container()),
                        const Padding(
                          padding: EdgeInsets.only(right: 230),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
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
                                    builder: (context) => const WelcomePage(),
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
          ],
        ),
      ),
    );
  }
}
