import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.trailing,
      this.icon,
      this.iconColor});
  final String imageUrl;
  final String title;
  final String subtitle;
  final String trailing;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: imageUrl.isEmpty
                    ? icon != null
                        ? Container(
                            color: iconColor?.withOpacity(0.2),
                            child: Icon(icon, color: iconColor),
                          )
                        : Container(
                            color: Colors.black,
                          )
                    : Container(
                        color: Colors.transparent,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          errorWidget: (context, url, error) =>
                              Container(color: Colors.black),
                          fit: BoxFit.cover,
                        ),
                      ))),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: trailing.split('.').first,
                style: TextStyle(color: Colors.black, fontSize: 16)),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(1, -5),
                child: Text(
                  ".${trailing.split('.').last}",
                  //superscript is usually smaller in size
                  textScaleFactor: 0.7,

                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            )
          ]),
        )

        // Text(
        //   trailing,
        //   style: const TextStyle(
        //     // fontFeatures: [FontFeature.superscripts()],
        //     fontSize: 16,
        //   ),
        // ),
        );
  }
}
