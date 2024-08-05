import 'dart:io';

import 'package:flutter/material.dart';
import 'auth/auth_controller.dart';
import 'package:iconly/iconly.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:topswimmer/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController =
      TextEditingController(); //to get the text from the textfield
  final passwordController =
      TextEditingController(); //to get the text from the textfield
  final firstNameController =
      TextEditingController(); //to get the text from the textfield
  final lastNameController =
      TextEditingController(); //to get the text from the textfield
  final phoneController =
      TextEditingController(); //to get the text from the textfield
  final confirmPasswordController = TextEditingController();

  @override
void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String dropdownValue = 'Small     < 30 m2';
  String dropdownValue2 = 'Coffee';
  String dropdownValue3 = ' ';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    List images = [
      'img/g.png',
      'img/t.png',
      'img/f.png',
    ];
    List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    String selectedItem;

    void onChanged(String value) {
      setState(() {
        selectedItem = value;
      });
    }

    bool isValidEmail(String email) {
      // Regular expression pattern for email validation
      const pattern =
          r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';

      final regExp = RegExp(pattern);

      return regExp.hasMatch(email);
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Customer Sign Up',
          style:
              TextStyle(color: Color.fromARGB(255, 26, 142, 42), fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          //to make the validation of the textfields
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  final pickedImage =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      selectedImage = File(pickedImage.path);
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: selectedImage != null
                      ? ClipOval(
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Add your profile picture (optional)',
                  style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
              const SizedBox(
                height: 25,
              ),
              Container(
                //to add decoration to the textfield
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    //to add shadow to the textfield
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      //to make the shadow bigger
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller:
                      emailController, //to get the text from the textfield
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    //email icon
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      //to change the border color when the textfield is focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //to change the border color when the textfield is not focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!isValidEmail(value)) {
                      return 'Invalid email';
                    }
                    return null; // Return null to indicate validation passed
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                //to add decoration to the textfield
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    //to add shadow to the textfield
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      //to make the shadow bigger
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller:
                      passwordController, //to get the text from the textfield
                  obscureText: true, //to hide the password
                  decoration: InputDecoration(
                    hintText: 'Password',
                    //to change the color of the hint text
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      //to change the border color when the textfield is focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //to change the border color when the textfield is not focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                // Confirm password field
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                //to add decoration to the textfield
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    //to add shadow to the textfield
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      //to make the shadow bigger
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller:
                      firstNameController, //to get the text from the textfield
                  decoration: InputDecoration(
                    hintText: 'first name',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    //email icon
                    prefixIcon: Icon(
                      Icons.person_pin_outlined,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      //to change the border color when the textfield is focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //to change the border color when the textfield is not focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                //to add decoration to the textfield
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    //to add shadow to the textfield
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      //to make the shadow bigger
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller:
                      lastNameController, //to get the text from the textfield
                  decoration: InputDecoration(
                    hintText: 'last name',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    //email icon
                    prefixIcon: Icon(
                      Icons.person_pin_sharp,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      //to change the border color when the textfield is focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //to change the border color when the textfield is not focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                //to add decoration to the textfield
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    //to add shadow to the textfield
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      //to make the shadow bigger
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller:
                      phoneController, //to get the text from the textfield
                  obscureText: false, //to hide the password
                  decoration: InputDecoration(
                    hintText: 'phone number',
                    //to change the color of the hint text
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159)),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.green[700],
                    ),
                    focusedBorder: OutlineInputBorder(
                      //to change the border color when the textfield is focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //to change the border color when the textfield is not focused
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (value.length != 11 || !value.startsWith('0')) {
                      return 'Invalid phone number';
                    }
                    return null;
                  },
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        UserAuthController.instance.register(
                            // to register the user
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            firstNameController.text.trim(),
                            lastNameController.text.trim(),
                            phoneController.text.trim(),

                            false,
                            selectedImage);
                      }
                    },
                    child: Container(
                      //to add decoration to the button
                      width: w * 0.5,
                      height: h * 0.08,
                      margin: const EdgeInsets.only(top: 40),
                      //or use the sizedbox widget for space as we used above
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          image: AssetImage('img/green-rectangle.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        //the child is the text that we want to add on top of the image
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Or sign up with',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 15),
                        Column(
                          children: [
                            // Other widgets can go here
                            FilledButton.tonalIcon(
                              onPressed: () async {
                                try {
                                  final user = await UserAuthController.loginWithGoogle();
                                  if (user != null && mounted) {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => const HomePage()));
                                  }
                                } on FirebaseAuthException catch (error) {
                                  debugPrint(error.message);
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
                              label: const Text("Google"),
                            ),
                            // Other widgets can go here
                          ],
                        )
        ]),
      ),
    ),);
  }

  //void setState(Null Function() param0) {}
}
