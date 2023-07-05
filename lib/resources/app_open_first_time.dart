import 'package:shared_preferences/shared_preferences.dart';

class AppOpen{

  static final AppOpen _singleton = AppOpen._internal();

  late bool _isAppOpenFirstTime;

  factory AppOpen() {
    return _singleton;
  }

  AppOpen._internal();

  // set setIsAppOpenFirstTime(bool value) => _isAppOpenFirstTime = value;

  void setIsAppOpenFirstTime()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAppOpenFirstTime =  prefs.getBool('AppOpenFirstTime') ?? true;
  }

  void setAppOpenSharePref()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('AppOpenFirstTime', false);
    _isAppOpenFirstTime = false;
  }

  get getIsAppOpenFirstTime => _isAppOpenFirstTime;

}