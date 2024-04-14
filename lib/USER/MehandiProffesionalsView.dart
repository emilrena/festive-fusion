import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/MehandiWork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MehandiProffesional_View extends StatefulWidget {
  const MehandiProffesional_View({Key? key}) : super(key: key);

  @override
  State<MehandiProffesional_View> createState() =>
      _MehandiProffesional_ViewState();
}

class _MehandiProffesional_ViewState
    extends State<MehandiProffesional_View> {
  var search = TextEditingController();

 late List<Map<String, dynamic>> mehandi = [];
  late List<Map<String, dynamic>> filteredmehandi = [];

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        mehandi = value;
        filteredmehandi = mehandi;
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
      final mehandiSnapshot = await FirebaseFirestore.instance
          .collection('Mehandi register')
          .get();

      // Fetch feedback ratings for each designer
      final List<Map<String, dynamic>> mehandiWithRatings = [];
      for (final mehandiDoc in mehandiSnapshot.docs) {
        final mehandiData = mehandiDoc.data() as Map<String, dynamic>;
        final mehandiId = mehandiDoc.id;

        final feedbackSnapshot = await FirebaseFirestore.instance
            .collection('feedback')
          .where('type', isEqualTo: 'mehandi')
          .where('provider_id', isEqualTo: mehandiId)
          .get();
        final averageRating = calculateAverageRating(feedbackSnapshot);

        mehandiWithRatings.add({
          'mehandiId': mehandiId,
          'mehandiData': mehandiData,
          'rating': averageRating,
        });
      }

      return mehandiWithRatings;
    } catch (e) {
      print('Error fetching data: $e');
      throw e; // Rethrow the error to handle it in the FutureBuilder
    }
  }

  // Function to filter designers based on search query
  void filtermehandi(String query) {
    setState(() {
      filteredmehandi = mehandi
          .where((mehandi) =>
              mehandi['mehandiData']['name']
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
                  filtermehandi(value);
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
                itemCount: filteredmehandi.length,
                itemBuilder: (context, index) {
                  final mehandiData = filteredmehandi[index]['mehandiData'];
                  final rating = filteredmehandi[index]['rating'];
                  final imageUrl = mehandiData['image_url'];

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
                        mehandiData['name'] ?? 'Name not available',
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
                              builder: (context) => MehandiWorkView(
                                mehandi_id: filteredmehandi[index]['mehandiId'],
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
