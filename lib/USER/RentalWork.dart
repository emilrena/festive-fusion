import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Rental/Rental_Message.dart';
import 'package:festive_fusion/USER/RentalCategory.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class RentalWorkView extends StatefulWidget {
  final String rental_id; 
  const RentalWorkView({Key? key, required this.rental_id}) : super(key: key);

  @override
  State<RentalWorkView> createState() => _RentalWorkViewState();
}

class _RentalWorkViewState extends State<RentalWorkView> {
  late List<String> _image_urls;
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
      final snapshot = await FirebaseFirestore.instance
          .collection('rental_upload_image')
          .where('rental_id', isEqualTo: widget.rental_id)
          .get();
          
      setState(() {
        _image_urls = snapshot.docs.map((doc) => doc['image_url'] as String).toList();
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
            child: Text('WORK',style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(left: 30),
             child: Row(mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 CircleAvatar(backgroundImage: AssetImage('Assets/p3.jpg'),radius: 30,),
                //  IconButton(onPressed: (){
                //   Navigator.push(context, MaterialPageRoute(builder:(context) {
                //             return Rental_Message();
                //           },));
                //  }, icon: Icon(Icons.message))
               ],
             ),
           ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('WORKS',style: TextStyle(color: Colors.deepPurple),
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
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                              return RentalCategory(rental_id: widget.rental_id,);
                            },));
                  },
                  child: Text('CATEGORY ',style: TextStyle(color: Colors.black87),
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
          SizedBox(height: 10,),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (_image_urls != null && _image_urls.isNotEmpty)
                    ? ResponsiveGridList(
                        desiredItemWidth: 150,
                        minSpacing: 10,
                        children: _image_urls.map((image_url) {
                          return Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image_url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: Text("No images to display."),
                      ),
          )
        ],
      ),
    );
  }
}
