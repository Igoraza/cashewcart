import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class AccountItemTile extends StatelessWidget {
  const AccountItemTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20),
            CustomTextWidget(
              text: label,
              fontSize: 16,
              fontweight: FontWeight.w500,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}