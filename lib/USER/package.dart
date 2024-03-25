import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/booking.dart';

class UserPckg extends StatefulWidget {
  final String designer_id; // Designer ID received from the previous screen

  const UserPckg({Key? key, required this.designer_id}) : super(key: key);

  @override
  State<UserPckg> createState() => _UserPckgState();
}

class _UserPckgState extends State<UserPckg> {
  List<DocumentSnapshot> _packages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(' designer_package ')
          .where('package_id', isEqualTo: widget.designer_id)
          .get();
      setState(() {
        _packages = snapshot.docs;
        _isLoading = false;
      });
      print(_packages);
      print('Number of packages: ${_packages.length}');
      // Print details of each package
      _packages.forEach((package) {
        print('Package name: ${package['package']}');
        print('Description: ${package['description']}');
      });
    } catch (error) {
      print('Error loading packages: $error');
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
            padding: const EdgeInsets.only(right: 60),
            child: Text(
              'PACKAGES',
              style: TextStyle(color: Color.fromARGB(221, 87, 4, 80)),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DesignerWork(designer_id: widget.designer_id);
                        },
                      ),
                    );
                  },
                  child: Text(
                    'WORKS',
                    style:
                        TextStyle(color: const Color.fromARGB(255, 15, 15, 15)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'PACKAGES',
                    style: TextStyle(color: Color.fromARGB(221, 75, 2, 82)),
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
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _packages.isEmpty
                    ? Center(child: Text('No packages available'))
                    : ListView.builder(
                        itemCount: _packages.length,
                        itemBuilder: (context, index) {
                          var package = _packages[index];
                          var package_id=package.id;
                          print('________________$package_id');
                          var a = index % 2;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Booked(
                                      provider_id: widget.designer_id,
                                      package_id: package_id,
                                      type: 'designer',
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: a == 0
                                      ? Color.fromARGB(255, 204, 193, 200)
                                      : Color.fromRGBO(179, 124, 154, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset('Assets/image1.jpg'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 150,
                                            child: Text(
                                              package['package'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            package['description'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
