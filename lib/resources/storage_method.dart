import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);
    // ref.putData(file).snapshotEvents.listen((event) {
    //   switch (event.state) {
    //     case TaskState.running:
    //       print("putData Running");
    //       // ...
    //       break;
    //     case TaskState.paused:
    //       print(" putData paused");
    //       // ...
    //       break;
    //     case TaskState.success:
    //       print(" putData success");
    //       // ...
    //       break;
    //     case TaskState.canceled:
    //       print("putData canceled");
    //       // ...
    //       break;
    //     case TaskState.error:
    //       print("putData Error");
    //       // ...
    //       break;
    //   }
    // });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
    //return ("Sucess");
  }
}
