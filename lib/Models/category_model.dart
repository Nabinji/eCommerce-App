import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> savemyCategoryToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("Category");
  for (final Category myCategory in category) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(myCategory.toMap());
  }
}

class Category {
  final String name, image;
  Category({required this.name, required this.image});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}

List<Category> category = [
  Category(
    name: "Women",
    image: "assets/women.png",
  ),
  Category(
    name: "Men",
    image: "assets/men.png",
  ),
  Category(
    name: "Teens",
    image: "assets/teen.png",
  ),
  Category(
    name: "Kids",
    image: "assets/kids.png",
  ),
  Category(
    name: "Baby",
    image: "assets/baby.png",
  ),
];

List<String> filterCategory = [
  "Filter",
  "Ratings",
  "Size",
  "Color",
  "Price",
  "Brand",
];
