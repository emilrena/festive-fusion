import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintView extends StatelessWidget {
  const ComplaintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ENQUIRIES',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No complaints found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot complaintSnapshot = snapshot.data!.docs[index];
              Map<String, dynamic> complaintData = complaintSnapshot.data() as Map<String, dynamic>;
              String type = complaintData['type'];
              String providerId = complaintData['provider_id'];

              return FutureBuilder<DocumentSnapshot>(
                future: _fetchProviderDetails(type, providerId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return ListTile(
                      title: Text('Provider details not found.'),
                    );
                  }

                  Map<String, dynamic> providerData = snapshot.data!.data() as Map<String, dynamic>;
                  String providerName = providerData['name'];

                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text(
                        'Category: ${complaintData['type']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complaint: ${complaintData['complaint']}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Complaint about: $providerName',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot> _fetchProviderDetails(String type, String providerId) async {
    String collectionName;

    switch (type) {
      case 'designer':
        collectionName = 'designer register';
        break;
      case 'mehandi':
        collectionName = 'Mehandi register';
        break;
      case 'makeup':
        collectionName = 'Makeup register';
        break;
      case 'rental':
        collectionName = 'rental_register';
        break;
      default:
        // Handle other types here if needed
        return Future.value(null);
    }

    return await FirebaseFirestore.instance.collection(collectionName).doc(providerId).get();
  }
}
