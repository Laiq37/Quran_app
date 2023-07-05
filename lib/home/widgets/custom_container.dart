import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double xPad;
  final double yPad;
  final double mYPad;
  final double? borderRadius;
  final Color? color;
  final double minHeight;
  final double? height;
  final BoxBorder? border;
  final double? width;
  const CustomContainer({this.width, required this.child, this.xPad = 0, this.yPad = 0, this.mYPad = 0, this.borderRadius, this.color, this.minHeight = 0.0, this.height, this.border, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: width ?? size.width,
      constraints: BoxConstraints(minHeight: minHeight),
      margin: EdgeInsets.only(bottom: mYPad),
      padding: EdgeInsets.symmetric(horizontal: xPad, vertical: yPad),
      decoration: BoxDecoration(
        color: color ?? ColorManager.white,
        borderRadius: BorderRadius.all(Radius.circular( borderRadius ?? AppSize.S_40.r),),
        border: border
      ),
      child: child);
  }
}