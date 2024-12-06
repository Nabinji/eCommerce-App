class Category {
  final String name, image;
  Category({required this.name, required this.image});
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