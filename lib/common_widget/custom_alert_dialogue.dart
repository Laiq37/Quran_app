import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class CustomAlertDialogue extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const CustomAlertDialogue({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.S_24.r))),
                          title: Text(
                            'Please Confirm',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          content: Text(
                              text),
                          actions: [
                            TextButton(
                                onPressed: onPressed,
                                child: Text('Yes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: ColorManager.error,
                                        ))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)))
                          ],
                        );
  }
}