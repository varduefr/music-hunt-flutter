import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_hunt/utlis/utils.dart';

import '../view/Bands_Page.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String imagePath;

  const CustomListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            child: Image.asset(imagePath),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                color: AppColors.txtcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                color: AppColors.txtcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            time,
            style: TextStyle(
            color: AppColors.txtcolor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 20),
          InkWell(
              onTap: (){
                Get.to(Bands());
              },
              child: Icon(Icons.arrow_forward_ios,color: AppColors.txtcolor,size: 18,)),
        ],
      ),
    );
  }
}
