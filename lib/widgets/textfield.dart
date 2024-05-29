import 'package:flutter/material.dart';

import '../utlis/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, left: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.themecolor),
          ),
          style: TextStyle(color: AppColors.themecolor),
        ),
      ),
    );
  }
}
