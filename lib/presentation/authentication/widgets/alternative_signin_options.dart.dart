import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship_sample/core/colors.dart';
import 'package:internship_sample/core/constatns.dart';
import 'package:internship_sample/presentation/authentication/widgets/custom_circle_avatar_logo.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class AlternativeSigninOptionsWidget extends StatelessWidget {
  const AlternativeSigninOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        children: [
          CustomTextWidget(
            text: "- OR Continue with -",
            fontSize: 12,
            fontColor: Color(0xff575757),
            fontweight: FontWeight.w500,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCircleAvatarLogo(
                loginWith: LoginWith.google,
                logoPath: "lib/core/assets/images/logos/google_logo.svg",
              ),
              SizedBox(width: 10),
              CustomCircleAvatarLogo(
                loginWith: LoginWith.apple,
                logoPath: "lib/core/assets/images/logos/apple_logo.svg",
              ),
              SizedBox(width: 10),
              CustomCircleAvatarLogo(
                loginWith: LoginWith.facebook,
                logoPath: "lib/core/assets/images/logos/facebook_logo.svg",
              ),
            ],
          )
        ],
      ),
    );
  }
}
