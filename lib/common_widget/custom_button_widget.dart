import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/style_manager.dart';

class CustomButtonWidget extends StatelessWidget {
  final double width;
  final double? height;
  final TextStyle? style;
  final String? text;
  final double xPad;
  final double yPadd;
  final Widget? child;
  final Color? color;
  final Function() onPressed;
  const CustomButtonWidget(
      {required this.width, this.style, this.text, required this.yPadd, this.xPad = 0.0, required this.onPressed, this.height, this.child, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: getButtonStyle( color ?? ColorManager.accent, yPadd.h),
        onPressed: onPressed,
        child: child ?? Padding( 
          padding: EdgeInsets.symmetric(horizontal: xPad.w),
          child:FittedBox(child:Text(
          text!,
          style: style,
        ))),
      ),
    );
  }
}
