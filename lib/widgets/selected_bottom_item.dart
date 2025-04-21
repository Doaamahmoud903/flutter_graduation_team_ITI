import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SelectedBottomItem extends StatefulWidget {
  final selectedItem;
  const SelectedBottomItem({super.key, this.selectedItem});

  @override
  State<SelectedBottomItem> createState() => _SelectedBottomItemState();
}

class _SelectedBottomItemState extends State<SelectedBottomItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.01
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.selectedItem,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color:  AppColors.blueColor,
            ),
          ),
          Icon(Icons.check,
            size: 25,
            color: AppColors.blueColor,
          )
        ],
      ),
    );
  }
}
