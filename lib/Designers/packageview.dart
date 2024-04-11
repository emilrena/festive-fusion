import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/packageadd.dart';
import 'package:flutter/material.dart';

class Vservice extends StatefulWidget {
  const Vservice({Key? key}) : super(key: key);

  @override
  State<Vservice> createState() => _VserviceState();
}

class _VserviceState extends State<Vservice> {
  TextEditingController _packageNameController = TextEditingController();
  TextEditingController _packageDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGES')),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
             .collection(' designer_package ')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<DocumentSnapshot> packages = snapshot.data!.docs;

            return ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final document = packages[index];
                final documentId = document.id;
                final packageData = document.data() as Map<String, dynamic>;
                final packageName = packageData['package'] ?? '';
                final packageDescription = packageData['description'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 204, 193, 200),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          packageName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          packageDescription,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => _buildEditDialog(
                                      context,
                                      documentId,
                                      packageName,
                                      packageDescription),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete Package'),
                                      content: Text(
                                          'Are you sure you want to delete this package?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deletePackage(documentId);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return package_add();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEditDialog(BuildContext context, String documentId,
      String packageName, String packageDescription) {
    _packageNameController.text = packageName;
    _packageDescriptionController.text = packageDescription;

    return AlertDialog(
      title: Text('Edit Package'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _packageNameController,
            decoration: InputDecoration(labelText: 'Package Name'),
          ),
          TextField(
            controller: _packageDescriptionController,
            decoration: InputDecoration(labelText: 'Package Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            updatePackage(documentId);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Future<void> deletePackage(String documentId) async {
    try {
      await FirebaseFirestore.instance
           .collection(' designer_package ')
          .doc(documentId)
          .delete();
      print('Package deleted successfully.');
    } catch (e) {
      print('Error deleting package: $e');
    }
  }

  Future<void> updatePackage(String documentId) async {
    try {
      await FirebaseFirestore.instance
           .collection(' designer_package ')
          .doc(documentId)
          .update({
        'package': _packageNameController.text,
        'description': _packageDescriptionController.text,
      });
      print('Package updated successfully.');
    } catch (e) {
      print('Error updating package: $e');
    }
  }
}
