import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fv_frontend_task/utils/common_functions.dart';
import 'package:shimmer/shimmer.dart';

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
        trailing: priceWithSuperScript(trailing, 16));
  }
}

class ShimmerListLoader extends StatelessWidget {
  const ShimmerListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (contrxt, index) {
            return ListTile(
              leading: Container(
                height: 60,
                width: 60,
                color: Colors.white,
              ),
              title: Container(
                height: 10,
                width: 120,
                color: Colors.white,
              ),
              trailing: Container(
                height: 10,
                width: 50,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 8,
                width: 80,
                color: Colors.white,
              ),
            );
          }),
    );
  }
}
