import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';

class UserAccountDetails extends StatefulWidget {
  final String initialText;
  final String labelText;

  const UserAccountDetails({
    super.key,
    required this.initialText,
    required this.labelText,
  });

  @override
  State<UserAccountDetails> createState() => _UserAccountDetailsState();
}

class _UserAccountDetailsState extends State<UserAccountDetails> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(color: AppColors.darkBlueColor, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 398,
            height: 50,
            child: TextField(
              controller: _textController,
              style: const TextStyle(
                color: AppColors.darkBlueColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: AppColors.darkBlueColor,
                    width: 0.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: AppColors.darkBlueColor,
                    width: .8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: AppColors.darkBlueColor,
                    width: 0.8,
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.darkBlueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
