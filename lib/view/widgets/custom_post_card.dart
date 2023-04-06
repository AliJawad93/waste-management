import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';
import '../../model/post_model.dart';

class CustomPostCard extends StatefulWidget {
  CustomPostCard(this.postModel, {Key? key}) : super(key: key);
  PostModel postModel;
  @override
  State<CustomPostCard> createState() => _CustomPostCardState();
}

class _CustomPostCardState extends State<CustomPostCard> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.person_outline,
                  color: AppColors.white,
                ),
                decoration: BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Admin\n",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                      text: widget.postModel.date.toString(),
                      style: TextStyle(
                          color: AppColors.unSelectedIcon, fontSize: 10)),
                ])),
              )
            ],
          ),
          Container(
            height: 0.4,
            margin: EdgeInsets.symmetric(vertical: 5),
            color: AppColors.line,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isRead = !isRead;
              });
            },
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                widget.postModel.text,
                overflow: isRead ? null : TextOverflow.ellipsis,
                maxLines: isRead ? null : 4,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.postModel.urlImage,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }
}
