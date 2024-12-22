import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  // For sizes
  final TextEditingController sizeController = TextEditingController();
  // For colors
  final TextEditingController colorController = TextEditingController();
  // For discount percentage
  final TextEditingController discountPercentageController =
      TextEditingController();
  String? imagePath;
  bool isLoading = false;
  String? selectedCategory; // To store selected category
  List<String> categories = []; // List to store categories
  List<String> sizes = []; // List to store sizes
  List<String> colors = []; // List to store colors
  bool isDiscounted = false; // To track if discount is applied

  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Fetch categories when screen initializes
  }

  Future<void> fetchCategories() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Category').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image:$e'),
      ));
    }
  }

  void removeSize(String size) {
    setState(() {
      sizes.remove(size); // Remove the selected size
    });
  }

  void removeColor(String color) {
    setState(() {
      colors.remove(color); // Remove the selected color
    });
  }

  Future<void> uploadAndSaveItem() async {
    if (_nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        imagePath == null ||
        selectedCategory == null ||
        sizes.isEmpty || // Check if sizes are provided
        colors.isEmpty || // Check if colors are provided
        (isDiscounted && discountPercentageController.text.isEmpty)) {
      // Check if discount percentage is provided when discounted
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill all fields and upload an image.')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      await reference.putFile(File(imagePath!));
      final imageUrl = await reference.getDownloadURL();
      final String name = _nameController.text;
      final int? price = int.tryParse(numberController.text);
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user's UID

      await items.add({
        "name": name,
        "price": price,
        "image": imageUrl,
        "uploadedBy": uid,
        "category": selectedCategory, // Store the selected category
        "sizes": sizes, // Store the list of sizes
        "colors": colors, // Store the list of colors
        "isDiscounted": isDiscounted, // Store whether there is a discount
        "discountPercentage": isDiscounted
            ? int.tryParse(discountPercentageController.text)
            : 0 // Store discount percentage if applicable
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully!')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving item:$e'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : isLoading
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: pickImage,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                          ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue; // Update selected category
                });
              },
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: sizeController,
              decoration: const InputDecoration(
                labelText: 'Sizes (comma separated)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  sizes.addAll(value.split(',').map((s) => s.trim()).toList());
                  sizeController.clear(); // Clear input after adding
                });
              },
            ),
            // const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: sizes
                  .map((size) => Chip(
                      onDeleted: () => removeSize(size), label: Text(size)))
                  .toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(
                labelText: 'Colors (comma separated)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  colors.addAll(value.split(',').map((c) => c.trim()).toList());
                  colorController.clear(); // Clear input after adding
                });
              },
            ),
            // const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: colors
                  .map(
                    (color) => Chip(
                      onDeleted: () => removeColor(color),
                      label: Text(color),
                    ),
                  )
                  .toList(),
            ),

            // Discount Checkbox
            Row(
              children: [
                Checkbox(
                  value: isDiscounted,
                  onChanged: (bool? value) {
                    setState(() {
                      isDiscounted = value ?? false; // Update discount status
                    });
                  },
                ),
                const Text("Apply Discount"),
              ],
            ),

            if (isDiscounted)
              Column(
                children: [
                  TextField(
                    controller: discountPercentageController,
                    decoration: const InputDecoration(
                      labelText: 'Discount Percentage (%)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType
                        .number, // Allow only numbers for percentage input
                  ),
                  const SizedBox(height: 10),
                ],
              ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: ElevatedButton(
                      onPressed: uploadAndSaveItem,
                      child: const Text('Save Item'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
