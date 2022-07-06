import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String facilityId;
  final double rating;
  final List<dynamic> improvements;
  final String comment;
  final Timestamp reviewTime;

  Review({
    required this.facilityId,
    required this.rating,
    required this.comment,
    required this.improvements,
    required this.reviewTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'facilityId': facilityId,
      'rating': rating,
      'improvements': improvements,
      'comment': comment,
      'reviewTime': reviewTime,
    };
  }

  factory Review.fromFirestore(DocumentSnapshot snap) {
    return Review(
        facilityId: snap['facilityId'],
        rating: snap['rating'],
        comment: snap['comment'],
        improvements: snap['improvements'],
        reviewTime: snap['reviewTime']);
  }
}
