import 'package:electro_app_team/widgets/user_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/utils/app_colors.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Mohamed',
              style: TextStyle(color: AppColors.darkBlueColor, fontSize: 20),
            ),
            Text(
              'mohamed.N@gmail.com',
              style: TextStyle(color: AppColors.blackColor, fontSize: 14),
            ),
          ],
        ),
        SizedBox(width: 45),
        UserCircleimage(),
      ],
    );
  }
}
