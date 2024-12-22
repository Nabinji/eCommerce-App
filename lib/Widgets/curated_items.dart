import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class CuratedItems extends StatelessWidget {
  final DocumentSnapshot<Object?>  productItems;
  final Size size;
  const CuratedItems(
      {super.key, required this.productItems, required this.size,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: productItems['image'],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: fbackgroundColor2,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productItems['image']),
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
            // Text(productItems['rating'].toString()),
            // Text(
            //   "(${productItems['review']})",
            //   style: const TextStyle(
            //     color: Colors.black26,
            //   ),
            // ),
          ],
        ),
        SizedBox(
          width: size.width * 0.5,
          child: Text(
            productItems['name']??"N/A",
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
              "\$${productItems['price'].toString()}.00",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.pink,
                height: 1.5,
              ),
            ),
            const SizedBox(width: 5),
            // if (productItems.isCheck == true)
            //   Text(
            //     "\$${productItems.price + 255}.00",
            //     style: const TextStyle(
            //       color: Colors.black26,
            //       decoration: TextDecoration.lineThrough,
            //       decorationColor: Colors.black26,
            //     ),
            //   ),
          ],
        )
      ],
    );
  }
}
