import 'package:cloud_firestore/cloud_firestore.dart';

class Facility {
  final String fId;
  final String fName;
  final String imgUrl;
  final String fType;
  final String fEmail;
  final String fAddress;
  final int phoneContact;
  final int hrContact;


  Facility(this.fId, this.fName, this.imgUrl, this.fType, this.fEmail, this.fAddress,
      this.phoneContact, this.hrContact,);

  factory Facility.fromFirestore(DocumentSnapshot snap) {
    return Facility(
        snap['facilityId'],
        snap['facilityName'],
        snap['imgUrl'],
        snap['facilityType'],
        snap['email'],
        snap['facilityAddress'],
        snap['phoneContact'],
        snap['hrContact']
    );
  }
}
