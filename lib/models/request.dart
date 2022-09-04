import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String description;
  final String uid;
  final String username;
  final String requestId;
  final String profImage;
  final datePublished;

  const Request({
    required this.description,
    required this.uid,
    required this.username,
    required this.requestId,
    required this.profImage,
    required this.datePublished,
  });

  static Request fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Request(
        description: snapshot["description"],
        uid: snapshot["uid"],
        requestId: snapshot['requestId'],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        profImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "requestId": requestId,
        "datePublished": datePublished,
        'profImage': profImage
      };
}
