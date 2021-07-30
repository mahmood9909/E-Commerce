
// import 'package:ecommerce/widgets/bottom_tabs/bottom_tabs.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key)

 
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     print("it builde the home");
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//                 child: PageView(
//               children: [
//                 Container(
//                   child: Center(
//                     child: Text("Home"),
//                   ),
//                 ),
//                 Container(
//                   child: Center(
//                     child: Text("Search"),
//                   ),
//                 ),
//                   Container(
//                   child: Center(
//                     child: Text("Search"),
//                   ),
//                 ),
                
//               ],
//             ))
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomTabs(),
//     );
//   }
// }

// // child: FutureBuilder<DocumentSnapshot>(
// //     future: FirebaseFirestore.instance
// //         .collection("users")
// //         .doc(FirebaseAuth.instance.currentUser!.uid)
// //         .get(),
// //     builder: (context, snapshot) {
// //       if (snapshot.hasData) {
// //         return ElevatedButton(
// //             onPressed: () {
// //               FirebaseAuth.instance.signOut();
// //             },
// //             child: Text(snapshot.data!.get('userRole')));
// //       } else
// //         return Text("");
// //     })
