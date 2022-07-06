import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
class FindNurseCard extends StatelessWidget {
  const FindNurseCard({
    this.displayUrl,
    this.title,
    this.type,
    this.rating,
    Key? key
  }): super(key: key);
  final displayUrl;
  final title;
  final type;
  final rating;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: KWhiteColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
                height: 52,
                width: 52,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(imageUrl: displayUrl,
                    errorWidget: (context, error, _) {
                      return const Icon(Icons.error);
                    },
                    )
                    )),
            title: Text(
              title,
              style: headingSmallKBlackLight,
            ),
            subtitle: Row(
              children: [
                Text(
                  type,
                  style: smaltext,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Icon(Icons.star, color: Colors.amber,size: 20,)),
                Text('$rating', style: smaltext),
              ],
            ),
            trailing: Image.asset(
              "assets/Vector - 2022-03-16T225243.208.png",
              height: 16.5,
            ),
          ),
        ),
    );
  }
}
