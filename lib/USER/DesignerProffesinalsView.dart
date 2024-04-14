import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DesignerProffesional_View extends StatefulWidget {
  const DesignerProffesional_View({Key? key}) : super(key: key);

  @override
  State<DesignerProffesional_View> createState() =>
      _DesignerProffesional_ViewState();
}

class _DesignerProffesional_ViewState
    extends State<DesignerProffesional_View> {
  var search = TextEditingController();

  late List<Map<String, dynamic>> designers = [];
  late List<Map<String, dynamic>> filteredDesigners = [];

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        designers = value;
        filteredDesigners = designers;
      });
    });
  }

  // Function to calculate the average rating from feedback documents
  double calculateAverageRating(QuerySnapshot feedbackSnapshot) {
    if (feedbackSnapshot.docs.isEmpty) {
      return 0;
    }

    // Calculate the total rating and count of feedback documents
    double totalRating = 0;
    int feedbackCount = 0;

    for (final feedbackDoc in feedbackSnapshot.docs) {
      final rating = feedbackDoc['rating'];
      if (rating != null) {
        totalRating += (rating as num).toDouble();
        feedbackCount++;
      }
    }

    // Calculate and return the average rating
    return totalRating / feedbackCount;
  }

  // Function to fetch data from Firestore including feedback ratings
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final designerSnapshot = await FirebaseFirestore.instance
          .collection('designer register')
          .get();

      // Fetch feedback ratings for each designer
      final List<Map<String, dynamic>> designersWithRatings = [];
      for (final designerDoc in designerSnapshot.docs) {
        final designerData = designerDoc.data() as Map<String, dynamic>;
        final designerId = designerDoc.id;

        final feedbackSnapshot = await FirebaseFirestore.instance
            .collection('feedback')
          .where('type', isEqualTo: 'designer')
          .where('provider_id', isEqualTo: designerId)
          .get();
        final averageRating = calculateAverageRating(feedbackSnapshot);

        designersWithRatings.add({
          'designerId': designerId,
          'designerData': designerData,
          'rating': averageRating,
        });
      }

      return designersWithRatings;
    } catch (e) {
      print('Error fetching data: $e');
      throw e; // Rethrow the error to handle it in the FutureBuilder
    }
  }

  // Function to filter designers based on search query
  void filterDesigners(String query) {
    setState(() {
      filteredDesigners = designers
          .where((designer) =>
              designer['designerData']['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Professionals'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: search,
                onChanged: (value) {
                  filterDesigners(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDesigners.length,
                itemBuilder: (context, index) {
                  final designerData = filteredDesigners[index]['designerData'];
                  final rating = filteredDesigners[index]['rating'];
                  final imageUrl = designerData['image_url'];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        // Do nothing when tapping on the card
                      },
                      leading: CircleAvatar(
                        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : AssetImage('assets/default_avatar.png') as ImageProvider,
                        radius: 30.0,
                      ),
                      title: Text(
                        designerData['name'] ?? 'Name not available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          IgnorePointer(
                            ignoring: true,
                            child: RatingBar.builder(
                              itemSize: 20,
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 141, 43, 133),
                              ),
                              onRatingUpdate: (_) {
                                // Do nothing, rating is not editable
                              },
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DesignerWork(
                                designer_id: filteredDesigners[index]['designerId'],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          'Choose',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
