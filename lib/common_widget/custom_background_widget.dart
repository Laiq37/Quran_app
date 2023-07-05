import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/constants.dart';

class CustomBackgroundWidget extends StatelessWidget {
  final Widget child;
  final Size size;
  final bool isPadd;
  const CustomBackgroundWidget({required this.child, required this.size, this.isPadd = true, super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: isPadd ? EdgeInsets.symmetric(horizontal: AppSize.S_26.w) : null,
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageAssets.BACKGROUND_DESIGN,
                ),
                fit: BoxFit.fill)),
                child: child);
  }
}