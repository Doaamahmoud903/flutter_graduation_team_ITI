import 'package:flutter/material.dart';
import 'package:electro_app_team/utils/app_colors.dart';

class UserCircleimage extends StatelessWidget {
  const UserCircleimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50,

            backgroundColor: AppColors.whiteColor,

            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ),
        const Positioned(
          right: 0,

          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.whiteColor,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xff004BFE),
              child: Icon(Icons.edit, color: AppColors.whiteColor, size: 17),
            ),
          ),
        ),
      ],
    );
  }
}
