import 'package:festive_fusion/Navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/USER/BokkedImage.dart';

class Payment extends StatefulWidget {
  final String provider_id;
  final String package_id;
  final String type;
  final String description;

  Payment({
    Key? key,
    required this.provider_id,
    required this.package_id,
    required this.type,
    required this.description,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var balance = TextEditingController();
  final List<String> _list = ['FULL AMOUNT', 'ADVANCE'];
  final List<String> _list1 = ['GPAY', 'PHONEPAY'];
  final List<String> _list2 = ['GPAY', 'PHONEPAY', 'CASH ON DELIVERY'];
  var amt = '';
  var finalprice = 0.0;
  var remaining = 0.0;

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
                'Total amount: ${widget.description}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: DropdownButtonFormField(
                hint: Text('PAYMENT'),
                onChanged: (value) {
                  setState(() {
                    amt = value.toString();
                    if (amt == 'FULL AMOUNT') {
                      balance.text = widget.description;
                      remaining = 0.0;
                    } else {
                      total();
                    }
                  });
                },
                items: _list.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: balance,
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 223, 197, 218),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  hintText: (amt == 'FULL AMOUNT') ? widget.description : '0',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
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
            SizedBox(height: 20),
            if (amt != 'FULL AMOUNT')
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("BALANCE AMOUNT:"),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 223, 197, 218),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        hintText: (remaining.toString()),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
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
                ],
              ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                var userId = sp.getString('uid');

                Map<String, dynamic> data = {
                  'provider_id': widget.provider_id,
                  'package_id': widget.package_id,
                  'type': widget.type,
                  'description': widget.description,
                  'payment_type': amt,
                  'user_id': userId,
                  'status': 'Paid', // Add status as 'Paid'
                };

                if (amt == 'ADVANCE') {
                  data['advance_payment_amount'] = finalprice;
                  data['balance_payment_amount'] = remaining;
                } else {
                  data['advance_payment_amount'] = 0;
                  data['balance_payment_amount'] = double.parse(balance.text);
                }

                await FirebaseFirestore.instance.collection('payments').add(data);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>Navigationbar(),
                  ),
                );
              },
              child: Text('PAY & BOOK'),
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

  void total() {
    setState(() {
      finalprice = double.parse(widget.description) / 4;
      remaining = double.parse(widget.description) - finalprice;
      balance.text = finalprice.toString();
    });
  }
}
