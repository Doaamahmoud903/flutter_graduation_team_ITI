import 'package:electro_app_team/cubits/forget_password/forget_password_cubit.dart';
import 'package:electro_app_team/cubits/forget_password/forget_password_state.dart';
import 'package:electro_app_team/ui/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'package:dio/dio.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "ForgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    Color themeColor = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.lightGrayColor
        : AppColors.primaryColor;
    var languageProvider = Provider.of<LanguageProvider>(context);

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(dio: Dio()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.find_your_account,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }

                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    Navigator.pushNamed(
                      context,
                      ResetPasswordScreen.routeName,
                      arguments: emailController.text.trim(),
                    );
                  }
                });
              } else if (state is ForgetPasswordError) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              }
            },

            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        themeProvider.currentTheme == ThemeMode.light
                            ? languageProvider.currentLocal == "en"
                            ? AppAssets.mainLogo
                            : AppAssets.logoArDark
                            : languageProvider.currentLocal == "en"
                            ? AppAssets.mainLogoLight
                            : AppAssets.logoArLight,
                        height: height * 0.15,
                        width: width * 0.8,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),

                  // Email Text Field
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        hintStyle: themeProvider.currentTheme == ThemeMode.light
                            ? AppStyles.semibold14lightGray
                            : AppStyles.semibold14lightblue,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.emailIcon),
                          color: themeColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: themeColor),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  // Reset Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is ForgetPasswordLoading
                          ? null
                          : () {
                        final email = emailController.text.trim();
                        if (email.isNotEmpty) {
                          BlocProvider.of<ForgetPasswordCubit>(context)
                              .sendForgetPasswordEmail(email);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    AppLocalizations.of(context)!.email_required)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        themeProvider.currentTheme == ThemeMode.light
                            ? AppColors.blueColor
                            : AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is ForgetPasswordLoading
                          ? const CircularProgressIndicator(
                          color: AppColors.whiteColor)
                          : Text(
                        AppLocalizations.of(context)!.search,
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
