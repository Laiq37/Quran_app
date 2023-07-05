import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class TabBarWidget extends StatelessWidget {
  int? checkIndex;
  TabBarWidget({super.key, this.checkIndex});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      xPad: 16.w,
      // yPad: AppSize.S_4.h,
      child: 
       checkIndex != null ?
       TabBar(
          // padding: EdgeInsets.zero,
          unselectedLabelColor: Colors.black,
          labelColor: ColorManager.white,
          padding: EdgeInsets.symmetric(vertical: AppSize.S_4.h),
          // isScrollable: true,
          indicatorWeight: 0,
          // labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          indicatorPadding: EdgeInsets.symmetric(vertical: AppSize.S_8.w),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            boxShadow: [BoxShadow(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        spreadRadius: 1.r,
        blurRadius: 8.r,
        offset: const Offset(-1,2), // changes position of shadow
      ),],
            color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(AppSize.S_26.r)),),
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          tabs: [
          ...Constants.QuranAyaatsDetail.map((String tab) => ClipRRect(
            clipBehavior: Clip.none,
            child: Tab(
              child: Text(tab.tr),
            ),
          ))
        ])
       :
       TabBar(
          // padding: EdgeInsets.zero,
          unselectedLabelColor: Colors.black,
          labelColor: ColorManager.white,
          padding: EdgeInsets.symmetric(vertical: AppSize.S_4.h, horizontal: AppSize.S_4.w),
          isScrollable: true,
          indicatorWeight: 0,
          labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          indicatorPadding: EdgeInsets.symmetric(vertical: AppSize.S_8.w),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            boxShadow: [BoxShadow(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        spreadRadius: 1.r,
        blurRadius: 8.r,
        offset: const Offset(-1,2), // changes position of shadow
      ),],
            color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(AppSize.S_26.r)),),
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          tabs: [
          ...Constants.TABS.map((String tab) => ClipRRect(
            clipBehavior: Clip.none,
            child: Tab(
              child: Container(constraints: BoxConstraints(minWidth: AppSize.S_54.w), padding: EdgeInsets.symmetric(horizontal: AppSize.S_13.w), child: Text(tab.tr),),
            ),
          ))
        ]),
    );
  }
}
