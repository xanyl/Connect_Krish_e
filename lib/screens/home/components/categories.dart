import 'package:flutter/material.dart';
import 'category_card.dart';

class Categories extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/Grains.svg", "text": "Grain"},
    {"icon": "assets/icons/Fruits.svg", "text": "Fruits"},
    {"icon": "assets/icons/Vegetables.svg", "text": "Vegetables"},
    {"icon": "assets/icons/Livestocks.svg", "text": "Livestocks"},
    {"icon": "assets/icons/Dairy.svg", "text": "Dairy"},
    {"icon": "assets/icons/Others.svg", "text": "Others"},
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        categories.length,
        (index) => CategoryCard(
          icon: categories[index]["icon"],
          text: categories[index]["text"],
          press: () {},
        ),
      ),
    );
  }
}
