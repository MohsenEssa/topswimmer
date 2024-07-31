import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';

//what is GetxController?
//GetxController is a class that will be used to store the data of the expert

//AuthController is a class that will be used to store the data of the expert
class ExpertAuthController extends GetxController {
  static ExpertAuthController instance = Get
      .find(); //this line means that we can access the AuthController class from anywhere in our app
  late Rx<User?>
      _expert; //we used Rx because we want to update the expert data in realtime(if the expert data changes in the firebase)
  FirebaseAuth auth = FirebaseAuth
      .instance; //we used FirebaseAuth to handle the authentication and access alot of properties of firebase auth

  User? get expert => _expert.value;
  @override
  void onReady() {
    //onReady is a function that will be called when the AuthController class is ready
    super.onReady();
    _expert = Rx<User?>(
        auth.currentUser); //we initialized the expert with the current expert
    _expert.bindStream(auth
        .userChanges()); //if the expert logged in or logged or.. the _expert will be updated or notfied
    ever(_expert,
        _initialScreen); //ever is a function that will be called when the _expert changes
    //whenver _expert changes like when the expert logged in or logged out the _initialScreen function will be called
    //so _intialScreen will be a listener for _expert
  }

  _initialScreen(User? expert) {
    //this function will be called when the app starts
    if (expert == null) {
      //if the expert is null we will navigate to the login page, null means that the expert is not logged in
      print("login page");
      Get.offAll(() =>
          const LoginPage()); //we used Get.offAll to navigate to the login page and remove all the previous pages from the stack
    } else {
      //if the expert is not null we will navigate to the welcome page
      //Get.offAll(() => WelcomePage(email: expert.email!));
    }
  }

  void register(String email, String password, String firstname,
      String lastname, String phone) async {
    //check if all the fields are not empty including firstname, lastname and phone
    if (email.isEmpty ||
        password.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty) {
      Get.snackbar(
        "About Expert ",
        "Expert message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account Creation falied, Please fill all the fields",
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          "Account Creation falied, Please fill all the fields",
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }

    try {
      //we used async and await because we want to wait for the expert to be created
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //add expert details to firestore
      User? expert = auth.currentUser;
      if (expert != null) {
        // Expert is not null, add expert details to firestore
        await addExpertDetails(
            expert.uid, // Pass the expert's uid as the expertId
            firstname,
            lastname,
            email,
            phone);
      }
      Navigator.push(
        Get.context!,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      Get.snackbar("About Expert ", "Expert message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account Creation falied",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  // Future addExpertDetails(
  //     String firstName,
  //     String lastName,
  //     String email,
  //     String phoneNumber,
  //     String gardenSize,
  //     String budget,
  //     String category) async {
  //   await FirebaseFirestore.instance.collection('experts').add({
  //     'first_name': firstName,
  //     'last_name': lastName,
  //     'email': email,
  //     'phone_number': phoneNumber,
  //     'garden_size': gardenSize,
  //     'budget': budget,
  //     'category': category,
  //   });
  // }
  Future<void> addExpertDetails(
    String expertId,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
  ) async {
    await FirebaseFirestore.instance.collection('experts').doc(expertId).set({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  Future<bool> loginExpert(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true; // Authentication successful
    } catch (e) {
      // Show error message using GetX's snackbar
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login falied",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
      return false; // Authentication failed
    }
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true; // Authentication successful
    } catch (e) {
      // Show error message using GetX's snackbar
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login falied",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
      return false; // Authentication failed
    }
  }

  Future<bool> loginSeller(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true; // Authentication successful
    } catch (e) {
      // Show error message using GetX's snackbar
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login falied",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
      return false; // Authentication failed
    }
  }

  Future<bool> loginGardner(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true; // Authentication successful
    } catch (e) {
      // Show error message using GetX's snackbar
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login falied",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
      return false; // Authentication failed
    }
  }

  // Update expert details in Firestore
  Future<void> updateExpertDetails(
    String expertId,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('experts')
          .doc(expertId)
          .update({
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber
      });
    } catch (e) {
      Get.snackbar(
        "Update Failed",
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Update Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }

  //By using async and await, the register method waits for the expert to be
  //created before moving on to the next line of code. This helps to ensure
  //that the expert creation process is completed before any other operations
  //are performed, such as navigating to a different screen or updating the UI
}
