import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class FireBaseServices {
//   Future<String> getFirstValue(
//       {required String email,
//       required bool isEqual,
//       required String collectionName}) async {
//     try {
//       // Start building the query
//       StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection(collectionName).snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }

//           if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//             String? roundNumber = snapshot.data!.docs.map((doc) {
//               if (isEqual) {
//                 if (doc.get('id') == email && doc.get('isFirst') == "true") {
//                   return doc.get('roundNumbers') as String?;
//                 }
//               } else {
//                 if (doc.get('id') != email && doc.get('isFirst') == "true") {
//                   return doc.get('roundNumbers') as String?;
//                 }
//               }
//               return null; 
//             }).firstWhere((element) => element != null, orElse: () => null);

//             if (roundNumber != null) {
//               // Return a widget that uses the `roundNumber`
//               return Text('Round Number: $roundNumber');
//             } else {
//               return const Text('No matching data');
//             }
//           }

//           return const Text('No data found');
//         },
//       );
//     } on Exception catch (e) {
//       return 'Error fetching data: $e';
//     }
//   }
// }
