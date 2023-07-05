import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/common_widget/custom_background_widget.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/widgets/app_bar_widget.dart';
import 'package:quran/home/widgets/body_widget.dart';
import 'package:quran/home/widgets/drawer_widget.dart';
import 'package:quran/home/widgets/search_widget.dart';
import 'package:quran/resources/constants.dart';

class ScreenTemplateWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool onHomeScreen;
  final String title;
  final Widget child;
  final bool showIosBackButton;
  // final double? xPadd;
  final bool isResizeBottomInsert;
  final int? id;
  final SearchController? searchController;
  const ScreenTemplateWidget({required this.scaffoldKey, required this.onHomeScreen, this.isResizeBottomInsert = false, required this.title, this.showIosBackButton = false,  required this.child, this.searchController, this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: isResizeBottomInsert,
        body: CustomBackgroundWidget(
          size: size,
          isPadd: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSize.S_34.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:AppSize.S_26.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 AppBarWidget(scaffoldKey: scaffoldKey, title: title, onHomeScreen: onHomeScreen, showIosBackButton: showIosBackButton,id:id),
                 if(onHomeScreen)
                SizedBox(height: AppSize.S_20.h,),
                if(onHomeScreen)
                 SearchWidget(searchController: searchController!,),
                  ],
                ),
              ),
              if(onHomeScreen)
                SizedBox(height: AppSize.S_38.h,),
              if(!onHomeScreen)
                SizedBox(height: AppSize.S_20.h,),
              Expanded(child: BodyWidget( height: !onHomeScreen ? 26.h : null, child: child,))
            ],
          ),
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}