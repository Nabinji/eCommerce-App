import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> saveAppModelToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("items");
  for (final AppModel appModel in fashionEcommerceApp) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(appModel.toMap());
  }
} // the method toMap isn't defined for the type AppModel. Try correction the name to the name of and existing methd, or  defining a method  name to Map.

class AppModel {
  final String name, image, category, uploadedBy;
  final double rating;
  final int review, price;
  List<Color> fcolor;
  List<String> size;
  bool isCheck;

  AppModel({
    required this.name,
    required this.uploadedBy,
    required this.image,
    required this.rating,
    required this.price,
    required this.review,
    required this.fcolor,
    required this.size,
    required this.isCheck,
    required this.category,
  });

  // Convert AppModel to Map<String, dynamic> for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      "uploadedBy": uploadedBy,
      'image': image,
      'category': category,
      'rating': rating,
      'review': review,
      'price': price,
      'fcolor': fcolor
          .map((color) => color.value)
          .toList(), // Convert Color to int value
      'size': size,
      'isCheck': isCheck,
    };
  }

  // // Optionally, create a factory method to convert Map to AppModel
  // factory AppModel.fromMap(Map<String, dynamic> map) {
  //   return AppModel(
  //     name: map['name'],
  //     image: map['image'],
  //     category: map['category'],
  //     rating: map['rating'],
  //     review: map['review'],
  //     price: map['price'],
  //     fcolor: (map['fcolor'] as List).map((colorValue) => Color(colorValue)).toList(),
  //     size: List<String>.from(map['size']),
  //     isCheck: map['isCheck'],
  //   );
  // }
}

//  Map<String, dynamic> toMap() {
//   return <String, dynamic>{
//     'title': title,
//     'isActive': isActive,
//     'image': image,
//     'rating': rating,
//     'date': date,
//     'price': price,
//     'address': address,
//     'vendor': vendor,
//     'vendorProfession': vendorProfession,
//     'vendorProfile': vendorProfile,
//     'review': review,
//     'bedAndBathroom': bedAndBathroom,
//     'yearOfHostin': yearOfHostin,
//     'latitude': latitude,
//     'longitude': longitude,
//     'imageUrls': imageUrls,

// }
// }

List<AppModel> fashionEcommerceApp = [
  // id:1
  AppModel(
    name: "Oversized Fit Printed Mesh T-Shirt",
    rating: 4.9,
    image: "assets/category_image/image23.png",
    price: 295,
    review: 136,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    isCheck: true,
    category: "Women",
    fcolor: [
      Colors.black,
      Colors.blue,
      Colors.blue[100]!,
    ],
    size: [
      "XS",
      "S",
      "M",
    ],
  ),
  // id:2
  AppModel(
    name: "Printed Sweatshirt",
    rating: 4.8,
    image: "assets/category_image/image24.png",
    price: 314,
    review: 178,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    category: "Men",
    isCheck: false,
    fcolor: [
      Colors.green,
      Colors.black,
      Colors.blue[100]!,
    ],
    size: [
      "X",
      "S",
      "XL",
    ],
  ),
  // id:3
  AppModel(
    name: "Loose Fit Sweatshirt",
    rating: 4.7,
    image: "assets/category_image/image28.png",
    price: 187,
    review: 59,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    isCheck: false,
    category: "Men",
    fcolor: [
      Colors.blue,
      Colors.red,
      Colors.purple,
    ],
    size: [
      "X",
      "XX",
      "XL",
    ],
  ),
  // id:4
  AppModel(
    name: "Loose Fit Hoodie",
    rating: 5.0,
    image: "assets/category_image/image7.png",
    price: 400,
    review: 29,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    category: "Men",
    isCheck: false,
    fcolor: [
      Colors.brown,
      Colors.blueGrey,
      Colors.orange,
    ],
    size: [
      "S",
      "X",
    ],
  ),
  // id:5
  AppModel(
    name: "DrvMove™ Track Jacket",
    rating: 4.1,
    image: "assets/category_image/image8.png",
    price: 290,
    review: 29,
    category: "Men",
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    isCheck: false,
    fcolor: [
      Colors.black,
      Colors.orange,
      Colors.blueAccent,
    ],
    size: [
      "S",
      "XX",
      "X",
      "XL",
    ],
  ),
  // id:6
  AppModel(
    name: "Regular Fit T-Shert",
    rating: 3.9,
    image: "assets/category_image/image27.png",
    price: 333,
    review: 29,
    category: "Men",
    uploadedBy: "TFmxVyQW5NTMjc1R9a7SWvqEYTo1",
    isCheck: false,
    fcolor: [
      Colors.brown,
      Colors.blueGrey,
      Colors.orange,
    ],
    size: [
      "S",
      "XX",
    ],
  ),

  // id:7
  AppModel(
    name: "Baby Frock",
    rating: 5.0,
    image: "assets/category_image/image1.png",
    price: 330,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    review: 29,
    category: "Baby",
    isCheck: true,
    fcolor: [
      Colors.red,
      Colors.purple,
      Colors.pinkAccent,
    ],
    size: [
      "S",
      "B",
    ],
  ),
  // id:8
  AppModel(
    name: "Coat For Man",
    rating: 4.5,
    image: "assets/category_image/image2.png",
    price: 990,
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
    review: 120,
    category: "Men",
    isCheck: true,
    fcolor: [
      Colors.black,
      Colors.grey,
      Colors.white10,
    ],
    size: [
      "S",
      "XX",
      "X",
      "XL",
    ],
  ),
  // id:9
  AppModel(
    name: "Baby Dress Set",
    rating: 5.8,
    image: "assets/category_image/image3.png",
    price: 330,
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
    review: 290,
    category: "Baby",
    isCheck: true,
    fcolor: [
      Colors.white,
      Colors.blue,
      Colors.white10,
    ],
    size: [
      "S",
      "B",
    ],
  ),
  // id:10
  AppModel(
    name: "Casual Hoodie Dress for Kids",
    rating: 4.7,
    image: "assets/category_image/image4.png",
    price: 200,
    review: 90,
    category: "Kids",
    isCheck: true,
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    fcolor: [
      Colors.pink,
      Colors.blue,
      Colors.purple,
    ],
    size: ["S", "B", "X"],
  ),
  // id:11
  AppModel(
    name: "Hoodie For Teens",
    rating: 4.4,
    image: "assets/category_image/image6.png",
    price: 200,
    review: 90,
    category: "Teen",
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
    isCheck: true,
    fcolor: [
      Colors.pink,
      Colors.pinkAccent,
      Colors.orange,
    ],
    size: ["S", "B", "x"],
  ),
  // id:13
  AppModel(
    name: "Summer Jacket",
    rating: 4.9,
    image: "assets/category_image/image9.png",
    price: 300,
    review: 20,
    category: "Men",
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
    isCheck: true,
    fcolor: [
      Colors.green,
      Colors.blue,
      Colors.black,
    ],
    size: ["S", "X" "XL"],
  ),
  // id:14
  AppModel(
    name: "Winter Jacket",
    rating: 3.0,
    image: "assets/category_image/image10.png",
    price: 1300,
    review: 120,
    category: "Teens",
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
    isCheck: true,
    fcolor: [
      Colors.amber,
      Colors.black,
      Colors.amberAccent,
    ],
    size: ["S", "B" "X"],
  ),
  // id:15
  AppModel(
    name: "Pant and Shirt",
    rating: 4.5,
    image: "assets/category_image/image11.png",
    price: 220,
    review: 70,
    category: "Baby",
    uploadedBy: "TFmxVyQW5NTMjc1R9a7SWvqEYTo1",
    isCheck: true,
    fcolor: [
      Colors.amber,
      Colors.green,
      Colors.blue,
    ],
    size: ["S", "B"],
  ),
  // id:16
  AppModel(
    name: "Mix Double Set",
    rating: 4.6,
    image: "assets/category_image/image12.png",
    price: 200,
    review: 70,
    category: "Teens",
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
    isCheck: false,
    fcolor: [
      Colors.pink,
      Colors.green,
      Colors.blue,
    ],
    size: ["S", "X", "XL"],
  ),
  // id:17
  AppModel(
    name: "Coat For Women",
    rating: 4.4,
    image: "assets/category_image/image13.png",
    price: 200,
    review: 70,
    category: "Women",
    isCheck: false,
    fcolor: [
      Colors.blueGrey,
      Colors.green,
      Colors.grey,
    ],
    size: ["S", "X", "XL"],
    uploadedBy: "j1cN8HD23GQE4FxTGdspIAkcvru2",
  ),
  // id:19
  AppModel(
    name: "Complete Dress",
    rating: 4.5,
    image: "assets/category_image/image15.png",
    price: 1000,
    review: 170,
    category: "Teens",
    isCheck: false,
    fcolor: [
      Colors.blueGrey,
      Colors.green,
      Colors.grey,
    ],
    size: ["S", "X", "XL"],
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
  ),
  // id:20
  AppModel(
    name: "Summer Kurti",
    rating: 4.4,
    image: "assets/category_image/image16.png",
    price: 220,
    review: 60,
    category: "Women",
    isCheck: true,
    fcolor: [
      Colors.blueGrey,
      Colors.orange,
      Colors.black,
    ],
    size: ["S", "X", "XL"],
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
  ),
  // id:20
  AppModel(
    name: "Loose Sweater",
    rating: 4.4,
    image: "assets/category_image/image17.png",
    price: 220,
    review: 60,
    category: "Teens",
    isCheck: true,
    fcolor: [
      Colors.blueGrey,
      Colors.orange,
      Colors.black,
    ],
    size: ["S", "X", "XL"],
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
  ),
  // id:20
  AppModel(
    name: "T-Shert for Women",
    rating: 4.4,
    image: "assets/category_image/image22.png",
    price: 220,
    review: 60,
    category: "Women",
    isCheck: false,
    fcolor: [
      Colors.black12,
      Colors.blueAccent,
      Colors.black,
    ],
    size: ["S", "X", "XX"],
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
  ),
  // id:21
  AppModel(
    name: "Kids T-Shert",
    rating: 4.4,
    image: "assets/category_image/image26.png",
    price: 100,
    review: 10,
    category: "Kids",
    isCheck: true,
    fcolor: [
      Colors.blueGrey,
      Colors.blueAccent,
      Colors.black,
    ],
    size: ["S", "X", "SX"],
    uploadedBy: "CkWvOGimbzQlwkmDrHL7EdSwiu22",
  ),
];
const myDescription1 = "Elevate your casual wardrobe with our";
const myDescription2 =
    " .Crafted from premium cotton for maximum comfort, this relaxed-fit tee features.";
