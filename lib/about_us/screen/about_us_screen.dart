import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/common_widget/custom_background_widget.dart';
import 'package:quran/common_widget/custom_button_widget.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/resources/app_open_first_time.dart';
import 'package:quran/resources/constants.dart';
import 'package:get/get.dart';
class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  final AppOpen appOpen = AppOpen();

  @override
  void initState() {
    super.initState();
    if(appOpen.getIsAppOpenFirstTime){
      appOpen.setAppOpenSharePref();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomBackgroundWidget(
        size: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'about_us_title'.tr,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppSize.S_20.h,
            ),
             Text.rich(
             Get.locale!.languageCode == "en" ? const TextSpan(
              children: [
                TextSpan(text: 'The Quran - The Final Testament \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                TextSpan(text: '[Tamilization of authorized English translation] \n', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white)),
                TextSpan(text: 'Dr. Rasad Khalifa Ph.D. ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                TextSpan(text: 'Translated from the original by them.', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white)),
              ]
            )
            :
            const TextSpan(
              children: [
                TextSpan(text: ' குர்ஆன் - இறுதி ஏற்பாடு  \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                TextSpan(text: '  [அங்கீகரிக்கப்பட்ட ஆங்கில மொழிபெயர்ப்பின் தமிழாக்கம்] \n', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white)),
                TextSpan(text: 'டாக்டர் ரசாத் கலீபா Ph.D. ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                TextSpan(text: 'அவர்களால் மூலத்தில் இருந்து  மொழிபெயர்க்கப்பட்டது.   ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white)),
              ]
            )
            ,
             textAlign: TextAlign.center,
            ),
            // Text('about_us'.tr,
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context)
            //         .textTheme
            //         .titleSmall!
            //         .copyWith(color: ColorManager.white)),
            SizedBox(
              height: AppSize.S_54.h,
            ),
            CustomButtonWidget(
                width: size.width,
                style: Theme.of(context).textTheme.displaySmall,
                text: 'read_quran'.tr,
                yPadd: AppSize.S_12,
                onPressed: (){
                  Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) =>  HomeScreen())));
                },),
          ],
        ),
      ),
    );
  }
}