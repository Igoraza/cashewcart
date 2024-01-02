import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class CustomTextIconButton extends StatelessWidget {
  const CustomTextIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.textAndIconColor,
    required this.textAndIconSize,
  });

  final IconData icon;
  final String label;
  final Color textAndIconColor;
  final double textAndIconSize;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        color: textAndIconColor,
        size: textAndIconSize,
      ),
      label: CustomTextWidget(
        text: label,
        fontColor: textAndIconColor,
        fontSize: textAndIconSize,
        fontweight: FontWeight.w500,
      ),
      style: TextButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: Color(0xFF828282),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
