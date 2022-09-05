import 'dart:typed_data';

import 'package:bloodzen/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloodzen/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadRequest(String description, String uid, String username,
      String profImage, String neededBefore, String bloodGrp) async {
    String res = "some error occured";
    try {
      String requestId = const Uuid().v1();
      Request request = Request(
          description: description,
          uid: uid,
          username: username,
          requestId: requestId,
          datePublished: DateTime.now(),
          profImage: profImage,
          neededBefore: neededBefore,
          bloodGrp: bloodGrp);
      _firestore.collection('requests').doc(requestId).set(
            request.toJson(),
          );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
