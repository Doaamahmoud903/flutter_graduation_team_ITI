import 'package:electro_app_team/widgets/user_account_details.dart';
import 'package:electro_app_team/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/utils/app_colors.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy',
          style: TextStyle(color: AppColors.blueColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetails(),
            UserAccountDetails(
              initialText: "**********************",
              labelText: "Current Password",
            ),
            UserAccountDetails(
              initialText: "**********************",
              labelText: "New Password",
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print("Button pressed!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Change Password",
                    style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
