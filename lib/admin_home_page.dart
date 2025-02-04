import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth/auth_controller.dart';
import '../add_swimmer.dart';
import 'Verify_swimmers.dart';
import 'manage_profile.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key, Key? key1});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'img/f.png',
      'img/Instagram_icon.png',
    ];

    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 35,
                        color: Color.fromARGB(255, 19, 105, 22),
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        UserAuthController().logOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminHomePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 5),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('img/logout.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 130),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Green',
                      style: TextStyle(
                        fontSize: 60,
                        color: Color.fromARGB(255, 24, 190, 29),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.grass,
                      size: 60,
                      color: Color.fromARGB(255, 24, 190, 29),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Column(
                children: [
                  Text(
                    'Welcome Admin! \n',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 74, 71, 71),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'you can verify, add swimmers \n',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 74, 71, 71),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'or many more features\n',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 74, 71, 71),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'in the future!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 74, 71, 71),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 180),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (String image in images)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[500],
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(image),
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '© 2023 Green App. All rights reserved.',
                      style: TextStyle(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 24, 190, 29),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(UserAuthController.instance.user?.email)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error retrieving name');
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data?.data() as Map<String, dynamic>;
                    final firstName = data['first_name'] ?? '';
                    final lastName = data['last_name'] ?? '';
                    final fullName = '$firstName $lastName';

                    return Text(
                      fullName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  }

                  return const Text('Loading name');
                },
              ),
              accountEmail: Text(UserAuthController.instance.user?.email ?? ''),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 232, 228, 228),
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 125, 123, 123),
                  size: 35,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 93, 172, 96),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('Verify Swimmers'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminSwimmerPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.grass),
              title: const Text('add swimmer'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddSwimmerPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts_rounded),
              title: const Text('Manage Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}