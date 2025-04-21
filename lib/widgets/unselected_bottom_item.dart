import 'package:flutter/material.dart';

class UnselectedBottomItem extends StatefulWidget {
  final selectedItem;
  const UnselectedBottomItem({super.key, this.selectedItem});

  @override
  State<UnselectedBottomItem> createState() => _UnselectedBottomItemState();
}

class _UnselectedBottomItemState extends State<UnselectedBottomItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.01
      ),
      child: Text(
        widget.selectedItem,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headlineLarge,
      ),

    );
  }
}
