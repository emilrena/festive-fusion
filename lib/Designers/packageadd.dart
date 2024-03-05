import 'package:festive_fusion/Designers/DesignerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class package_add extends StatefulWidget {
  const package_add({Key? key});

  @override
  State<package_add> createState() => _package_addState();
}

class _package_addState extends State<package_add> {
  var PackageName=TextEditingController();
  var Description=TextEditingController();
   final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Stack(
        children: [
          Container(
             decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          ),
          SingleChildScrollView(
            child: Form(key: fkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(controller: PackageName,
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'field is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'service',
                        fillColor: Color.fromARGB(255, 182, 174, 196),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(controller: Description,
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'field is empty';
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Describe here',
                        fillColor: Color.fromARGB(255, 182, 174, 196),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (fkey.currentState!.validate()) {
                            print(PackageName.text);
                            print(Description.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DesignerHome();
                                },
                              ),
                            );
                          }},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 206, 197, 221),
                            ),
                          ),
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
