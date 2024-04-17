import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/Rental/Rental_Message.dart';
import 'package:festive_fusion/Rental/Rental_UploadImage.dart';

class RentHome extends StatefulWidget {
  const RentHome({Key? key}) : super(key: key);

  @override
  _RentHomeState createState() => _RentHomeState();
}

class _RentHomeState extends State<RentHome> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _userId;
  String? _userName;
  dynamic _userImageUrl;
  List<String> _imageUrls = [];
  List<String> _descriptions = [];
  List<String> _items = [];
  List<double> _rates = [];
  List<int> _counts = [];
  bool _isLoading = false;
  late String _selectedCategory = 'Bridal Dress'; // Default to Bridal Dress
  late String _selectedDressCategory = 'Gown'; // Default to Gown

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadImages();
  }

 Future<void> _loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _userId = prefs.getString('uid');
    _userName = prefs.getString('name');
  });

  // Fetch user data from Firestore
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('rental_register')
        .doc(_userId)
        .get();

    if (userSnapshot.exists) {
      setState(() {
        _userImageUrl = NetworkImage(userSnapshot['image_url']);
      });
    } else {
      // If user document doesn't exist, set default image
      setState(() {
        _userImageUrl = AssetImage('Assets/p4.jpg');
      });
    }
  } catch (error) {
    print('Error loading user data: $error');
    // Set default image in case of error
    setState(() {
      _userImageUrl = AssetImage('Assets/p4.jpg');
    });
  }
}

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (_image != null && await _image!.exists()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Rental_Upload_pic(imageFile: _image!),
          ),
        );
      } else {
        print('Image file does not exist or is invalid.');
      }
    } else {
      print('No image picked.');
    }
  }

  void _navigateToRentalMessagePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Rental_Message(),
      ),
    );
  }

  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('rental_upload_image')
          .where('rental_id', isEqualTo: _userId)
          .where('category', isEqualTo: _selectedCategory)
          .where('item', isEqualTo: _selectedDressCategory)
          .get();

      setState(() {
        _imageUrls = snapshot.docs.map((doc) => doc['image_url'] as String).toList();
        _descriptions = snapshot.docs.map((doc) => doc['description'] as String).toList();
        _items = snapshot.docs.map((doc) => doc['item'] as String).toList();
        _rates = snapshot.docs.map((doc) => doc['rate'] as double).toList();
        _counts = snapshot.docs.map((doc) => doc['count'] as int).toList(); // Fetch count
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
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.deepPurple),
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
                _showDressCategoryOptionsDialog(context);
              },
            ),
            ListTile(
              title: Text('Groom Dress'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Groom Dress';
                });
                _showDressCategoryOptionsDialog(context);
              },
            ),
            ListTile(
              title: Text('Jewellary'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Jewellery';
                });
                _showDressCategoryOptionsDialog(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: _userImageUrl,
                        radius: 35,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _userName ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('Upload Image'),
                ),
                ElevatedButton(
                  onPressed: _navigateToRentalMessagePage,
                  child: Text('Enquiry'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _imageUrls.isEmpty
                      ? Center(child: Text('No images available'))
                      : SingleChildScrollView(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              _imageUrls.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  _showImageDetails(context, index);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 3 -
                                          20,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        _imageUrls[index],
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteImage(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDressCategoryOptionsDialog(BuildContext context) async {
    List<String> dressOptions = [];

    switch (_selectedCategory) {
      case 'Jewellery':
        dressOptions = ['Choker', 'Earring', 'Bangles'];
        break;
      case 'Bridal Dress':
        dressOptions = ['Gown', 'Lehenga', 'Saree'];
        break;
      case 'Groom Dress':
        dressOptions = ['Suit', 'Sherwani', 'Kurta'];
        break;
      // Add more cases for additional categories if needed
      default:
        dressOptions = [];
        break;
    }

    String? selectedDressCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Dress Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: dressOptions.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  Navigator.pop(context, option);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedDressCategory != null) {
      setState(() {
        _selectedDressCategory = selectedDressCategory;
        _loadImages();
      });
    }
  }

  void _showImageDetails(BuildContext context, int index) async {
    DocumentSnapshot? snapshot = await _fetchImageCount(index);
    showDialog(
      context: context,
      builder: (context) => ImageDetailsDialog(
        imageUrl: _imageUrls[index],
        description: _descriptions[index],
        item: _items[index],
        rate: _rates[index],
        count: snapshot != null ? (snapshot['count'] as double).toInt() : 0, // Convert double to int
        onDelete: () {
          _deleteImage(index);
          Navigator.pop(context);
        },
      ),
    );
  }

 Future<DocumentSnapshot?> _fetchImageCount(int index) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('rental_upload_image')
        .where('image_url', isEqualTo: _imageUrls[index])
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0];
    } else {
      return null;
    }
  } catch (error) {
    print('Error fetching image count: $error');
    return null;
  }
}

  void _deleteImage(int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('rental_upload_image')
          .where('image_url', isEqualTo: _imageUrls[index])
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
      setState(() {
        _imageUrls.removeAt(index);
        _descriptions.removeAt(index);
        _items.removeAt(index);
        _rates.removeAt(index);
        _counts.removeAt(index);
      });
    } catch (error) {
      print('Error deleting image: $error');
    }
  }
}

class ImageDetailsDialog extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String item;
  final double rate;
  final int count;
  final Function()? onDelete;

  const ImageDetailsDialog({
    required this.imageUrl,
    required this.description,
    required this.item,
    required this.rate,
    required this.count,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain, // Adjust fit as needed
                width: MediaQuery.of(context).size.width * 0.9, // Adjust width to fit dialog
                height: MediaQuery.of(context).size.height * 0.6, // Adjust height to fit dialog
              ),
            ),
            SizedBox(height: 10),
            Text('Description: $description'),
            Text('Item: $item'),
            Text('Rate: $rate'),
            Text('Count: $count'),
            if (onDelete != null)
              ElevatedButton(
                onPressed: onDelete,
                child: Text('Delete Image'),
              ),
          ],
        ),
      ),
    );
  }
}
