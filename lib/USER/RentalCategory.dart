import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/RentalCategoryItems.dart';

class RentalCategory extends StatefulWidget {
  final String rental_id;

  const RentalCategory({Key? key, required this.rental_id}) : super(key: key);

  @override
  _RentalCategoryState createState() => _RentalCategoryState();
}

class _RentalCategoryState extends State<RentalCategory> {
  List<String> categories = ['Jewellery', 'Bridal Dress', 'Groom Dress'];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = categories[index];
                  });
                  _showItemDialog(selectedCategory!);
                },
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.category, size: 32.0),
                      SizedBox(width: 16.0),
                      Text(
                        categories[index],
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showItemDialog(String category) {
    List<String> items = [];
    switch (category) {
      case 'Jewellery':
        items = ['Choker', 'Earring', 'Bangles'];
        break;
      case 'Bridal Dress':
        items = ['Gown', 'Lehenga', 'Saree'];
        break;
      case 'Groom Dress':
        items = ['Suit', 'Sherwani', 'Kurta'];
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: items.map((item) {
                return GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Items(
                          rental_id: widget.rental_id,
                          category: selectedCategory!,
                          item: item,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
