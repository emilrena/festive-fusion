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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFESSIONALS'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: search,
                style: TextStyle(fontSize: 8),
                decoration: InputDecoration(
                  labelText: 'SEARCH',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final designerData = snapshot.data![index]['designerData'];
                        final rating = snapshot.data![index]['rating'];
                        final imageUrl = designerData['image_url'];

                        return ListTile(
                          onTap: () {},
                          title: Text(designerData['name'] ?? 'Name not available'),
                          subtitle: SizedBox(
                            width: 5,
                            child: RatingBar.builder(
                              itemSize: 20,
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 3,
                                color: Color.fromARGB(255, 124, 4, 94),
                              ),
                              onRatingUpdate: (_) {
                                // Do nothing, rating is not editable
                              },
                            ),
                          ),
                          leading: imageUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(imageUrl),
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  child: Icon(Icons.person),
                                  radius: 30,
                                ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DesignerWork(
                                    designer_id: snapshot.data![index]['designerId'],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: Text(
                              'CHOOSE',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 231, 234, 236),
                                fontSize: 10,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
