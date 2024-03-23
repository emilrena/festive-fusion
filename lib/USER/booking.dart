import 'package:festive_fusion/USER/MakeupPayment.dart';
import 'package:festive_fusion/USER/package.dart';
import 'package:flutter/material.dart';

class Booked extends StatefulWidget {
  final String provider_id;
    final String package_id;
  const Booked({Key? key, required this.provider_id, required this.package_id }) : super(key: key);
  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  @override
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Text('TIME:'),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Text(
                          '${selectedTime.format(context)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     fillColor: Color.fromARGB(255, 224, 206, 221),
                  //     filled: true,
                  //     border: UnderlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('DATE:'),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     fillColor: Color.fromARGB(255, 224, 206, 221),
                  //     filled: true,
                  //     border: UnderlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  // ),
                                SizedBox(height: 30,),
                                Text('SELECTED PACKAGE:'),
                                Container(
                                  height: 80,width: 300,
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 224, 206, 221),),
                                ),
            
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){
                          //             Navigator.push(context, MaterialPageRoute(builder:(context) {
                          //   return UserPckg();
                          // },));
                                    }, child: Text('CHANGE')),
                                  ],
                                ),
                                 SizedBox(height: 20,),
                                Text(' CURRENT ADRESS:'),
                                Container(
                                  height: 80,width: 300,
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 224, 206, 221),),
                                ),
            
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){}, child: Text('CHANGE')),
                                  ],
                                ),
                                ElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Payment();
                          },));
                                }, child: Text(' NEXT ',style:TextStyle(color: Colors.deepPurple),))
                                 ],
              ),
            ),
          ),
        ],
      )
    );
  }
}