import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;

  User(
      {required this.name,
        required this.email,
        required this.uid,
        required this.profilePhoto});

  Map<String, dynamic> toMap() => {///=================================>>  """A User.fromJson() """ ------->constructor che , મેપ સ્ટ્રક્ચરમાંથી નવા યુઝર  બનાવવા માટે.
                                    ///=================================>>   """toJson() method""",---------> which converts a User instance into a map.
    "name": name,
    "profilePhoto": profilePhoto,
    "email": email,
    "uid": uid,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}