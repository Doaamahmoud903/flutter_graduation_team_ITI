import 'package:electro_app_team/providers/language_provider.dart';
import 'package:electro_app_team/providers/theme_provider.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/widgets/user_account_details.dart';
import 'package:electro_app_team/widgets/user_details.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.darkBlueColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          children: [
            UserDetails(),
            // const SizedBox(height: 10),
            UserAccountDetails(
              labelText: "Your full name",
              initialText: "mohamed Ahmed Nabil",
            ),
            // const SizedBox(height: 5),
            UserAccountDetails(
              labelText: "Your email",
              initialText: "mohamed.N@gmail.com",
            ),
            // const SizedBox(height: 5),
            UserAccountDetails(
              labelText: "Your mobile number",
              initialText: "01010448545",
            ),
            // const SizedBox(height: 5),
            UserAccountDetails(labelText: "Your address", initialText: "cairo"),
          ],
        ),
      ),
    );
  }
}
