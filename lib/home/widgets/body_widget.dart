import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/constants.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  // final double? xPadd;
  const BodyWidget({ this.height,required this.child, super.key,});


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: xPadd ?? AppSize.S_26.w),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular( AppSize.S_46.r),
              topRight: Radius.circular(AppSize.S_46.r))),
    child: Column(
      children: [
        SizedBox(height: height ?? AppSize.S_10.h,),
         Expanded(child: child)
      ],
    ),
    );
  }
}
