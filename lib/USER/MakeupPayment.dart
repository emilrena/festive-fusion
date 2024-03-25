import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  final String provider_id;
  final String package_id;
  final String type;
  Payment({
    Key? key,
    required this.provider_id,
    required this.package_id,
    required this.type,
  }) : super(key: key);

  var Userid = TextEditingController();
  var balance = TextEditingController();

  final List<String> _list = ['FULL AMOUNT', 'ADVANCE',];
  final List<String> _list1 = ['GPAY', 'PHONEPAY',];
  final List<String> _list2 = ['GPAY', 'PHONEPAY', 'CASH ON DELIVERY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAYMENT'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Your additional content here',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Material(
                child: DropdownButtonFormField(
                  hint: Text('PAYMENT'),
                  onChanged: (value) {
                    print(value);
                  },
                  items: _list.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              child: Material(
                child: DropdownButtonFormField(
                  hint: Text('METHOD OF PAYMENT'),
                  onChanged: (value) {
                    print(value);
                  },
                  items: _list1.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: Userid,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 223, 197, 218),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0,)),
                  ),
                  hintText: ('ENTER ID'),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){},
              child: Text('PAY'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("BALANCE AMOUNT:"),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: balance,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 223, 197, 218),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0,)),
                  ),
                  hintText: ('10000'),
                ),
              ),
            ),
            Container(
              child: Material(
                child: DropdownButtonFormField(
                  hint: Text('METHOD OF PAYMENT'),
                  onChanged: (value) {
                    print(value);
                  },
                  items: _list2.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                print(Userid.text);
                print(balance.text);
                // Show booking successful message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Booking Successful!'),
                  ),
                );
              },
              child: Text('BOOK'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
