import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/CHAT.DART';

import 'package:festive_fusion/USER/package.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignerWork extends StatefulWidget {
  final String designer_id;

  const DesignerWork({
    Key? key,
    required this.designer_id,
  }) : super(key: key);

  @override
  State<DesignerWork> createState() => _DesignerWorkState();
}

class _DesignerWorkState extends State<DesignerWork> {
  late List<String> _imageUrls;
  bool _isLoading = false;
  late String _selectedCategory;
  late String _selectedDressCategory;
  String _designerImageUrl = '';
  late String _senderId;
  late Timestamp _timestamp;

  @override
  void initState() {
    super.initState();
    _selectedCategory = '';
    _selectedDressCategory = '';
    _loadImages();
    _loadDesignerImage();
    _getSenderId();
  }

  // Fetch senderId from shared preferences and include timestamp
  Future<void> _getSenderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    Timestamp timestamp =
        Timestamp.fromDate(currentTime); // Convert to Timestamp
    setState(() {
      _senderId = prefs.getString('uid') ?? ''; // assuming 'uid' is the key
      _timestamp = timestamp;
    });
  }

  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot snapshot;
      if (_selectedCategory.isNotEmpty && _selectedDressCategory.isNotEmpty) {
        snapshot = await FirebaseFirestore.instance
            .collection('designer_upload_image')
            .where('designer_id', isEqualTo: widget.designer_id)
            .where('category', isEqualTo: _selectedCategory)
            .where('dress', isEqualTo: _selectedDressCategory)
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('designer_upload_image')
            .where('designer_id', isEqualTo: widget.designer_id)
            .get();
      }

      setState(() {
        _imageUrls =
            snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      });
    } catch (error) {
      print('Error loading images: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDesignerImage() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('designer register')
          .doc(widget.designer_id)
          .get();

      if (snapshot.exists) {
        setState(() {
          _designerImageUrl = snapshot['image_url'];
        });
      }
    } catch (error) {
      print('Error loading designer image: $error');
    }
  }

  Future<void> _showDressCategoryOptionsDialog(BuildContext context) async {
    String? selectedDressCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Dress Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Haldi'),
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Bridal Dress';
                    _selectedDressCategory = 'haldi';
                  });
                  Navigator.pop(context, 'haldi');
                },
              ),
              ListTile(
                title: Text('Mehendi'),
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Bridal Dress';
                    _selectedDressCategory = 'Mehendi';
                  });
                  Navigator.pop(context, 'Mehendi');
                },
              ),
              ListTile(
                title: Text('Reception'),
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Bridal Dress';
                    _selectedDressCategory = 'Reception';
                  });
                  Navigator.pop(context, 'Reception');
                },
              ),
              ListTile(
                title: Text('Wedding'),
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Bridal Dress';
                    _selectedDressCategory = 'Wedding';
                  });
                  Navigator.pop(context, 'Wedding');
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedDressCategory != null) {
      _loadImages();
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Select Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Bridal Dress'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Bridal Dress';
                });
                Navigator.pop(context);
                _showDressCategoryOptionsDialog(context);
              },
            ),
            ListTile(
              title: Text('Groom Dress'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Groom Dress';
                });
                Navigator.pop(context);
                _showDressCategoryOptionsDialog(context);
              },
            ),
          ],
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
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          receiverId: widget.designer_id,
                        ),
                      ),
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
                  onPressed: () {
                    _showDressCategoryOptionsDialog(context);
                  },
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
                        return UserPckg(designer_id: widget.designer_id);
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
