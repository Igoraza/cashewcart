import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/authentication/forgot_password_screen.dart';
import 'package:cashew_cart/presentation/authentication/signup_screen.dart';
import 'package:cashew_cart/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:cashew_cart/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:cashew_cart/services/services.dart';
import 'package:validatorless/validatorless.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email});
  final String email;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(29),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthenticationPageTitle(
                  heading: "Reset\nPassword",
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomPasswordTextField(
                        hintText: "Password",
                        controller: passwordController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Password is required'),
                            (String? password) {
                              if (password != null && password.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ],
                        ),
                      ),
                      CustomPasswordTextField(
                        hintText: "Confirm Password",
                        controller: confirmPasswordController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Password is required'),
                            (String? confirmPassword) {
                              if (confirmPassword != null && confirmPassword != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        print("Trying to reset password");
                        final response = await ApiServices().resetPassword(context, passwordController.text, confirmPasswordController.text);
                        if (response != null) {
                          Services().showCustomSnackBar(context, response.data["msg"].toString());
                          if (response.statusCode == 200 || response.statusCode == 201) {
                            final isLoginSuccess = await controller.loginUser(context, email, passwordController.text);
                            if (isLoginSuccess) {
                              Get.offAll(MainPageScreen());
                            }
                          }
                        }

                        // controller.loginUser(context, emailController.text, passwordController.text);
                      }
                    },
                    child: CustomElevatedButton(
                      label: "Reset and Login",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
