import 'package:flutter/material.dart';
import 'package:music_hunt/utlis/utils.dart';

class CustomStatsWidget extends StatelessWidget {
  final String likes;
  final String title;
  final String subtitle;
  final String duration;

  const CustomStatsWidget({
    Key? key,
    required this.likes,
    required this.title,
    required this.subtitle,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          _StatItem(value: likes, label: 'Likes',),
          SizedBox(width: 20),
          Icon(Icons.play_circle, color: Colors.white),
          SizedBox(width: 20),
          _StatItem(value: title, label: 'Diamound'),
          Spacer(),
          Text(duration, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 15, color: AppColors.txtcolor),
        ),
      ],
    );
  }
}
