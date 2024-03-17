import 'package:flutter/material.dart';
import 'package:festive_fusion/common%20screens/login.dart';

class TypeUser extends StatefulWidget {
  const TypeUser({Key? key}) : super(key: key);

  @override
  State<TypeUser> createState() => _TypeUserState();
}

class _TypeUserState extends State<TypeUser> {
  int TypeUseredContainerIndex = 0; // Variable to keep track of the TypeUsered container
  PageController _pageController = PageController(initialPage: 0);
  List<String> imagePaths = [
    'Assets/makeup.webp',
    'Assets/mehandi.png',
    'Assets/image1.jpg',
    'Assets/rental.jpg',
    'Assets/user.jpg',
  ];
  List<String> containerTexts = [
    'Makeup',
    'Mehandi',
    'designer',
    'rental',
    'user',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Choose',
                    style: TextStyle(fontSize: 30, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '     your profile',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 50),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    TypeUseredContainerIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return buildContainer(index);
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imagePaths.length,
                (index) => buildDot(index),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(type: 'admin'),
                    ),
                  );
                },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Admin',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: TypeUseredContainerIndex == index ?  Color.fromARGB(255, 121, 79, 114) : const Color.fromARGB(255, 224, 228, 224),
        borderRadius: BorderRadius.circular(20),
        boxShadow: TypeUseredContainerIndex == index
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          if (TypeUseredContainerIndex==0) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'makeup');
            },
          ),
        );
        }
        if (TypeUseredContainerIndex==1) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'mehandi');
            },
          ),
        );
        }
         if (TypeUseredContainerIndex==2) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'designer');
            },
          ),
        );
        }
         if (TypeUseredContainerIndex==3) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login(type: 'rental');
            },
          ),
        );
        }
         if (TypeUseredContainerIndex==4) {
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
                  color: TypeUseredContainerIndex == index ? Colors.white : Colors.black87,
                  fontWeight: TypeUseredContainerIndex == index ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == TypeUseredContainerIndex ? Colors.black : Colors.grey,
      ),
    );
  }
}
