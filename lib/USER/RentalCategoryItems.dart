import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Items extends StatefulWidget {
  final String rental_id;
  final String category;

  const Items({required this.rental_id, required this.category, Key? key}) : super(key: key);

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
            .where('rental_id', isEqualTo: widget.rental_id)
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
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var imageUrl = snapshot.data!.docs[index]['image_url'];
              var description = snapshot.data!.docs[index]['description'];
              var rate = snapshot.data!.docs[index]['rate'];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullImageView(
                        imageUrl: imageUrl,
                        description: description,
                        rate: rate,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(description),
                    SizedBox(height: 4),
                    Text('Rate: $rate'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FullImageView extends StatefulWidget {
  final String imageUrl;
  final String description;
  final double rate;

  const FullImageView({
    required this.imageUrl,
    required this.description,
    required this.rate,
  });

  @override
  _FullImageViewState createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  bool _showPayAmountButton = false;
  bool _showBookNowButton = false;
  late String _userId;

  @override
  void initState() {
    super.initState();
    // Initialize selected date and time with current values
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _loadUserId();
  }

  void _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id') ?? ''; // Change 'user_id' to your preference
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.network(widget.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Rate: ${widget.rate}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      title: Text('Book Now'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description: ${widget.description}'),
                          SizedBox(height: 8),
                          Text('Rate: ${widget.rate}'),
                          SizedBox(height: 8),
                          Text('Select Date: $_selectedDate'),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 365)),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                  _showPayAmountButton = true;
                                });
                              }
                            },
                            child: Text('Select Date'),
                          ),
                          SizedBox(height: 8),
                          Text('Select Time: $_selectedTime'),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedTime = await showTimePicker(
                                context: context,
                                initialTime: _selectedTime,
                              );
                              if (selectedTime != null) {
                                setState(() {
                                  _selectedTime = selectedTime;
                                  _showBookNowButton = true;
                                });
                              }
                            },
                            child: Text('Select Time'),
                          ),
                        ],
                      ),
                      actions: [
                        if (_showPayAmountButton)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showBookNowButton = true;
                              });
                            },
                            child: Text('Pay Amount'),
                          ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        if (_showBookNowButton)
                          ElevatedButton(
                            onPressed: () {
                              // Implement booking logic here
                              // For example, save booking to Firestore
                              FirebaseFirestore.instance.collection('rental_booking').add({
                                'imageUrl': widget.imageUrl,
                                'description': widget.description,
                                'rate': widget.rate,
                                'date': _selectedDate.toString(),
                                'time': _selectedTime.format(context),
                                'user_id': _userId,
                              });
                              Navigator.of(context).pop();
                              // Show a success message or navigate to a confirmation screen
                            },
                            child: Text('Book Now'),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
            child: Text('Book Now'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
