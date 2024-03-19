
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:festive_fusion/Designers/EditService.dart';
import 'package:festive_fusion/Designers/packageadd.dart';

class Vservice extends StatefulWidget {
  const Vservice({Key? key}) : super(key: key);

  @override
  State<Vservice> createState() => _VserviceState();
}

class _VserviceState extends State<Vservice> {
  late Future<List<Map<String, dynamic>>> _packagesFuture;



   Future<List<DocumentSnapshot>> getPackages() async {
    try {
final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('designer register')
          .get();      
          print('_______________________${snapshot.docs}');
    



      return snapshot.docs;
    } catch (e) {
      print('Error fetching packages: $e');
      throw e; // Re-throw the error to handle it in the UI
    }
  }


  Map<String, dynamic> extractPackageData(QueryDocumentSnapshot snapshot) {
    // Extract package data from the snapshot and return it as a map
    Map<String, dynamic> packageData = snapshot.data() as Map<String, dynamic>;
    return packageData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGES')),
      ),
      body: FutureBuilder(
        future: getPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
             itemCount: snapshot.data?.length ?? 0,
             
                      itemBuilder: (context, index) {
                        final document = snapshot.data![index];
                        final id = snapshot.data![index].id;
                       print(document);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 204, 193, 200),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                // Handle delete action
                              },
                              child: Icon(Icons.delete),
                            ),
                            SizedBox(height: 50),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     // Pass the package data to EditServices widget
                                //     return EditServices_(packageData: id);
                                //   }),
                                // );
                              },
                              child: Icon(Icons.change_circle),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return package_add();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
