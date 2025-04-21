import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../cubits/register/register_cubit.dart';
import '../../cubits/register/register_state.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.register,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is RegisterLoading) {
        // You can also use a loading overlay if you prefer
      } else if (state is RegisterSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.register_success),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      } else if (state is RegisterError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
        ));
      }
    },
    builder: (context, state) {
    return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
    child: Form(
      key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(themeProvider.currentTheme == ThemeMode.light
                        ? languageProvider.currentLocal == "en" ? AppAssets.mainLogo: AppAssets.logoArDark
                        : languageProvider.currentLocal == "en" ? AppAssets.mainLogoLight: AppAssets.logoArLight,
                      height: height*0.15,
                      width: width*0.8,
                    ),
                  )
                ],
              ),
              SizedBox(height: height*0.02,),
        // Name field
        buildTextField(
          controller: nameController,
          hint:AppLocalizations.of(context)!.name,
          iconPath:AppAssets.userIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name is required";
            }
            return null;
          },
        ),
        SizedBox(height: height*0.02,),
        // Email field
        buildTextField(
          controller:emailController,
          hint:AppLocalizations.of(context)!.email,
          iconPath:AppAssets.emailIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          validator: (value) {
            if (value!.isEmpty) return "Email required";
            if (!value.contains('@')) return "Enter a valid email";
            return null;
          },

        ),
        SizedBox(height: height*0.02,),
        // Phone field
        buildTextField(
          controller:phoneController,
          hint:AppLocalizations.of(context)!.phone_number,
          iconPath:AppAssets.phoneIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Phone is required";
            }
            return null;
          },
        ),
        SizedBox(height: height*0.02,),
        // Address field
        buildTextField(
          controller:addressController,
          hint:AppLocalizations.of(context)!.address,
          iconPath:AppAssets.mapIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Address is required";
            }
            return null;
          },
        ),

        SizedBox(height: height*0.02),
        // Password field
        buildTextField(
          controller: passwordController,
          hint:AppLocalizations.of(context)!.password,
          iconPath :AppAssets.lockIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          obscure: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Address is required";
            }else if(value.length < 6 ){
              return "Password too short";
            }
            return null;
          },
        ),
        SizedBox(height: height*0.02,),
        // Re Password field
        buildTextField(
          controller: confirmPasswordController,
          hint:AppLocalizations.of(context)!.re_password,
          iconPath :AppAssets.lockIcon,
          iconColor:themeColor,
          hintStyle:hintTheme,
          obscure: true,
          validator: (value) {
            if (value!.isEmpty) return "Re Password required";
            if (value != passwordController.text) return "Passwords do not match";
            return null;
          },
        ),
        SizedBox(height: height*0.02),
        // Login Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is RegisterLoading ? null : () {
    if (_formKey.currentState!.validate()) {
      RegisterCubit.get(context).registerUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        address: addressController.text,
          confirmPassword : confirmPasswordController.text,
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
            child: state is RegisterLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.whiteColor),
            )

                : Text(
              AppLocalizations.of(context)!.create_account,
              style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // لديك حساب؟
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.have_account_ques,
                style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ],
      ),
    ),
    );
    },
        ),
    );
  }
  bool securePassword = true;

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required String iconPath,
    required Color iconColor,
    required TextStyle hintStyle,
    required String? Function(String?)? validator,
    bool obscure = false,
  }) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.9,
      height: height * 0.07,
      child: TextFormField(
        controller: controller,
        obscureText: obscure ? securePassword : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          prefixIcon: ImageIcon(AssetImage(iconPath), color: iconColor),
          suffixIcon: obscure
              ? IconButton(
            onPressed: () {
              setState(() {
                securePassword = !securePassword;
              });
            },
            icon: Icon(
              securePassword ? Icons.visibility_off : Icons.visibility,
              color: iconColor,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }


}