import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Models/category_model.dart';
import 'package:e_commerce_app/Models/sub_category.dart';
import 'package:e_commerce_app/Utils/colors.dart';
import 'package:e_commerce_app/Views/items_detail_scree.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryItems extends StatelessWidget {
  final String selectedCategory;
  final String category;
  const CategoryItems({
    super.key,
    required this.category,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('items');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText: "$category's Fashion",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: fbackgroundColor2,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(
                            Iconsax.search_normal,
                            color: Colors.black38,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    filterCategory.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Text(filterCategory[index]),
                            const SizedBox(width: 5),
                            index == 0
                                ? const Icon(
                                    Icons.filter_list,
                                    size: 15,
                                  )
                                : const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 15,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  subcategory.length,
                  (index) => InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: fbackgroundColor1,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(subcategory[index].image),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(subcategory[index].name),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: itemsCollection
                    .where('category', isEqualTo: selectedCategory)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!.docs;
                    if (items.isEmpty) {
                      return const Center(
                        child: Text('No items found in this category.'),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final item =
                            items[index].data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemsDetailScree(
                                  productItems: items[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: item['image'],
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: fbackgroundColor2,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(item['image']),
                                    ),
                                  ),
                                  height: size.height * 0.25,
                                  width: size.width * 0.5,
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.black26,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  const Text(
                                    "H&M",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 17,
                                  ),
                                  // Text(item.rating.toString()),
                                  // Text(
                                  //   "(${item.review})",
                                  //   style: const TextStyle(
                                  //     color: Colors.black26,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Text(
                                  item['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${item['price'].toString()}.00",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  // if (item.isCheck == true)
                                  //   Text(
                                  //     "\$${item.price + 255}.00",
                                  //     style: const TextStyle(
                                  //       color: Colors.black26,
                                  //       decoration: TextDecoration.lineThrough,
                                  //       decorationColor: Colors.black26,
                                  //     ),
                                  //   ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ok
// thats it for this tutorial
// we will come with one complete flutter ecommerce app with admin pande, backed and statemanagement
// soon.
