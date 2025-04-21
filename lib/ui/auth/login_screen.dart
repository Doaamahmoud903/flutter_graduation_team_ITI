import 'package:electro_app_team/ui/auth/forget_password_screen.dart';
import 'package:electro_app_team/ui/auth/register_screen.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool securePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      AppLocalizations.of(context)!.login_welcome,
                      style: themeProvider.currentTheme == ThemeMode.light
                          ? AppStyles.bold24lightGray
                          : AppStyles.bold24white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      AppLocalizations.of(context)!.sign_msg,
                      style: AppStyles.semibold16lightGray,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        hintStyle: hintTheme,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.emailIcon),
                          color: themeColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: securePassword,
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
                            securePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: themeColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) async {
                      if (state is LoginSuccess) {
                        // add login to SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString('userToken', state.token); // حفظ التوكن لو حابة تستخدميه لاحقًا

                        // success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Login Success: ${state.token}"),
                          ),
                        );

                        // navigate to home
                        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                      } else if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error: ${state.message}"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context).loginUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
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
                          child: state is LoginLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                                fontSize: 20, color: AppColors.whiteColor),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.not_have_account_ques,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        AppAssets.googleIcon,
                        height: 20,
                        width: 20,
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.login_with_google,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.02,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
