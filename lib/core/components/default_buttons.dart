import 'package:flutter/material.dart';

import '../style/color/app_colors.dart';
import '../style/text/app_text_style.dart';

class DefaultButton extends StatelessWidget {
  final Function onPress;
  final String buttonText;
  Color textColor;
  Color buttonColor;
  double buttonHeight;
  double buttonWidth;
  double buttonBorderCircular;

  DefaultButton({
    Key? key,
    required this.onPress,
    this.buttonColor = AppColors.primaryColor,
    required this.buttonText,
    this.textColor = Colors.white,
    this.buttonHeight = 15,
    this.buttonWidth = double.infinity,
    this.buttonBorderCircular = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(buttonBorderCircular),
      ),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          buttonText,
          style: AppTextStyle.bodyText().copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
