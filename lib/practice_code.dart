
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool? isUserAdmin;
//   bool authLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     initAuth();
//   }

//   late StreamSubscription authsub;

//   Future<void> initAuth() async {
//     authsub = FirebaseAuth.instance.authStateChanges().listen((auth) async {
//       if (auth == null) {
//         setState(() {
//           authLoading = false;
//         });
//         return;
//       }

//       final String userId = auth.uid;
//       final userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//       final userData = userDoc.data();
//       if (userData == null) {
//         setState(() {
//           authLoading = false;
//         });
//       } else {
//         final role = userData["role"] as String?;
//         if (role?.toLowerCase() == "admin") {
//           setState(() {
//             authLoading = false;
//             isUserAdmin = true;
//           });
//         } else {
//           authLoading = false;
//           isUserAdmin = false;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     authsub.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget body = const Center(
//       child: CircularProgressIndicator(),
//     );
//     if (!authLoading) {
//       if (isUserAdmin == null) {
//         body = const LoginScreen();
//       } else if (isUserAdmin == true) {
//         body = const AdminHomeScreen();
//       } else {
//         body = const AppMainScreen();
//       }
//     }
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: body,
//       ),
//     );
//   }
// }













 // final filterItems = fashionEcommerceApp
                            //     .where((item) =>
                            //         item.category.toLowerCase() ==
                            //         category[index].name.toLowerCase())
                            //     .toList();