import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminSwimmerPage extends StatefulWidget {
  const AdminSwimmerPage({super.key});

  @override
  _SwimmerPageState createState() => _SwimmerPageState();
}

class _SwimmerPageState extends State<AdminSwimmerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> swimmers = [];
  List<Map<String, dynamic>> filteredSwimmers = [];
  Set<String> ownedSwimmerIds = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSwimmers();
    initializeOwnedSwimmerIds();
  }

  Future<void> initializeOwnedSwimmerIds() async {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      final userSwimmersRef =
          _firestore.collection('users').doc(userId).collection('User swimmers');
      final QuerySnapshot snapshot = await userSwimmersRef.get();
      final List<String> ownedIds = snapshot.docs.map((doc) => doc.id).toList();
      setState(() {
        ownedSwimmerIds = Set.from(ownedIds);
      });
    }
  }

  Future<void> fetchSwimmers() async {
    try {
      setState(() {
        isLoading = true;
      });

      final QuerySnapshot snapshot = await _firestore
          .collection('swimmers')
          .where('Verified', isEqualTo: false)
          .get();
      final List<Map<String, dynamic>> fetchedSwimmers = snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Include the document ID
        return data;
      }).toList();
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

  void changeVerifiedStatus(String swimmerId, bool newStatus) async {
    try {
      await _firestore
          .collection('swimmers')
          .doc(swimmerId)
          .update({'Verified': newStatus});
      fetchSwimmers(); // Fetch updated swimmers after the change
    } catch (e) {
      debugPrint('Error changing verified status: $e');
    }
  }

  void deleteSwimmer(String swimmerId) async {
    try {
      await _firestore.collection('swimmers').doc(swimmerId).delete();
      fetchSwimmers(); // Fetch updated swimmers after the deletion
    } catch (e) {
      debugPrint('Error deleting swimmer: $e');
    }
  }

  void filterSwimmers(String query) {
    setState(() {
      filteredSwimmers = swimmers.where((swimmer) {
        final bool isNameMatch =
            swimmer['name'].toLowerCase().contains(query.toLowerCase());
        final bool isVerified = swimmer['Verified'] == false;
        return isNameMatch && isVerified;
      }).toList();
    });
  }

  Future<String?> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Swimmers',
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
                    itemCount: filteredSwimmers.length,
                    itemBuilder: (context, index) {
                      final swimmer = filteredSwimmers[index];
                      final swimmerId = swimmer['id'];

                      return Card(
                        child: ListTile(
                          leading: buildSwimmerImage(swimmer['imageUrl'] ?? ''),
                          title: Text(swimmer['name'] ?? ''),
                          subtitle: Text(
                            swimmer['description']?.substring(0, 171) ?? '',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.verified),
                                onPressed: () =>
                                    changeVerifiedStatus(swimmerId, true),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteSwimmer(swimmerId),
                              ),
                            ],
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