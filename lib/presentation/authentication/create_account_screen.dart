import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/controllers/app_controller.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/core/constants.dart';
import 'package:cashew_cart/presentation/authentication/signin_screen.dart';

import 'package:cashew_cart/presentation/authentication/widgets/alternative_signin_options.dart.dart';
import 'package:cashew_cart/presentation/authentication/widgets/authentication_page_title.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_icon_text_field.dart';
import 'package:cashew_cart/presentation/authentication/widgets/custom_password_text_field.dart';
import 'package:cashew_cart/presentation/main_page/main_page_screen.dart';
import 'package:cashew_cart/presentation/widgets/custom_elevated_button.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:cashew_cart/services/api_services.dart';
import 'package:validatorless/validatorless.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key, required this.token});
  final String token;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Obx(() => controller.isLoading.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: double.infinity),
                      SizedBox(height: 100),
                      CustomTextWidget(
                        text: "Signing up",
                        fontSize: 20,
                        fontweight: FontWeight.w600,
                      ),
                      kHeight,
                      Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight,
                      AuthenticationPageTitle(
                        heading: "Create an",
                      ),
                      AuthenticationPageTitle(
                        heading: "account",
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomIconTextField(
                              icon: Icons.person_2,
                              hintText: "Name",
                              controller: usernameController,
                              keyboardType: TextInputType.name,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.required('Name is required'),
                                  Validatorless.min(3, 'Name must be at least 3 characters'),
                                ],
                              ),
                            ),
                            CustomIconTextField(
                              icon: Icons.phone_outlined,
                              hintText: "Phone",
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.required('Phone number is required'),
                                  Validatorless.number('Invalid Phone number'),
                                  Validatorless.min(10, 'Invalid Phone number'),
                                  Validatorless.max(10, 'Invalid Phone number'),
                                ],
                              ),
                            ),
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
                              hintText: "Confirm  Password",
                              controller: confirmPasswordController,
                            ),
                          ],
                        ),
                      ),
                      const Wrap(
                        children: [
                          CustomTextWidget(
                            text: "By clicking the ",
                            fontSize: 12,
                            fontColor: kAuthentificationPageTextColor,
                            fontweight: FontWeight.w400,
                          ),
                          CustomTextWidget(
                            text: "Register ",
                            fontSize: 12,
                            fontColor: Color(0xffFF4B26),
                            fontweight: FontWeight.w400,
                          ),
                          CustomTextWidget(
                            text: "button, you agree",
                            fontSize: 12,
                            fontColor: kAuthentificationPageTextColor,
                            fontweight: FontWeight.w400,
                          ),
                          CustomTextWidget(
                            text: "to the public offer",
                            fontSize: 12,
                            fontColor: kAuthentificationPageTextColor,
                            fontweight: FontWeight.w400,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Obx(() {
                        return controller.isLoading.value
                            ? Container(
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kMainThemeColor,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    final _password = passwordController.text;
                                    final _confirmPassword = confirmPasswordController.text;
                                    if (_password != _confirmPassword) {
                                      const snackBar = SnackBar(
                                        content: Text("Passwords doesn't match!"),
                                        // behavior: SnackBarBehavior.floating,
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      print("Trying to register user");
                                      controller.registerNewUser(
                                        context,
                                        token,
                                        usernameController.text,
                                        phoneNumberController.text,
                                        passwordController.text,
                                      );
                                    }
                                  }
                                },
                                child: CustomElevatedButton(
                                  label: "Create Account",
                                ),
                              );
                      }),
                      SizedBox(height: 20.w),
                      // const AlternativeSigninOptionsWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidget(
                            text: "I Already Have An Account ",
                            fontSize: 14,
                            fontweight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () => Get.offAll(SignInScreen()),
                            child: const CustomTextWidget(
                              text: "Login",
                              fontSize: 14,
                              fontColor: kMainThemeColor,
                              fontweight: FontWeight.w600,
                              underline: true,
                            ),
                          )
                        ],
                      ),
                      kHeight,
                    ],
                  )),
          ),
        ),
      ),
    );
  }
}
