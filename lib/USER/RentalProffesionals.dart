import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/RentalWork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RentalProffesional_View extends StatefulWidget {
  const RentalProffesional_View({Key? key}) : super(key: key);

  @override
  State<RentalProffesional_View> createState() =>
      _RentalProffesional_ViewState();
}

class _RentalProffesional_ViewState
    extends State<RentalProffesional_View> {
  var search = TextEditingController();

  late List<Map<String, dynamic>> rental = [];
  late List<Map<String, dynamic>> filteredrental = [];

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        rental = value;
        filteredrental = rental;
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
      final rentalSnapshot = await FirebaseFirestore.instance
          .collection('Rental register')
          .get();

      // Fetch feedback ratings for each designer
      final List<Map<String, dynamic>> rentalWithRatings = [];
      for (final rentalDoc in rentalSnapshot.docs) {
        final rentalData = rentalDoc.data() as Map<String, dynamic>;
        final rentalId = rentalDoc.id;

        final feedbackSnapshot = await FirebaseFirestore.instance
            .collection('feedback')
          .where('type', isEqualTo: 'rental')
          .where('provider_id', isEqualTo: rentalId)
          .get();
        final averageRating = calculateAverageRating(feedbackSnapshot);

        rentalWithRatings.add({
          'rentalId': rentalId,
          'rentalData': rentalData,
          'rating': averageRating,
        });
      }

      return rentalWithRatings;
    } catch (e) {
      print('Error fetching data: $e');
      throw e; // Rethrow the error to handle it in the FutureBuilder
    }
  }

  // Function to filter designers based on search query
  void filterrental(String query) {
    setState(() {
      filteredrental = rental
          .where((rental) =>
              rental['rentalData']['name']
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
                  filterrental(value);
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
                itemCount: filteredrental.length,
                itemBuilder: (context, index) {
                  final rentalData = filteredrental[index]['rentalData'];
                  final rating = filteredrental[index]['rating'];
                  final imageUrl = rentalData['image_url'];

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
                        rentalData['name'] ?? 'Name not available',
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
                              builder: (context) => RentalWorkView(
                                rental_id: filteredrental[index]['rentalId'],
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
