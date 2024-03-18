import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/USER/package.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DesignerWork extends StatefulWidget {
  const DesignerWork({Key? key}) : super(key: key);

  @override
  State<DesignerWork> createState() => _DesignerWorkState();
}

class _DesignerWorkState extends State<DesignerWork> {
  late List<String> _imageUrls;
  bool _isLoading = false;

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
      final snapshot =
          await FirebaseFirestore.instance.collection('designer_upload_image').get();
      setState(() {
        _imageUrls = snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
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
                  backgroundImage: AssetImage('Assets/p3.jpg'),
                  radius: 30,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Message();
                      }),
                    );
                  },
                  icon: Icon(Icons.message),
                )
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
                        return UserPckg();
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
