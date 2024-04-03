import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/MehandiPackage.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/USER/mehandiEnquiry.dart';
import 'package:festive_fusion/mehandi/Mehandi_message.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class MehandiWorkView extends StatefulWidget {
  final String mehandi_id; 
  const MehandiWorkView({Key? key, required this.mehandi_id, }) : super(key: key);

  @override
  State<MehandiWorkView> createState() => _MehandiWorkViewState();
}

class _MehandiWorkViewState extends State<MehandiWorkView> {
  @override

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
    print('.........................');
    final snapshot = await FirebaseFirestore.instance
        .collection('mehandi_upload_image')
        .where('mehandi_id', isEqualTo: widget.mehandi_id)
        .get();
    setState(() {
      _imageUrls = snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      print(_imageUrls);
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
                        return User_Mehandi_Message();
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
                        print(widget.mehandi_id);
                        return MehandiPackages(mehandi_id: widget.mehandi_id,);
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
