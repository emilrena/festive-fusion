import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Items extends StatefulWidget {
  final String rentalId;
  final String category;

  const Items({required this.rentalId, required this.category, Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items - ${widget.category}'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rental_upload_image')
            .where('rental_id', isEqualTo: widget.rentalId)
            .where('category', isEqualTo: widget.category)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No images available'));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var imageUrl = snapshot.data!.docs[index]['image_url'];
              return Image.network(imageUrl);
            },
          );
        },
      ),
    );
  }
}
