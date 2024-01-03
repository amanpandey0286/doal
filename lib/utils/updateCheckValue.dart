import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditOperations {
  //to update checkvalue
  Future<void> updateCheckValue(String taskId, bool newValue) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Reference to the specific task document using the taskId obtained from the StreamBuilder
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Todo')
          .doc(uid)
          .collection('mytasks')
          .doc(taskId);

      // Update the 'check' field with the new value
      if (newValue) {
        await documentReference.update({
          'check': newValue,
          'remCheck': false,
          // Set remCheck to false when check becomes true
        });
      } else {
        await documentReference.update({
          'check': newValue,
          // Set remCheck to false when check becomes true
        });
      }
    }
  }

  
}
