import 'package:festive_fusion/USER/RentalWork.dart';
import 'package:flutter/material.dart';
import 'package:festive_fusion/USER/RentalCategoryItems.dart';

class RentalCategory extends StatefulWidget {
  final String rental_id;
  const RentalCategory({Key? key, required this.rental_id}) : super(key: key);

  @override
  State<RentalCategory> createState() => _RentalCategoryState();
}

class _RentalCategoryState extends State<RentalCategory> {
  List<Color> c = [Colors.brown, Colors.red, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Text(
              'CATEGORY',
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
                          return RentalWorkView(rental_id: widget.rental_id);
                        },
                      ),
                    );
                  },
                  child: Text(
                    'WORKS',
                    style: TextStyle(color: const Color.fromARGB(255, 15, 15, 15)),
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
                    'CATEGORY',
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
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                CategoryCard(
                  imagePath: 'Assets/rental.jpg',
                  category: 'Jewellery',
                  rental_id: widget.rental_id,
                ),
                SizedBox(width: 20),
                CategoryCard(
                  imagePath: 'Assets/duppatta.jpg',
                  category: 'Dupatta',
                  rental_id: widget.rental_id,
                ),
                SizedBox(width: 20),
                CategoryCard(
                  imagePath: 'Assets/bridal.jpg',
                  category: 'Bridal Dress',
                 rental_id: widget.rental_id,
                ),
                SizedBox(width: 20),
                CategoryCard(
                  imagePath: 'Assets/groom.jpg',
                  category: 'Groom Dress',
                  rental_id: widget.rental_id,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String category;
  final String rental_id;

  const CategoryCard({
    required this.imagePath,
    required this.category,
    required this.rental_id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Items(rental_id: rental_id, category: category);
          }),
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(255, 94, 87, 1),
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              category,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
