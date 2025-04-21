import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';

  BottomNavigationBarItem BottomNavbar({
  required String imgPath,
  required String label,
  required int i,
  required int selectedIndex,
  //required Function() onTapCallback,
}) {
  return BottomNavigationBarItem(
    icon: GestureDetector(
      //onTap: onTapCallback,
      child: selectedIndex == i
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(66),
        ),
        child: ImageIcon(AssetImage(imgPath)),
      )
          : ImageIcon(AssetImage(imgPath)),
    ),
    label: label,
  );
}