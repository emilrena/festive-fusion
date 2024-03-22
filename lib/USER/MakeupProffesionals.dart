import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/MakeupWork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MakeupProffesional_View extends StatefulWidget {
  const MakeupProffesional_View({Key? key}) : super(key: key);

  @override
  State<MakeupProffesional_View> createState() =>
      _MakeupProffesional_ViewState();
}

class _MakeupProffesional_ViewState
    extends State<MakeupProffesional_View> {
  var search = TextEditingController();

  // Function to fetch data from Firestore
  Future<List<DocumentSnapshot>> getData() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Makeup register')
          .get();
      print('Fetched ${snapshot.docs.length} documents');
      return snapshot.docs;
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
              child: FutureBuilder(
                future: getData(),
                builder: (context,
                    AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final document = snapshot.data![index];
                        final data =
                            document.data() as Map<String, dynamic>;
                        final imageUrl = data['image_url']; 
                        return ListTile(
                          onTap: () {},
                          title: Text(data['name'] ?? 'Name not available'),
                          subtitle: SizedBox(
                            width: 5,
                            child: RatingBar.builder(
                              itemSize: 20,
                              initialRating:
                                  (data['rating'] ?? 0).toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 3,
                                color: Color.fromARGB(255, 124, 4, 94),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
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
                                  builder: (context) => MakeupWorkView(),
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
                                color:
                                    const Color.fromARGB(255, 231, 234, 236),
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
