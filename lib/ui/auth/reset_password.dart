import 'package:electro_app_team/cubits/reset_password/reset_password_cubit.dart';
import 'package:electro_app_team/cubits/reset_password/reset_password_state.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String routeName = "ResetPasswordScreen";
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  bool securePassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    Color themeColor = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.lightGrayColor
        : AppColors.primaryColor;

    TextStyle hintTheme = themeProvider.currentTheme == ThemeMode.light
        ? AppStyles.semibold14lightGray
        : AppStyles.semibold14lightblue;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.reset_password,
          style: Theme.of(context).textTheme.displayLarge,),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.06),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
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
                  )
                ],
              ),
              SizedBox(height: height * 0.02),
              // Code field
              SizedBox(
                width: width * 0.9,
                height: height * 0.07,
                child: TextFormField(
                  controller: codeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Code is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.code,
                    hintStyle: themeProvider.currentTheme == ThemeMode.light
                        ? AppStyles.semibold14lightGray
                        : AppStyles.semibold14lightblue,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.lockIcon),
                      color: themeColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              // Email field
              SizedBox(
                width: width * 0.9,
                height: height * 0.07,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
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
              SizedBox(height: height * 0.02),
              // Password field
              SizedBox(
                width: width * 0.9,
                height: height * 0.07,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: securePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                    hintStyle: hintTheme,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.lockIcon),
                      color: themeColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          securePassword = !securePassword;
                        });
                      },
                      icon: Icon(
                        securePassword ? Icons.visibility_off : Icons.visibility,
                        color: themeColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              // Reset Button
              BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),

                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                              (route) => false,
                        );

                      }
                    });
                  } else if (state is ResetPasswordError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ResetPasswordCubit>(context).resetPassword(
                            email: email, // اuse email passed
                            code: codeController.text,
                            newPassword: passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.currentTheme == ThemeMode.light
                            ? AppColors.blueColor
                            : AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is ResetPasswordLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        AppLocalizations.of(context)!.reset_password,
                        style: const TextStyle(fontSize: 20, color: AppColors.whiteColor),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
