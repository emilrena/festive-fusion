// import 'package:festive_fusion/USER/user_functions.dart';
import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:festive_fusion/Rental/RentalNav.dart';
import 'package:flutter/material.dart';

class Rental_Registration extends StatefulWidget {
  const Rental_Registration({super.key});

  @override
  State<Rental_Registration> createState() => _Rental_RegistrationState();
}

class _Rental_RegistrationState extends State<Rental_Registration> {
  var Name = TextEditingController();
  var Email = TextEditingController();
  var Adress = TextEditingController();
  var District = TextEditingController();
  var Pin= TextEditingController();
  var password = TextEditingController();
  var confirmPass = TextEditingController();
   var State = TextEditingController();
    var Mobile = TextEditingController();
  String gender = "";
  String selectedExperience = '0-1 years';

  // List of years of experience options
  List<String> experienceOptions = [
    '0-1 years',
    '1-2 years',
    '2-3 years',
    '3-5 years',
    '5+ years',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Rental_Registration')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 154, 134, 189),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Name'),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Email'),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Gender'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          Text('Male'),
                          Radio(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          Text('Female'),
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('House name'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: Adress,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('state'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: State,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('District'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: District,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Pin No'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: Pin,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Mobile Number'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: Mobile,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Password'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('confirm password'),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: confirmPass,
                        decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide.none)),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Year of Experience'),
                          ),
                        ],
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedExperience,
                        onChanged: (String? value) {
                          setState(() {
                            selectedExperience = value!;
                          });
                        },
                        items: List.generate(
                          experienceOptions.length,
                          (index) => DropdownMenuItem(
                            value: experienceOptions[index],
                            child: Text(experienceOptions[index]),
                          ),
                        ),
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      // ... (remaining code)

                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        
                        onPressed: () {
                          print(Name.text);
                            print(Email.text);
                            print(Adress.text);
                            print(State.text);
                            print(District.text);
                            print(Pin.text);
                            print(Mobile.text);
                            print(password.text);
                            print(confirmPass.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RentalNav();
                          }));
                        },
                        child: Text('register'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
