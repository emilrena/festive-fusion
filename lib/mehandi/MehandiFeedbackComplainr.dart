import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mehandiresponce extends StatefulWidget {
  const Mehandiresponce({Key? key}) : super(key: key);

  @override
  State<Mehandiresponce> createState() => _MehandiresponceState();
}

class _MehandiresponceState extends State<Mehandiresponce> {
  late String loggedInUserId;

  @override
  void initState() {
    super.initState();
    // Fetch logged-in user's UID from SharedPreferences
    fetchLoggedInUserId();
  }

  Future<void> fetchLoggedInUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserId = prefs.getString('uid') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Feedback & Complaints'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Rating'),
              Tab(text: 'Complaints'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab: Rating
            FutureBuilder(
              future: fetchRatings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Display fetched ratings
                  List<DocumentSnapshot> ratings = snapshot.data as List<DocumentSnapshot>;
                  return ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      final rating = ratings[index].data() as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Icon(Icons.star, color: Colors.amber), // Rating icon
                          title: Text('Rating: ${rating['rating']}'),
                          subtitle: Text('Name: ${rating['name']}'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // Second tab: Complaints
            FutureBuilder(
              future: fetchComplaints(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Display fetched complaints
                  List<DocumentSnapshot> complaints = snapshot.data as List<DocumentSnapshot>;
                  return ListView.builder(
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaints[index].data() as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Icon(Icons.report, color: Colors.red), // Complaint icon
                          title: Text('Complaint: ${complaint['complaint']}'),
                          subtitle: Text('Name: ${complaint['name']}'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchRatings() async {
    try {
      // Fetch ratings where type is "designer" and provider_id matches the logged-in user's UID
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('type', isEqualTo: 'mehandi')
          .where('provider_id', isEqualTo: loggedInUserId)
          .get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching ratings: $e');
      return [];
    }
  }

  Future<List<DocumentSnapshot>> fetchComplaints() async {
    try {
      // Fetch complaints where type is "designer" and provider_id matches the logged-in user's UID
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .where('type', isEqualTo: 'mehandi')
          .where('provider_id', isEqualTo: loggedInUserId)
          .get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching complaints: $e');
      return [];
    }
  }
}
