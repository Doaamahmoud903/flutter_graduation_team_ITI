import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String? trailingText;

  const SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                if (trailingText != null) ...[
                  Text(
                    trailingText!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(width: 8),
                ],
                 Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: themeProvider.currentTheme == ThemeMode.dark ? AppColors.whiteColor: AppColors.blackColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}