import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Services/auth_service.dart';
import '../login_screen.dart';
import 'add_items.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  AuthService authService = AuthService();
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  String? selectedCategory; // To store selected category for filtering
  List<String> categories = []; // List to store categories

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Fetch categories when initializing
  }

  Future<void> fetchCategories() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Category').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's UID
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Your Uploaded Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      authService.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.exit_to_app),
                  ),
                  // Dropdown for category selection
                  DropdownButton<String>(
                    icon: const Icon(Icons.tune),
                    underline: const SizedBox(),
                    // value: selectedCategory,
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
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  // Filter by selected category
                  stream: _items
                      .where('uploadedBy', isEqualTo: uid)
                      .where('category', isEqualTo: selectedCategory)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items.'));
                    }
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return const Center(child: CircularProgressIndicator());
                    // }
                    final documents = snapshot.data?.docs ?? [];
                    if (documents.isEmpty) {
                      return const Center(child: Text('No items uploaded.'));
                    }
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final items =
                            documents[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  items['image'],
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                items['name'] ?? 'N/A',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        items['price'] != null
                                            ? '\$${items['price']}.00'
                                            : 'N/A',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          letterSpacing: -1,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text('${items['category'] ?? 'N/A'}'),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  // Safely handle colors
                                  // Wrap(
                                  //   spacing: 8.0,
                                  //   children:
                                  //       (items['colors'] as List<dynamic>? ??
                                  //               [])
                                  //           .map((color) {
                                  //     return Container(
                                  //       width: 20,
                                  //       height: 20,
                                  //       color: getColorFromName(color),
                                  //       margin: const EdgeInsets.symmetric(
                                  //           vertical: 2),
                                  //     );
                                  //   }).toList(),
                                  // ),
                                ],
                              ),
                              onLongPress: () => _confirmDeleteItem(
                                  documents[index].id), // Add long press action
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddItemScreen(),
          ));
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _confirmDeleteItem(String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _deleteItem(itemId);
              Navigator.of(context).pop(); // Close the dialog after deletion
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(String itemId) async {
    try {
      await _items.doc(itemId).delete(); // Delete the item from Firestore
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item deleted successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting item:$e')));
    }
  }

  // Color getColorFromName(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //     case 'red':
  //       return Colors.red;
  //     case 'green':
  //       return Colors.green;
  //     case 'blue':
  //       return Colors.blue;
  //     case 'black':
  //       return Colors.black;
  //     case 'white':
  //       return Colors.white;
  //     case 'yellow':
  //       return Colors.yellow;
  //     case 'orange':
  //       return Colors.orange;
  //     case 'purple':
  //       return Colors.purple;
  //     default:
  //       return Colors.grey; // Default color if not recognized
  //   }
  // }
}
