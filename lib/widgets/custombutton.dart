import 'package:flutter/material.dart';
import 'package:music_hunt/utlis/utils.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final double height;
  final double width;
  final bool icon;

  CustomButton({
    required this.color,
    required this.text,
    this.onTap,
    this.textStyle,
    this.height = 48,
    this.width = 269,
    this.icon= false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.themecolor),
            color: color,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon)
                  Icon(Icons.star,size: 18,),
                Text(
                  text,
                  style: textStyle ?? TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.txtcolor, // You can customize the text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
