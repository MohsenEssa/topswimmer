import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SwimmerPage extends StatefulWidget {
  const SwimmerPage({super.key});

  @override
  _SwimmerPageState createState() => _SwimmerPageState();
}

class _SwimmerPageState extends State<SwimmerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String currentUserId;
  late String currentUserEmail;
  List<Map<String, dynamic>>? swimmers = [];
  List<Map<String, dynamic>>? filteredSwimmers = [];
  Set<String> ownedSwimmerIds = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSwimmers();
    getCurrentUserEmail();
    fetchOwnedSwimmerIds();
  }

  void getCurrentUserEmail() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        currentUserEmail = user.email ?? "";
      });
    }
  }

  Widget buildSwimmerImage(String imageUrl) {
    return SizedBox(
      width: 100, // Set the desired width for the image
      height: 100, // Set the desired height for the image
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> fetchSwimmers() async {
    try {
      setState(() {
        isLoading = true;
      });

      final QuerySnapshot snapshot = await _firestore
          .collection('swimmers')
          .where('Verified', isEqualTo: true)
          .get();
      final List<Map<String, dynamic>> fetchedSwimmers = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      setState(() {
        swimmers = fetchedSwimmers;
        filteredSwimmers = swimmers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching swimmers: $e');
    }
  }

  Future<void> fetchOwnedSwimmerIds() async {
    final userRef = _firestore.collection('users').doc(currentUserEmail);

    try {
      final DocumentSnapshot snapshot = await userRef.get();
      final data = snapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('ownedSwimmers')) {
        setState(() {
          ownedSwimmerIds = Set.from(data['ownedSwimmers'] ?? []);
        });
      }
    } catch (e) {
      debugPrint('Error fetching ownedSwimmerIds: $e');
    }
  }

  void filterSwimmers(String query) {
    setState(() {
      filteredSwimmers = swimmers
          ?.where((swimmer) =>
              swimmer['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> updateOwnedSwimmerIds(String swimmerId, bool isChecked) async {
    setState(() {
      if (isChecked) {
        ownedSwimmerIds.add(swimmerId);
      } else {
        ownedSwimmerIds.remove(swimmerId);
      }
    });

    final userRef = _firestore.collection('users').doc(currentUserEmail);

    try {
      await userRef.update({'ownedSwimmers': ownedSwimmerIds.toList()});
      debugPrint('Successfully updated ownedSwimmers field.');
    } catch (e) {
      debugPrint('Error updating ownedSwimmers field: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Swimmers',
          style: TextStyle(color: Colors.green, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterSwimmers,
              decoration: InputDecoration(
                fillColor: Colors.green,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                prefixIcon: const Icon(
                  Icons.search, // Set the search icon
                  color: Colors.white, // Set the icon color
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: filteredSwimmers?.length ?? 0,
                    itemBuilder: (context, index) {
                      final swimmer = filteredSwimmers?[index];
                      final swimmerId = swimmer?['id'];

                      return Card(
                        child: ListTile(
                          leading: buildSwimmerImage(swimmer?['imageUrl'] ?? ''),
                          title: Text(swimmer?['name'] ?? ''),
                          subtitle: Text(
                            swimmer?['description']?.substring(0, 171) ?? '',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Stack(
                                children: [
                                  // Background overlay
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  // Dialog content
                                  AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.zero,
                                    content: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            swimmer?['name'] as String,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10.0),
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                swimmer?['imageUrl'] as String,
                                                width: 300.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            swimmer?['description'] as String,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          side: const BorderSide(
                                              color: Colors.green),
                                        ),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ],
                                    elevation: 0,
                                  ),
                                ],
                              ),
                            );
                          },
                          trailing: Checkbox(
                            value: ownedSwimmerIds.contains(swimmerId),
                            onChanged: (isChecked) {
                              if (isChecked != null) {
                                updateOwnedSwimmerIds(swimmerId!, isChecked);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}