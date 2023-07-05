import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class SearchWidget extends StatefulWidget {
  final SearchController searchController;
  const SearchWidget({super.key, required this.searchController});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      xPad: AppSize.S_26.w, 
      yPad: AppSize.S_4.h,
      child: Obx(()=>Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: 
            // Obx(()=>
               TextField(
                textInputAction: TextInputAction.search,
                onChanged: (searchText){
                 if(searchText.isNotEmpty && !widget.searchController.isCancelVisible.value){
                  widget.searchController.isCancelVisible.value = true;
                  // setState(() {
                    
                  // });
                 }
                  else if(searchText == '' && widget.searchController.isCancelVisible.value){
                    widget.searchController.isCancelVisible.value = false;
                    // setState(() {
                      
                    // });
                  }
                },
                onSubmitted: (_)async{
                  try{await widget.searchController.search();}catch(e){
                    if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.getSnackBar(context, e.toString()));
                }
                  }
                },
                controller: widget.searchController.textController.value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                   hintText: Get.find<GotoController>().isOnGoto.value ?'goto_seach_hint'.tr: 'search_field_hint'.tr, 
                   hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorManager.subtitle),
                   border: InputBorder.none
               )),
            // ),
          ),
          if(widget.searchController.isCancelVisible.value)
          InkWell(onTap: () {
              widget.searchController.textController.value.clear();
             if( widget.searchController.isCancelVisible.value){
      Future.delayed(Duration.zero,()=>widget.searchController.isCancelVisible.value = false);
    }
              widget.searchController.search();},child: Icon(Icons.cancel_sharp,color: ColorManager.disableText, size: AppSize.S_24.r,)
          // Image.asset(ImageAssets.SEARCH_BAR_ICON)
          )
        ],
      ))
    );
  }
}