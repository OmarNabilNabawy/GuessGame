import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guess/constants.dart';

class FireBaseServices {
  // Future<String> getFirstValue(
  //     {required String email, required bool isEqual}) async {
  //   try {
  //     FieldFilter filter = isEqual
  //       ? FieldFilter.equalTo('id', email)
  //       : FieldFilter.notEqualTo('id', email);
  //     List<String> excludedValues = isEqual ? [] : [email];
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection(kMessagesCollections)
  //         .where('isFirst', isEqualTo: 'true')
  //         .where('id', isEqualTo: excludedValues)
  //         .limit(1)
  //         .get();
  //     if (querySnapshot.docs.isNotEmpty) {
  //       DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  //       String value = documentSnapshot.get('roundNumbers');
  //       return value;
  //     } else {
  //       return 'No matching document found';
  //     }
  //   } on Exception catch (e) {
  //     return 'Error fetching data: $e';
  //   }
  // }

  Future<String> getFirstValue(
      {required String email, required bool isEqual}) async {
    try {
      // Start building the query
      Query query = FirebaseFirestore.instance
          .collection(kMessagesCollections)
          .where('isFirst', isEqualTo: 'true');

      // Add the conditional where clause
      if (isEqual) {
        query = query.where('id', isEqualTo: email);
      } else {
        query = query.where('id', isNotEqualTo: email);
      }

      // Limit the results to 1
      QuerySnapshot querySnapshot = await query.limit(1).get();

      // Check if there are any documents and return the value
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String value = documentSnapshot.get('roundNumbers');
        return value;
      } else {
        return 'No matching document found';
      }
    } on Exception catch (e) {
      return 'Error fetching data: $e';
    }
  }
}
