import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DesignerFullProfile extends StatefulWidget {
  final String designer_id;
  const DesignerFullProfile({Key? key, required this.designer_id, }) : super(key: key);

  @override
  State<DesignerFullProfile> createState() => _DesignerFullProfileState();
}

class _DesignerFullProfileState extends State<DesignerFullProfile> {
  late Future<DocumentSnapshot> _designerFuture;

  @override
  void initState() {
    super.initState();
  //  _getDesignerData();
  }

 Future<DocumentSnapshot> _getDesignerData() async {
  try {
    print(widget.designer_id);
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('designer register')
        .doc(widget.designer_id)
        .get();
    return documentSnapshot;
  } catch (e) {
    print('Error fetching designer data: $e');
    throw e; // Re-throw the error to handle it in the UI
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getDesignerData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == null || !snapshot.data!.exists) {
              return Center(child: Text('No data found'));
            }
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
             String imageUrl = data['image_url'] ?? ''; 
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:NetworkImage(imageUrl),
                    ),
                    SizedBox(height: 30),
                    Text('Name: ${data['name']}'),
                    SizedBox(height: 20),
                    Text('Email: ${data['email']}'),
                    SizedBox(height: 20),
                    Text('Gender: ${data['gender']}'),
                    SizedBox(height: 20),
                    Text('Address: ${data['address']}'),
                    SizedBox(height: 20),
                    Text('Experience: ${data['experience']} years'),
                    SizedBox(height: 20),
                    Text('State: ${data['state']}'),
                    SizedBox(height: 20),
                    Text('Phone No: ${data['phone']}'),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text(
                        'BLOCK',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
