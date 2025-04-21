import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isCircle;

  const CategoryItem({super.key, required this.title, required this.image ,this.isCircle = true,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isCircle
              ? CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primaryColor,
            backgroundImage: NetworkImage(image),
          )
              : Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8), // مربع بحواف ناعمة
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
