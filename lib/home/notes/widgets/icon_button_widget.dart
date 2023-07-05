import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class IconButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const IconButtonWidget({required this.onTap, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          icon,
          color: ColorManager.white,
          size: AppSize.S_24.r,
        ),
      ),
    );
  }
}
