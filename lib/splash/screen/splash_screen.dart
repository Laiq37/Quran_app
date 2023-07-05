import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/language_selection/screen/language_selection_screen.dart';
import 'package:quran/resources/app_open_first_time.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final Timer timer;
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    timer = Timer(
        const Duration(
          milliseconds: 3000,
        ),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => AppOpen().getIsAppOpenFirstTime
                    ? const LanguageSelectionScreen()
                    : HomeScreen()))));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          ImageAssets.SPLASH_THEME,
        ),
        fit: BoxFit.fill,
      )),
      child: Column(
        children: [
          const Expanded(flex: 3, child: SizedBox()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FadeTransition(
                  opacity: _animation,
                  child: Text(
                    'قُل يٰأَهلَ الكِتٰبِ لَستُم عَلىٰ شَىءٍ حَتّىٰ تُقيمُوا التَّورىٰةَ وَالإِنجيلَ وَما أُنزِلَ إِلَيكُم مِن رَبِّكُم وَلَيَزيدَنَّ كَثيرًا مِنهُم ما أُنزِلَ إِلَيكَ مِن رَبِّكَ طُغيٰنًا وَكُفرًا فَلا تَأسَ عَلَى القَومِ الكٰفِري (05:69)',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: ColorManager.white),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
