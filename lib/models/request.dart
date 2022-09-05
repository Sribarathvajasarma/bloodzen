import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String description;
  final String uid;
  final String username;
  final String requestId;
  final String profImage;
  final datePublished;
  final String neededBefore;
  final String bloodGrp;

  const Request(
      {required this.description,
      required this.uid,
      required this.username,
      required this.requestId,
      required this.profImage,
      required this.datePublished,
      required this.neededBefore,
      required this.bloodGrp});

  static Request fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Request(
        description: snapshot["description"],
        uid: snapshot["uid"],
        requestId: snapshot['requestId'],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        profImage: snapshot['profImage'],
        neededBefore: snapshot['neededBefore'],
        bloodGrp: snapshot['bloodGrp']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "requestId": requestId,
        "datePublished": datePublished,
        "profImage": profImage,
        "neededBefore": neededBefore,
        "bloodGrp": bloodGrp
      };
}
