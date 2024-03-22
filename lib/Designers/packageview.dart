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
  late Future<List<DocumentSnapshot>> _packagesFuture;

 Future<List<DocumentSnapshot>> getPackages() async {
  try {
    print('..................');
     QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(' designer_package ')
        .get();
    
    print('Number of documents: ${snapshot.docs}');
    snapshot.docs.forEach((doc) {
      print('Document ID: ${doc.id}');
      print('Document data: ${doc.data()}');
    });
    
    return snapshot.docs;
  } catch (e) {
    print('Error fetching packages: $e');
    throw e; // Re-throw the error to handle it in the UI
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGES')),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
    final document = snapshot.data![index];
    final id = document.id;
    final packageData = document.data() as Map<String, dynamic>;
    print(packageData);
    final packageName = packageData['package'] ?? '';
    final packageDescription = packageData['description'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 204, 193, 200),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              packageName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              packageDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle delete action
                  },
                  icon: Icon(Icons.delete),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    // Navigate to EditService widget passing the package ID
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return EditServices_(packageData: id);
                    //   }),
                    // );
                  },
                  icon: Icon(Icons.change_circle),  
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
