import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Makeup/Makeup_message.dart';
import 'package:festive_fusion/USER/MakeupPackages.dart';

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class MakeupWorkView extends StatefulWidget {
  final String makeup_id;
  const MakeupWorkView({Key? key, required this.makeup_id}) : super(key: key);

  @override
  State<MakeupWorkView> createState() => _MakeupWorkViewState();
}

class _MakeupWorkViewState extends State<MakeupWorkView> {
  late List<String> _imageUrls;
  bool _isLoading = false;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final makeupSnapshot = await FirebaseFirestore.instance
          .collection('Makeup_register')
          .doc(widget.makeup_id)
          .get();

      if (makeupSnapshot.exists) {
        setState(() {
          _profileImageUrl = makeupSnapshot['image_url'];
        });
      }

      final imageSnapshot = await FirebaseFirestore.instance
          .collection('makeup_upload_image')
          .where('makeup_id', isEqualTo: widget.makeup_id)
          .get();
      setState(() {
        _imageUrls =
            imageSnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      });
    } catch (error) {
      print('Error loading images: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(
              'WORK',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : AssetImage('Assets/p3.jpg') as ImageProvider,
                  radius: 30,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'WORKS',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MakeupPackages(makeup_id: widget.makeup_id);
                      }),
                    );
                  },
                  child: Text(
                    'PACKAGES',
                    style: TextStyle(color: Colors.black87),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ResponsiveGridList(
                    desiredItemWidth: 150,
                    minSpacing: 10,
                    children: _imageUrls.map((imageUrl) {
                      return Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          )
        ],
      ),
    );
  }
}
