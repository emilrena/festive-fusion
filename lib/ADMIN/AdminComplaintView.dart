import 'package:flutter/material.dart';

class ComplaintView extends StatefulWidget {
  const ComplaintView({Key? key});

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ENQUIRIES', style: TextStyle(color: Colors.deepPurpleAccent)),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 224, 206, 221),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Type your ComplaintView here',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                         Navigator.pop(context);
                      },
                      icon: Icon(Icons.remove_red_eye), // Provide an icon here
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
