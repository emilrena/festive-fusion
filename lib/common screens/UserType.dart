import 'package:festive_fusion/common%20screens/login.dart';
import 'package:flutter/material.dart';

class TypeUser extends StatefulWidget {
  const TypeUser({Key? key}) : super(key: key);

  @override
  State<TypeUser> createState() => _TypeUserState();
}

class _TypeUserState extends State<TypeUser> {
  int selectedContainerIndex = -1; // Variable to keep track of the selected container

  // List of image paths for each container
  List<String> imagePaths = [ 
    'Assets/makeup.webp',
    'Assets/mehandi.png',
    'Assets/image1.jpg',
    'Assets/user.jpg',
  ];

  // List of texts for each container
  List<String> containerTexts = [
    'Makeup',
    'Mehandi',
    'designer',
    'user',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Text(
              'Choose',
              style: TextStyle(fontSize: 30, color: Colors.black87),
            ),
          ),
          Text(
            'your profile',
            style: TextStyle(color: Colors.black87),
          ),
          SizedBox(height: 50), // Adding space between text and containers
          Row(
            children: [
              buildContainer(0), // Pass index 0 for container 1
              SizedBox(width: 10), // Decreased space between containers
              buildContainer(1), // Pass index 1 for container 2
            ],
          ),
          SizedBox(height: 20), // Adding space between first row and second row of containers
          Row(
            children: [
              buildContainer(2), // Pass index 2 for container 3
              SizedBox(width: 10), // Decreased space between containers
              buildContainer(3), // Pass index 3 for container 4
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContainer(int index) {
  bool isSelected = selectedContainerIndex == index;
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setState(() {
          selectedContainerIndex = index;
        });
        String userType = containerTexts[index].toLowerCase();
        if (selectedContainerIndex==0) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'makeup');
            },
          ),
        );
        }
         if (selectedContainerIndex==1) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'mehandi');
            },
          ),
        );
        }
         if (selectedContainerIndex==2) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'designer');
            },
          ),
        );
        }
         if (selectedContainerIndex==3) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'user');
            },
          ),
        );
        }
        
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 95, 55, 82) : const Color.fromARGB(255, 224, 228, 224),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePaths[index], // Load different image for each container
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                containerTexts[index], // Pass text corresponding to the container
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}


