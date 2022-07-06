import 'package:cloud_firestore/cloud_firestore.dart';

class Nurse {
  Nurse({required this.nurseId, required this.nurseTitle, required this.nurseType, required this.contactNumber, required this.totalExperience, required this.totalEducation, required this.loc, required this.skillList, required this.rating, required this.imgUrl, this.hourlyRate});

  final String nurseId;
  final String nurseTitle;
  final String nurseType;
  final String contactNumber;
  final int totalExperience;
  final String totalEducation;
  final Map loc;
  final List<dynamic> skillList;
  final Map<String, dynamic> rating;
  final String imgUrl;
  final dynamic hourlyRate;


factory Nurse.fromFirestore(DocumentSnapshot snap){
  return Nurse(
    nurseId: snap['nurseId'],
    nurseTitle: snap['nurseTitle'],
    nurseType: snap['nurseType'],
    contactNumber: snap['contactNumber'],
    totalExperience: snap['totalExperience'],
    totalEducation: snap['totalEducation'],
    loc: snap['position'],
    skillList: snap['skillList'],
    rating: snap['rating'],
    imgUrl: snap['imgUrl'],
    hourlyRate: snap['hourlyRate'],
  );
}

}