import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/home/strategy_impl/appendix_search_strategy.dart';
import 'package:quran/home/strategy_impl/goto_search_strategy.dart';
import 'package:quran/home/strategy_impl/intro_appendix_detail_search_strategy.dart';
import 'package:quran/home/strategy_impl/notes_search_strategy.dart';
import 'package:quran/home/strategy_impl/quran_surah_search_strategy.dart';
import 'package:quran/home/strategy_impl/surah_ayaah_search_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession{

  static int? homeTabIndex;
  static int? surahTabIndex;
  static late int currentindex;
  static List<dynamic> surahSessionList = [];
  static late SharedPreferences prefs;
  static int currentSurahAyahIndex = -1;

  static void getAppSession(){
 SharedPreferences.getInstance().then((value){
  prefs = value;
     homeTabIndex = prefs.getInt("homeIndex");
     surahSessionList = jsonDecode(prefs.getString('surah_session_list')??'''[]''');
     if(prefs.getString('app_locale') != null){
      Get.updateLocale(prefs.getString('app_locale') == 'English' ? Constants.languages[0]['local'] : Constants.languages[1]['local']);
     }
    //  surahTabIndex = prefs.getInt("surahIndex");
    });
  }

    //  prefs.setInt('home_tab_index', homeTabIndex!);
    // print(isadded);
    // if(surahTabIndex == null)return;
    // await prefs.setInt('surah_tab_index', surahTabIndex!);
  }


class ImageAssets {
  static const String SPLASH_THEME = 'assets/images/splash_theme.png';

  static const String BACKGROUND_DESIGN = 'assets/images/background_design.png';

  static const String SEARCH_BAR_ICON = 'assets/images/search_bar_icon.png';

  static const String NOTES_ICON = 'assets/images/notes_icon.png';

  static const String APP_LOGO = 'assets/images/app_logo.png';

  static const String POLYGON_ICON = 'assets/images/polygon.png';

  static const String POLYGON_ICON_YELLOW = 'assets/images/polygon_yellow.png';

  static const String ADD_FAB = 'assets/images/add_fab_icon.png';

  static const String ADD_PEN = 'assets/images/open-pencil.png';

  static const String ADD_FAB_svg = 'assets/images/add_fab.svg';

  static const String APP_LOGO_WITH_TEXT =
      'assets/images/app_logo_with_text.png';

  static const String IMAGE_PLACEHOLDER = 'assets/images/image_placeholder.png';
}

class Constants {
  static const SearchStrategy quranSurahSearchStrategy =
      QuranSurahSearchStrategy();
  static const SearchStrategy surahAyaahSearchStrategy =
      SurahAyaahSearchStrategy();
  static const SearchStrategy notesSearchStrategy = NotesSearchStrategy();
  static const SearchStrategy appendixSearchStrategy = AppendixSearchStrategy();
  static const IntroAppendixDetailSearchStrategy introAppendixDetailSearchStrategy = IntroAppendixDetailSearchStrategy();
  static const GotoSearchStrategy gotoSearchStrategy = GotoSearchStrategy();

  static const List<Map> languages = [
    {
      'language_name': 'English',
      'language_name_translation': 'English',
      'local': Locale('en', 'US')
    },
    // {
    //   'language_name': 'Arabic',
    //   'language_name_translation': 'العربية',
    //   'local': Locale('ar', 'SA')
    // },
    {
      'language_name': 'Tamil',
      'language_name_translation': 'தமிழ்',
      'local': Locale('tm', 'IN')
    },
    // {
    //   'language_name': 'Urdu',
    //   'language_name_translation': 'اردو',
    //   'local': Locale('ur', 'PK')
    // },
  ];

  static List<Map<String, dynamic>> DRAWER_ITEMS = [
    // {
    //   'icon': Icons.home_outlined,
    //   'item_name': 'item_1',
    // },
    // {
    //   'icon': Icons.event_available_outlined,
    //   'item_name': 'item_2',
    // },
    {
      'icon': Icons.language_outlined,
      'item_name': 'change_language',
    },
    {
      'icon': Icons.info_outline,
      'item_name': 'about_us_title',
    },
    // {
    //   'icon': Icons.settings,
    //   'item_name': 'setting',
    // }
  ];

  static const List<String> TABS = [
    'goto',
    'introduction',
    'quran',
    'appendix',
    'index',
    'notes'
  ];

  static const List<String> QuranAyaatsDetail = [
    'Tamil',
    'English',
    'Arabic',
  ];

// static const String APP_TITLE = 'Quran App';

// static const String TITLE = 'Quran';

// static const String CREATE_NOT_TITLE = 'Create Note';

// static const String SEARCH_FEILD_HINT = 'Search Surah';

// static const String ABOUT_US = 'About us';

// static const String ABOUT_US_TEXT = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled";

// static const String READ_QURAN = 'READ QURAN';

// static const String SELECT_YOUR_LANGUAGE = 'Select your Language';

  static const List<Map<String, String>> appendixList = [
    {
      "name": "1. மாபெரும் அற்புதங்களில் ஒன்று (74:35)",
      "fileName": "AppendixTamil1"
    },
    {
      "name": "2. கடவுளின் உடன்படிக்கைத் தூதர் (3:81)",
      "fileName": "AppendixTamil2"
    },
    {
      "name": "3. இக்குர்ஆனை நாம் இலகுவாக ஆக்கினோம் (54:17)",
      "fileName": "AppendixTamil3"
    },
    {
      "name": "4. ஏன் இந்தக் குர்ஆன் அரபியில் வெளிப்படுத்தப்பட்டது?",
      "fileName": "AppendixTamil4"
    },
    {"name": "5. சுவனம் மற்றும் நரகம்", "fileName": "AppendixTamil5"},
    {"name": "6. கடவுளின் மகத்துவம்", "fileName": "AppendixTamil6"},
    {"name": "7. நாம் ஏன் படைக்கப்பட்டோம்?", "fileName": "AppendixTamil7"},
    {"name": "8. பரிந்துரை எனும் புராணம்", "fileName": "AppendixTamil8"},
    {"name": "9. ஆப்ரஹாம்: இஸ்லாமின் ஆதித்தூதர்", "fileName": "AppendixTamil9"},
    {
      "name": "10. பன்மைப் பதத்தில் கடவுளுடைய பிரயோகம்",
      "fileName": "AppendixTamil10"
    },
    {
      "name": "11. உயிர்த்தெழுப்பப்படுகின்றஅந்நாள்",
      "fileName": "AppendixTamil11"
    },
    {"name": "12. முஹம்மத் நபியின் பணி", "fileName": "AppendixTamil12"},
    {"name": "13. இஸ்லாமின் முதல் தூண்:", "fileName": "AppendixTamil13"},
    {"name": "14. விதி", "fileName": "AppendixTamil14"},
    {
      "name": "15. மார்க்கக் கடமைகள்: கடவுளிடமிருந்து ஓர் அன்பளிப்பு",
      "fileName": "AppendixTamil15"
    },
    {"name": "16. உணவுத் தடைகள்", "fileName": "AppendixTamil16"},
    {"name": "17. மரணம்", "fileName": "AppendixTamil17"},
    {
      "name": "18. உங்களுக்குத் தேவையானதெல்லாம் குர்ஆன்தான்",
      "fileName": "AppendixTamil18"
    },
    {
      "name": "19. ஹதீஸ் & சுன்னா: சாத்தானியக் கண்டுபிடிப்புக்கள்",
      "fileName": "AppendixTamil19"
    },
    {
      "name": "20. குர்ஆன்: மற்ற எந்தப் புத்தகத்தையும் போன்றதல்ல",
      "fileName": "AppendixTamil20"
    },
    {"name": "21. சாத்தான்: வீழ்ந்த வானவன்", "fileName": "AppendixTamil21"},
    {"name": "22. ஜீஸஸ்", "fileName": "AppendixTamil22"},
    {"name": "23. வெளிப்பாட்டின் வரிசைக்கிரமம்", "fileName": "AppendixTamil23"},
    {
      "name":
          "24.போலியான இரண்டு வசனங்கள் குர்ஆனில் இருந்து நீக்கப்பட்டு விட்டன",
      "fileName": "AppendixTamil24"
    },
    {"name": "25. இவ்வுலகத்தின் முடிவு", "fileName": "AppendixTamil25"},
    {"name": "26. இஸ்லாமின் மூன்று தூதர்கள்", "fileName": "AppendixTamil26"},
    {"name": "27. உங்களுடைய கடவுள் யார்?", "fileName": "AppendixTamil27"},
    {
      "name":
          "28.முஹம்மத் தன் சொந்தக் கரத்தால் கடவுளின் வெளிப்பாடுகளை எழுதினார்",
      "fileName": "AppendixTamil28"
    },
    {"name": "29. இடம் பெறாத பஸ்மலஹ்", "fileName": "AppendixTamil29"},
    {"name": "30. பலதார மணம்", "fileName": "AppendixTamil30"},
    {
      "name":
          "31.பரிணாம வளர்ச்சி: தெய்வீகமாகக் கட்டுப்படுத்தப்பட்ட ஒரு செயல்முறை",
      "fileName": "AppendixTamil31"
    },
    {"name": "32. தீர்மானிக்கின்ற வயதான 40", "fileName": "AppendixTamil32"},
    {
      "name": "33. கடவுள் ஏன் இப்பொழுது ஒரு தூதரை அனுப்பினார்?",
      "fileName": "AppendixTamil33"
    },
    {
      "name": "34. கன்னித்தன்மை / கற்பு நெறி : மெய்விசுவாசிகளின் ஒரு பண்பு",
      "fileName": "AppendixTamil34"
    },
    {"name": "35. போதைப் பொருள்கள் & மதுவகைகள்", "fileName": "AppendixTamil35"},
    {
      "name": "36. மகத்தானதொரு தேசத்திற்கு என்ன விலை",
      "fileName": "AppendixTamil36"
    },
    {"name": "37. இஸ்லாமில் குற்றவியல்நீதிமுறை", "fileName": "AppendixTamil37"},
    {"name": "38. படைப்பாளரின் கையயாப்பம்", "fileName": "AppendixTamil38"},
  ];

  // English List
  static const List<Map<String, String>> englishAppendixList = [
    {"name": "1. One of the Greatest Miracles (74:35)", "fileName": "appendix1"},
    {"name": "2. God's Covenant Messenger (3:81)", "fileName": "appendix2"},
    {"name": "3. We made this Qur'an easy (54:17)", "fileName": "appendix3"},
    {
      "name": "4. Why was this Qur'an revealed in Arabic?",
      "fileName": "appendix4"
    },
    {"name": "5. Heaven and Hell", "fileName": "appendix5"},
    {"name": "6. Greatness of God", "fileName": "appendix6"},
    {"name": "7. Why were we created?", "fileName": "appendix7"},
    {"name": "8. The Myth of Parindurai", "fileName": "appendix8"},
    {"name": "9. Abraham: The Prophet of Islam", "fileName": "appendix9"},
    {"name": "10. Plural Use of God", "fileName": "appendix10"},
    {"name": "11. The Day of Resurrection", "fileName": "appendix11"},
    {"name": "12. The Mission of Prophet Muhammad", "fileName": "appendix12"},
    {"name": "13. The First Pillar of Islam:", "fileName": "appendix13"},
    {"name": "14. Rule", "fileName": "appendix14"},
    {"name": "15. Religious Duties: A Gift from God", "fileName": "appendix15"},
    {"name": "16. Food prohibitions", "fileName": "appendix16"},
    {"name": "17. Death", "fileName": "appendix17"},
    {"name": "18. Quran is all you need", "fileName": "appendix18"},
    {
      "name": "19. Hadith & Sunnah: Satanic inventions",
      "fileName": "appendix19"
    },
    {"name": "20. Qur'an: unlike any other book", "fileName": "appendix20"},
    {"name": "21. Satan: the fallen angel", "fileName": "appendix21"},
    {"name": "22. Jesus", "fileName": "appendix22"},
    {"name": "23. Order of Revelation", "fileName": "appendix23"},
    {
      "name": "24. Two spurious verses removed from Quran",
      "fileName": "appendix24"
    },
    {"name": "25. End of this world", "fileName": "appendix25"},
    {"name": "26. Three Messengers of Islam", "fileName": "appendix26"},
    {"name": "27. Who is your God?", "fileName": "appendix27"},
    {
      "name": "28. Muhammad wrote the revelations of God with his own hand",
      "fileName": "appendix28"
    },
    {"name": "29. Basmalah without place", "fileName": "appendix29"},
    {"name": "30. Polygamy", "fileName": "appendix30"},
    {
      "name": "31. Evolution : A Divinely Controlled Process",
      "fileName": "appendix31"
    },
    {"name": "32. The Decisive Age of 40", "fileName": "appendix32"},
    {"name": "33. Why Did God Send a Messenger Now?", "fileName": "appendix33"},
    {
      "name": "34. Virginity / Chastity : A Trait of True Believers",
      "fileName": "appendix34"
    },
    {"name": "35. Drugs & Liquors", "fileName": "appendix35"},
    {"name": "36. What Price for a Great Nation", "fileName": "appendix36"},
    {"name": "37. Criminal Justice in Islam", "fileName": "appendix37"},
    {"name": "38. Hand of the Creator", "fileName": "appendix38"},
  ];
}

enum CTab{
  tm,
  en,
  ar
}

class AppSize {
  static const double S_4 = 4.0;

  static const double S_8 = 8.0;

  static const double S_12 = 12.0;

  static const double S_10 = 10.0;

  static const double S_13 = 13.0;

  static const double S_14 = 14.0;

  static const double S_16 = 16.0;

  static const double S_20 = 20.0;

  static const double S_24 = 24.0;

  static const double S_26 = 26.0;

  static const double S_30 = 26.0;

  static const double S_34 = 34.0;

  static const double S_38 = 38.0;

  static const double S_40 = 40.0;

  static const double S_46 = 46.0;

  static const double S_54 = 54.0;

  static const double S_70 = 70.0;

  static const double S_80 = 80.0;

  static const double S_100 = 100.0;

  static const double S_140 = 140.0;

  static const double S_200 = 200.0;

  static const double S_250 = 250.0;

  static const double S_280 = 280.0;

  static const double S_350 = 350.0;
}

class LocalStings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Language Selection Screen
          'language_selection': 'Select your Language',
          // About Us Screen
          'about_us_title': 'About Us',
          'about_us':
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
          'read_quran': 'READ QURAN',
          // Drawer
          'app_title': 'Quran App',
          'item_1': 'Item 1',
          'item_2': 'Item 2',
          'change_language': 'Change Language',
          'setting': 'Setting',
          //AppBar
          'title': 'Quran',
          'create_note_title': 'Create Note',
          'edit_note_title': 'Edit Note',
          //SearchBar
          'search_field_hint': 'Search',
          'goto_seach_hint': 'Search Qur\'an',
          //TabBar
          'introduction': 'Introduction',
          'quran': 'Quran',
          'goto': 'Goto',
          'index': 'Index',
          'notes': 'Notes',
          'appendix': 'Appendix',
          //CreateEditNotes
          'note_title': 'Title',
          'add_details': 'Add Detail',
          'add_images': 'Add Image',
          'save': 'SAVE',
          // Notes Detail
          'notes_detail_title': 'Notes Details',
          //introduction detail:
          'introduction_detail':
              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley 

- of type and scrambled it to make a type   

- specimen book. It has survived not only five 

 - centuries, but also the leap into electronic 

- typesetting, remaining essentially unchanged. 

was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
          //Goto Dialog
          'enter_surah': 'Enter Surah',
          'enter_ayah': 'Enter Ayah',
          'add': 'Add',
          //Goto button
          'clear': 'Clear All',
          //Appendix detail
          'appendix_detail': 'Appendix Detail'
        },
        'ar_SA': {
          //Language Selection Screen
          'language_selection': 'اختر لغتك',
          // About Us Screen
          'about_us_title': 'معلومات عنا',
          'about_us':
              "لوريم إيبسوم هو ببساطة نص شكلي يستخدم في صناعة الطباعة والتنضيد. كان Lorem Ipsum هو النص الوهمي القياسي في الصناعة منذ القرن الخامس عشر الميلادي ، عندما أخذت طابعة غير معروفة لوحًا من النوع وتدافعت",
          'read_quran': 'اقرأ القرآن',
          // Drawer
          'app_title': 'تطبيق القرآن',
          'item_1': 'البند 1',
          'item_2': 'البند 2',
          'change_language': 'تغيير اللغة',
          'setting': 'ضبط',
          //AppBar
          'title': 'القرآن',
          'create_note_title': 'إنشاء ملاحظة',
          'edit_note_title': 'அறிவிப்பு மாற்றம்',
          //SearchBar
          'search_field_hint': 'يبحث',
          'goto_seach_hint': 'ابحث في القرآن',
          //TabBar
          'introduction': 'المقدمة',
          'quran': 'القرآن',
          'goto': 'بحث سريع',
          'index': 'فهرس',
          'notes': 'ملحوظات',
          'appendix': 'الملحق',
          // Notes Detail
          'notes_detail_title': 'Notes Details',
          //CreateEditNotes
          'note_title': 'عنوان',
          'add_details': 'اكتب التفاصيل',
          'add_images': 'إضافة الصور',
          'save': 'احفظها',
          //introduction detail:
          'introduction_detail':
              '''لوريم إيبسوم هو ببساطة نص شكلي يستخدم في صناعة الطباعة والتنضيد. كان Lorem Ipsum هو النص الوهمي القياسي في الصناعة منذ القرن الخامس عشر الميلادي ، عندما أخذت طابعة غير معروفة لوحًا

- من النوع وتدافع عليه لعمل نوع

- كتاب العينة. لقد نجا ليس فقط خمسة

 - قرون ، ولكن أيضًا القفزة الإلكترونية

- التنضيد ، يبقى دون تغيير جوهريا.

في الستينيات من القرن الماضي مع إصدار أوراق Letraset التي تحتوي على مقاطع Lorem Ipsum ، ومؤخرًا مع برامج النشر المكتبي مثل Aldus PageMaker بما في ذلك إصدارات Lorem Ipsum.''',
          //Goto Dialog
          'enter_surah': 'اكتب السورة',
          'enter_ayah': 'اكتب الآية',
          'add': 'يضيف',
          //Goto button
          'clear': 'حذف الكل',
        },
        'tm_IN': {
          //Language Selection Screen
          'language_selection': 'உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்',
          // About Us Screen
          'about_us_title': 'எங்களை பற்றி',
          'about_us':
              "லோரெம் இப்சம் என்பது அச்சிடும் மற்றும் தட்டச்சுத் துறையின் போலி உரை. லோரெம் இப்சம் என்பது 1500 களில் இருந்து தொழில்துறையின் நிலையான போலி உரையாக இருந்து வருகிறது, அப்போது தெரியாத அச்சுப்பொறி ஒரு கேலி வகையை எடுத்து துருவியது.",
          'read_quran': 'குரானைப் படியுங்கள்',
          // Drawer
          'app_title': 'குர்ஆன் ஆப்',
          'item_1': 'பொருள் 1',
          'item_2': 'பொருள் 2',
          'change_language': 'மொழியை மாற்றவும்',
          'setting': 'அமைத்தல்',
          //AppBar
          'title': 'குர்ஆன்',
          'create_note_title': 'குறிப்பை உருவாக்கவும்',
          'edit_note_title': 'تعديل الإشعار',
          //SearchBar
          'search_field_hint': 'தேடு',
          'goto_seach_hint': 'குர்ஆனைத் தேடுங்கள்',
          //TabBar
          'introduction': 'அறிமுகம்',
          'quran': 'குர்ஆன்',
          'goto': 'விரைவு தேடல்',
          'index': 'குறியீட்டு',
          'notes': 'குறிப்புகள்',
          'appendix': 'பிற்சேர்க்கை',
          // Notes Detail
          'notes_detail_title': 'குறிப்புகள் விவரங்கள்',
          //CreateEditNotes
          'note_title': 'தலைப்பு',
          'add_details': 'விவரங்களை எழுதுங்கள்',
          'add_images': 'படங்களை சேர்க்க',
          'save': 'இதை சேமி',
          //introduction detail:
          'introduction_detail':
              '''லோரெம் இப்சம் என்பது அச்சிடும் மற்றும் தட்டச்சுத் துறையின் போலி உரை. லோரெம் இப்சம் என்பது 1500 களில் இருந்து, அறியப்படாத அச்சுப்பொறி ஒரு கேலியை எடுத்ததிலிருந்து, தொழில்துறையின் நிலையான போலி உரையாக இருந்து வருகிறது.

- வகை மற்றும் ஒரு வகை செய்ய அதை துருவல்

- மாதிரி புத்தகம். அது ஐந்தில் மட்டும் உயிர் பிழைத்திருக்கிறது

 - நூற்றாண்டுகள், ஆனால் மின்னணு பாய்ச்சல்

- தட்டச்சு அமைப்பு, அடிப்படையில் மாறாமல் உள்ளது.

1960 களில் லோரெம் இப்சம் பத்திகளைக் கொண்ட லெட்ராசெட் தாள்களின் வெளியீட்டில் பிரபலமடைந்தது, மேலும் சமீபத்தில் ஆல்டஸ் பேஜ்மேக்கர் போன்ற டெஸ்க்டாப் பப்ளிஷிங் மென்பொருளுடன் லோரெம் இப்சம் பதிப்புகள் அடங்கும்.''',
          //Goto Dialog
          'enter_surah': 'சூராவை எழுதுங்கள்.',
          'enter_ayah': 'வசனம் எழுதுங்கள்',
          'add': 'கூட்டு',
          //Goto button
          'clear': 'அனைத்தையும் நீக்கு',
          //Appendix detail
          'appendix_detail': 'இணைப்பு விவரம்'
        },
        'ur_PK': {
          //Language Selection Screen
          'language_selection': 'زبان منتخب کریں',
          // About Us Screen
          'about_us_title': 'ہمارے بارے میں',
          'about_us':
              "Lorem Ipsum پرنٹنگ اور ٹائپ سیٹنگ انڈسٹری کا محض ڈمی ٹیکسٹ ہے۔ Lorem Ipsum 1500 کی دہائی سے انڈسٹری کا معیاری ڈمی ٹیکسٹ رہا ہے، جب ایک نامعلوم پرنٹر قسم کی ایک گیلی لے کر گھس گیا",
          'read_quran': 'قرآن پڑھیں',
          // Drawer
          'app_title': 'قرآن ایپ',
          'item_1': 'آئٹم 1',
          'item_2': 'آئٹم 2',
          'change_language': 'زبان تبدیل کریں',
          'setting': 'ترتیب',
          //AppBar
          'title': 'قرآن',
          'create_note_title': 'نوٹ بنائیں',
          'edit_note_title': 'نوٹس ترمیم',
          //SearchBar
          'search_field_hint': 'سورہ تلاش کریں۔',
          //TabBar
          'introduction': 'تعارف',
          'quran': 'قرآن',
          'goto': 'فوری تلاش',
          'index': 'انڈیکس',
          'notes': 'نوٹ',
          'appendix': 'اپینڈکس',
          // Notes Detail
          'notes_detail_title': 'Notes Details',
          //CreateEditNotes
          'note_title': 'عنوان',
          'add_details': 'تفصیلات لکھیں',
          'add_images': 'تصاویر شامل کریں',
          'save': 'محفوظ کریں',
          //introduction detail:
          'introduction_detail':
              '''Lorem Ipsum پرنٹنگ اور ٹائپ سیٹنگ انڈسٹری کا محض ڈمی ٹیکسٹ ہے۔ Lorem Ipsum 1500 کی دہائی کے بعد سے انڈسٹری کا معیاری ڈمی ٹیکسٹ رہا ہے، جب ایک نامعلوم پرنٹر نے ایک گیلی لے لی

- قسم کا اور ایک قسم بنانے کے لئے اسے گھمایا

- نمونہ کتاب. یہ صرف پانچ نہیں بچ گیا ہے۔

 - صدیوں، بلکہ الیکٹرانک میں چھلانگ

- ٹائپ سیٹنگ، بنیادی طور پر کوئی تبدیلی نہیں۔

1960 کی دہائی میں Lorem Ipsum حصئوں پر مشتمل Letraset شیٹس کے اجراء کے ساتھ اور حال ہی میں Aldus PageMaker جیسے ڈیسک ٹاپ پبلشنگ سافٹ ویئر کے ساتھ مقبول ہوا جس میں Lorem Ipsum کے ورژن بھی شامل ہیں۔`''',
          //Goto Dialog
          'enter_surah': 'سورہ لکھیں',
          'enter_ayah': 'آیت لکھیں',
          'add': 'شامل کریں',
          //Goto button
          'clear': 'حذف کریں',
        }
      };
}

class QuranData {
  static const List<Map<String, dynamic>> quranSurahList = 
  [
    {
        "number": 1,
        "name": "سُورَةُٱلْفَاتِحَةِ",
        "englishName": "The Key",
        "tamilName": "திறவு கோல்",
        "numberOfAyahs": 7
    },
    {
        "number": 2,
        "name": "سُورَةُ البَقَرَةِ",
        "englishName": "The Heifer",
        "tamilName": "பசுங்கன்று",
        "numberOfAyahs": 286
    },
    {
        "number": 3,
        "name": "سُورَةُ آلِ عِمۡرَانَ",
        "englishName": "The Amramites",
        "tamilName": "இம்ரானின் குடும்பத்தினர்",
        "numberOfAyahs": 200
    },
    {
        "number": 4,
        "name": "سُورَةُ النِّسَاءِ",
        "englishName": "Women",
        "tamilName": "பெண்கள்",
        "numberOfAyahs": 176
    },
    {
        "number": 5,
        "name": "سُورَةُ المَائـِدَةِ",
        "englishName": "The Feast",
        "tamilName": "விருந்து",
        "numberOfAyahs": 120
    },
    {
        "number": 6,
        "name": "سُورَةُ الأَنۡعَامِ",
        "englishName": "Livestock",
        "tamilName": "கால்நடை",
        "numberOfAyahs": 165
    },
    {
        "number": 7,
        "name": "سُورَةُ الأَعۡرَافِ",
        "englishName": "The Purgatory",
        "tamilName": "ஆன்மா தூய்மையடையும் இடம்",
        "numberOfAyahs": 206
    },
    {
        "number": 8,
        "name": "سُورَةُ الأَنفَالِ",
        "englishName": "The Spoils of War",
        "tamilName": "போரில் கைப்பற்றிய பொருட்கள்",
        "numberOfAyahs": 75
    },
    {
        "number": 9,
        "name": "سُورَةُ التَّوۡبَةِ",
        "englishName": "Ultimatum",
        "tamilName": "இறுதியான எச்சரிக்கை",
        "numberOfAyahs": 127
    },
    {
        "number": 10,
        "name": "سُورَةُ يُونُسَ",
        "englishName": "Jonah",
        "tamilName": "ஜோனா",
        "numberOfAyahs": 109
    },
    {
        "number": 11,
        "name": "سُورَةُ هُودٍ",
        "englishName": "Hûd",
        "tamilName": "ஹூத்",
        "numberOfAyahs": 123
    },
    {
        "number": 12,
        "name": "سُورَةُ يُوسُفَ",
        "englishName": "Joseph",
        "tamilName": "ஜோஸஃப்",
        "numberOfAyahs": 111
    },
    {
        "number": 13,
        "name": "سُورَةُ الرَّعۡدِ",
        "englishName": "Thunder",
        "tamilName": "இடியோசை",
        "numberOfAyahs": 43
    },
    {
        "number": 14,
        "name": "سُورَةُ إِبۡرَاهِيمَ",
        "englishName": "Abraham",
        "tamilName": "ஆப்ரஹாம்",
        "numberOfAyahs": 52
    },
    {
        "number": 15,
        "name": "سُورَةُ الحِجۡرِ",
        "englishName": "Al-Hijr Valley",
        "tamilName": "அல்-ஹிஜ்ர் பள்ளத்தாக்கு",
        "numberOfAyahs": 99
    },
    {
        "number": 16,
        "name": "سُورَةُ النَّحۡلِ",
        "englishName": "The Bee",
        "tamilName": "தேனீ",
        "numberOfAyahs": 128
    },
    {
        "number": 17,
        "name": "سُورَةُ الإِسۡرَاءِ",
        "englishName": "The Children of Israel",
        "tamilName": "இஸ்ரவேலின் சந்ததியினர்",
        "numberOfAyahs": 111
    },
    {
        "number": 18,
        "name": "سُورَةُ الكَهۡفِ",
        "englishName": "The Cave",
        "tamilName": "குகை",
        "numberOfAyahs": 110
    },
    {
        "number": 19,
        "name": "سُورَةُ مَرۡيَمَ",
        "englishName": "Mary",
        "tamilName": "மேரி",
        "numberOfAyahs": 98
    },
    {
        "number": 20,
        "name": "سُورَةُ طه",
        "englishName": "T.H.",
        "tamilName": "தா.ஹா.",
        "numberOfAyahs": 135
    },
    {
        "number": 21,
        "name": "سُورَةُ الأَنبِيَاءِ",
        "englishName": "The Prophets",
        "tamilName": "வேதம் வழங்கப்பட்டவர்கள்",
        "numberOfAyahs": 112
    },
    {
        "number": 22,
        "name": "سُورَةُ الحَجِّ",
        "englishName": "Pilgrimage",
        "tamilName": "புனித யாத்திரை",
        "numberOfAyahs": 78
    },
    {
        "number": 23,
        "name": "سُورَةُ المُؤۡمِنُونَ",
        "englishName": "The Believers",
        "tamilName": "நம்பிக்கையாளர்கள்",
        "numberOfAyahs": 118
    },
    {
        "number": 24,
        "name": "سُورَةُ النُّورِ",
        "englishName": "Light",
        "tamilName": "ஒளி",
        "numberOfAyahs": 64
    },
    {
        "number": 25,
        "name": "سُورَةُ الفُرۡقَانِ",
        "englishName": "The Statute Book",
        "tamilName": "சட்டப்புத்தகம்",
        "numberOfAyahs": 77
    },
    {
        "number": 26,
        "name": "سُورَةُ الشُّعَرَاءِ",
        "englishName": "The Poets",
        "tamilName": "கவிஞர்கள்",
        "numberOfAyahs": 227
    },
    {
        "number": 27,
        "name": "سُورَةُ النَّمۡلِ",
        "englishName": "The Ant",
        "tamilName": "எறும்பு",
        "numberOfAyahs": 93
    },
    {
        "number": 28,
        "name": "سُورَةُ القَصَصِ",
        "englishName": "History",
        "tamilName": "சரித்திரம்",
        "numberOfAyahs": 88
    },
    {
        "number": 29,
        "name": "سُورَةُ العَنكَبُوتِ",
        "englishName": "The Spider",
        "tamilName": "சிலந்திப் பூச்சி",
        "numberOfAyahs": 69
    },
    {
        "number": 30,
        "name": "سُورَةُ الرُّومِ",
        "englishName": "The Romans",
        "tamilName": "ரோமானியர்கள்",
        "numberOfAyahs": 60
    },
    {
        "number": 31,
        "name": "سُورَةُ لُقۡمَانَ",
        "englishName": "Luqman",
        "numberOfAyahs": 34,
        "tamilName": "லுக்மான்"
    },
    {
        "number": 32,
        "name": "سُورَةُ السَّجۡدَةِ",
        "englishName": "Prostration",
        "numberOfAyahs": 30,
        "tamilName": "சிர வணக்கம்"
    },
    {
        "number": 33,
        "name": "سُورَةُ الأَحۡزَابِ",
        "englishName": "The Parties",
        "numberOfAyahs": 73,
        "tamilName": "அணியினர்"
    },
    {
        "number": 34,
        "name": "سُورَةُ سَبَإٍ",
        "englishName": "Sheba",
        "numberOfAyahs": 54,
        "tamilName": "ஷீபா"
    },
    {
        "number": 35,
        "name": "سُورَةُ فَاطِرٍ",
        "englishName": "Initiator",
        "numberOfAyahs": 45,
        "tamilName": "துவக்குபவர்"
    },
    {
        "number": 36,
        "name": "سُورَةُ يسٓ",
        "englishName": "Y.S.",
        "numberOfAyahs": 83,
        "tamilName": "ய.ஸீ."
    },
    {
        "number": 37,
        "name": "سُورَةُ الصَّافَّاتِ",
        "englishName": "The Arrangers",
        "numberOfAyahs": 182,
        "tamilName": "வரிசைப்படுத்துவோர்"
    },
    {
        "number": 38,
        "name": "سُورَةُ صٓ",
        "englishName": "S",
        "numberOfAyahs": 88,
        "tamilName": "ஸ"
    },
    {
        "number": 39,
        "name": "سُورَةُ الزُّمَرِ",
        "englishName": "The Throngs",
        "numberOfAyahs": 75,
        "tamilName": "மக்கள் கூட்டங்கள்"
    },
    {
        "number": 40,
        "name": "سُورَةُ غَافِرٍ",
        "englishName": "Forgiver",
        "numberOfAyahs": 85,
        "tamilName": "மன்னிப்பவர்"
    },
    {
        "number": 41,
        "name": "سُورَةُ فُصِّلَتۡ",
        "englishName": "Detailed",
        "numberOfAyahs": 54,
        "tamilName": "விவரிக்கப்பட்டது"
    },
    {
        "number": 42,
        "name": "سُورَةُ الشُّورَىٰ",
        "englishName": "Consultation",
        "numberOfAyahs": 53,
        "tamilName": "கலந்தாலோசித்தல்"
    },
    {
        "number": 43,
        "name": "سُورَةُ الزُّخۡرُفِ",
        "englishName": "Ornaments",
        "numberOfAyahs": 89,
        "tamilName": "ஆபரணங்கள்"
    },
    {
        "number": 44,
        "name": "سُورَةُ الدُّخَانِ",
        "englishName": "Smoke",
        "numberOfAyahs": 59,
        "tamilName": "புகை"
    },
    {
        "number": 45,
        "name": "سُورَةُ الجَاثِيَةِ",
        "englishName": "Kneeling",
        "numberOfAyahs": 37,
        "tamilName": "மண்டியிடுதல்"
    },
    {
        "number": 46,
        "name": "سُورَةُ الأَحۡقَافِ",
        "englishName": "The Dunes",
        "numberOfAyahs": 35,
        "tamilName": "மணற்குன்றுகள்"
    },
    {
        "number": 47,
        "name": "سُورَةُ مُحَمَّدٍ",
        "englishName": "Muhammad",
        "numberOfAyahs": 38,
        "tamilName": "முஹம்மது"
    },
    {
        "number": 48,
        "name": "سُورَةُ الفَتۡحِ",
        "englishName": "Victory",
        "numberOfAyahs": 29,
        "tamilName": "வெற்றி"
    },
    {
        "number": 49,
        "name": "سُورَةُ الحُجُرَاتِ",
        "englishName": "The Walls",
        "numberOfAyahs": 18,
        "tamilName": "சுவர்கள்"
    },
    {
        "number": 50,
        "name": "سُورَةُ قٓ",
        "englishName": "Q",
        "numberOfAyahs": 45,
        "tamilName": "க"
    },
    {
        "number": 51,
        "name": "سُورَةُ الذَّارِيَاتِ",
        "englishName": "Drivers of the Winds",
        "numberOfAyahs": 60,
        "tamilName": "காற்றுகளைச் செலுத்துவோர்"
    },
    {
        "number": 52,
        "name": "سُورَةُ الطُّورِ",
        "englishName": "Mount Sinai",
        "numberOfAyahs": 49,
        "tamilName": "சினாய் மலை"
    },
    {
        "number": 53,
        "name": "سُورَةُ النَّجۡمِ",
        "englishName": "The Stars",
        "numberOfAyahs": 62,
        "tamilName": "நட்சத்திரங்கள்"
    },
    {
        "number": 54,
        "name": "سُورَةُ القَمَرِ",
        "englishName": "The Moon",
        "numberOfAyahs": 55,
        "tamilName": "நிலவு"
    },
    {
        "number": 55,
        "name": "سُورَةُ الرَّحۡمَٰن",
        "englishName": "Most Gracious",
        "numberOfAyahs": 78,
        "tamilName": "மிக்க அருளாளர்"
    },
    {
        "number": 56,
        "name": "سُورَةُ الوَاقِعَةِ",
        "englishName": "The Inevitable",
        "numberOfAyahs": 96,
        "tamilName": "தவிர்க்க இயலாதது"
    },
    {
        "number": 57,
        "name": "سُورَةُ الحَدِيدِ",
        "englishName": "Iron",
        "numberOfAyahs": 29,
        "tamilName": "இரும்பு"
    },
    {
        "number": 58,
        "name": "سُورَةُ المُجَادلَةِ",
        "englishName": "The Debate",
        "numberOfAyahs": 22,
        "tamilName": "தர்க்கம்"
    },
    {
        "number": 59,
        "name": "سُورَةُ الحَشۡرِ",
        "englishName": "Exodus",
        "numberOfAyahs": 24,
        "tamilName": "வெளியேற்றம்"
    },
    {
        "number": 60,
        "name": "سُورَةُ المُمۡتَحنَةِ",
        "englishName": "The Test",
        "numberOfAyahs": 13,
        "tamilName": "பரிசோதனை"
    },
    {
        "number": 61,
        "name": "سُورَةُ الصَّفِّ",
        "englishName": "The Column",
        "numberOfAyahs": 14,
        "tamilName": "அணிவகுப்பு"
    },
    {
        "number": 62,
        "name": "سُورَةُ الجُمُعَةِ",
        "englishName": "Friday",
        "numberOfAyahs": 11,
        "tamilName": "வெள்ளிக்கிழமை"
    },
    {
        "number": 63,
        "name": "سُورَةُ المُنَافِقُونَ",
        "englishName": "The Hypocrites",
        "numberOfAyahs": 11,
        "tamilName": "நயவஞ்சகர்கள்"
    },
    {
        "number": 64,
        "name": "سُورَةُ التَّغَابُنِ",
        "englishName": "Mutual Blaming",
        "numberOfAyahs": 18,
        "tamilName": "பரஸ்பரம் பழித்துக் கொள்ளுதல்"
    },
    {
        "number": 65,
        "name": "سُورَةُ الطَّلَاقِ",
        "englishName": "Divorce",
        "numberOfAyahs": 12,
        "tamilName": "விவாகரத்து"
    },
    {
        "number": 66,
        "name": "سُورَةُ التَّحۡرِيمِ",
        "englishName": "Prohibition",
        "numberOfAyahs": 12,
        "tamilName": "தடை செய்தல்"
    },
    {
        "number": 67,
        "name": "سُورَةُ المُلۡكِ",
        "englishName": "Kingship",
        "numberOfAyahs": 30,
        "tamilName": "அரசுரிமை"
    },
    {
        "number": 68,
        "name": "سُورَةُ القَلَمِ",
        "englishName": "The Pen",
        "numberOfAyahs": 52,
        "tamilName": "பேனா"
    },
    {
        "number": 69,
        "name": "سُورَةُ الحَاقَّةِ",
        "englishName": "Incontestable",
        "numberOfAyahs": 52,
        "tamilName": "மறுக்க இயலாதது"
    },
    {
        "number": 70,
        "name": "سُورَةُ المَعَارِجِ",
        "englishName": "The Heights",
        "numberOfAyahs": 44,
        "tamilName": "உயரங்கள்"
    },
    {
        "number": 71,
        "name": "سُورَةُ نُوحٍ",
        "englishName": "Noah",
        "numberOfAyahs": 28,
        "tamilName": "நோவா"
    },
    {
        "number": 72,
        "name": "سُورَةُ الجِنِّ",
        "englishName": "The Jinn",
        "numberOfAyahs": 28,
        "tamilName": "ஜின்கள்"
    },
    {
        "number": 73,
        "name": "سُورَةُ المُزَّمِّلِ",
        "englishName": "Cloaked",
        "numberOfAyahs": 20,
        "tamilName": "அங்கி அணிந்தவர்"
    },
    {
        "number": 74,
        "name": "سُورَةُ المُدَّثِّرِ",
        "englishName": "The Hidden secret",
        "numberOfAyahs": 56,
        "tamilName": "மறைக்கப்பட்ட இரகசியம்"
    },
    {
        "number": 75,
        "name": "سُورَةُ القِيَامَةِ",
        "englishName": "Resurrection",
        "numberOfAyahs": 40,
        "tamilName": "மீண்டும் உயிர்ப்பித்தெழுப்புதல்"
    },
    {
        "number": 76,
        "name": "سُورَةُ الإِنسَانِ",
        "englishName": "The Human",
        "numberOfAyahs": 31,
        "tamilName": "மனிதர்"
    },
    {
        "number": 77,
        "name": "سُورَةُ المُرۡسَلَاتِ",
        "englishName": "Dispatched",
        "numberOfAyahs": 50,
        "tamilName": "அனுப்பப்படுகின்றவர்கள்"
    },
    {
        "number": 78,
        "name": "سُورَةُ النَّبَإِ",
        "englishName": "The Event",
        "numberOfAyahs": 40,
        "tamilName": "அந்த நிகழ்வு"
    },
    {
        "number": 79,
        "name": "سُورَةُ النَّازِعَاتِ",
        "englishName": "The Snatchers",
        "numberOfAyahs": 46,
        "tamilName": "பறிப்பவர்கள்"
    },
    {
        "number": 80,
        "name": "سُورَةُ عَبَسَ",
        "englishName": "He Frowned",
        "numberOfAyahs": 42,
        "tamilName": "அவர் முகம் சுளித்தார்"
    },
    {
        "number": 81,
        "name": "سُورَةُ التَّكۡوِيرِ",
        "englishName": "The Rolling",
        "numberOfAyahs": 29,
        "tamilName": "சுருட்டுதல்"
    },
    {
        "number": 82,
        "name": "سُورَةُ الانفِطَارِ",
        "englishName": "The Shattering",
        "numberOfAyahs": 19,
        "tamilName": "துண்டு துண்டாக நொறுங்குதல்"
    },
    {
        "number": 83,
        "name": "سُورَةُ المُطَفِّفِينَ",
        "englishName": "The Cheaters",
        "numberOfAyahs": 36,
        "tamilName": "ஏமாற்றுபவர்கள்"
    },
    {
        "number": 84,
        "name": "سُورَةُ الانشِقَاقِ",
        "englishName": "The Rupture",
        "numberOfAyahs": 25,
        "tamilName": "பிளவு"
    },
    {
        "number": 85,
        "name": "سُورَةُ البُرُوجِ",
        "englishName": "The Galaxies",
        "numberOfAyahs": 22,
        "tamilName": "வானிலுள்ள பால்வீதி"
    },
    {
        "number": 86,
        "name": "سُورَةُ الطَّارِقِ",
        "englishName": "The Bright Star",
        "numberOfAyahs": 17,
        "tamilName": "பிரகாசமான நட்சத்திரம்"
    },
    {
        "number": 87,
        "name": "سُورَةُ الأَعۡلَىٰ",
        "englishName": "The Most High",
        "numberOfAyahs": 19,
        "tamilName": "மிகவும் மேலானவர்"
    },
    {
        "number": 88,
        "name": "سُورَةُ الغَاشِيَةِ",
        "englishName": "The Overwhelming",
        "numberOfAyahs": 26,
        "tamilName": "திணற அடித்தல்"
    },
    {
        "number": 89,
        "name": "سُورَةُ الفَجۡرِ",
        "englishName": "Dawn",
        "numberOfAyahs": 30,
        "tamilName": "விடியற்காலை"
    },
    {
        "number": 90,
        "name": "سُورَةُ البَلَدِ",
        "englishName": "The Town",
        "numberOfAyahs": 20,
        "tamilName": "நகரம்"
    },
    {
        "number": 91,
        "name": "سُورَةُ الشَّمۡسِ",
        "englishName": "The Sun",
        "numberOfAyahs": 15,
        "tamilName": "சூரியன்"
    },
    {
        "number": 92,
        "name": "سُورَةُ اللَّيۡلِ",
        "englishName": "The Night",
        "numberOfAyahs": 21,
        "tamilName": "இரவு"
    },
    {
        "number": 93,
        "name": "سُورَةُ الضُّحَىٰ",
        "englishName": "The Forenoon",
        "numberOfAyahs": 11,
        "tamilName": "முற்பகல்"
    },
    {
        "number": 94,
        "name": "سُورَةُ الشَّرۡحِ",
        "englishName": "Cooling the Temper",
        "numberOfAyahs": 8,
        "tamilName": "கோபத்தைத் தணித்தல்"
    },
    {
        "number": 95,
        "name": "سُورَةُ التِّينِ",
        "englishName": "The Fig",
        "numberOfAyahs": 8,
        "tamilName": "அத்தி"
    },
    {
        "number": 96,
        "name": "سُورَةُ العَلَقِ",
        "englishName": "The Embryo",
        "numberOfAyahs": 19,
        "tamilName": "கரு"
    },
    {
        "number": 97,
        "name": "سُورَةُ القَدۡرِ",
        "englishName": "Destiny",
        "numberOfAyahs": 5,
        "tamilName": "விதி"
    },
    {
        "number": 98,
        "name": "سُورَةُ البَيِّنَةِ",
        "englishName": "Proof",
        "numberOfAyahs": 8,
        "tamilName": "சான்று"
    },
    {
        "number": 99,
        "name": "سُورَةُ الزَّلۡزَلَةِ",
        "englishName": "The Quake",
        "numberOfAyahs": 8,
        "tamilName": "நடுக்கம்"
    },
    {
        "number": 100,
        "name": "سُورَةُ العَادِيَاتِ",
        "englishName": "The Gallopers",
        "numberOfAyahs": 11,
        "tamilName": "பாய்ந்தோடுபவை"
    },
    {
        "number": 101,
        "name": "سُورَةُ القَارِعَةِ",
        "englishName": "The Shocker",
        "numberOfAyahs": 11,
        "tamilName": "அதிர்ச்சியூட்டுவது"
    },
    {
        "number": 102,
        "name": "سُورَةُ التَّكَاثُرِ",
        "englishName": "Hoarding",
        "numberOfAyahs": 8,
        "tamilName": "பதுக்கி வைத்தல்"
    },
    {
        "number": 103,
        "name": "سُورَةُ العَصۡرِ",
        "englishName": "The Afternoon",
        "numberOfAyahs": 3,
        "tamilName": "பிற்பகல்"
    },
    {
        "number": 104,
        "name": "سُورَةُ الهُمَزَةِ",
        "englishName": "The Backbiter",
        "numberOfAyahs": 9,
        "tamilName": "புறங்கூறுபவன்"
    },
    {
        "number": 105,
        "name": "سُورَةُ الفِيلِ",
        "englishName": "The Elephant",
        "numberOfAyahs": 5,
        "tamilName": "யானை"
    },
    {
        "number": 106,
        "name": "سُورَةُ قُرَيۡشٍ",
        "englishName": "The Quraish Tribe",
        "numberOfAyahs": 4,
        "tamilName": "குறைஷிக் குலம்"
    },
    {
        "number": 107,
        "name": "سُورَةُ المَاعُونِ",
        "englishName": "Charity",
        "numberOfAyahs": 7,
        "tamilName": "தர்மம்"
    },
    {
        "number": 108,
        "name": "سُورَةُ الكَوۡثَرِ",
        "englishName": "Bounty",
        "numberOfAyahs": 3,
        "tamilName": "அருட்கொடை"
    },
    {
        "number": 109,
        "name": "سُورَةُ الكَافِرُونَ",
        "englishName": "The Disbelievers",
        "numberOfAyahs": 6,
        "tamilName": "நம்பமறுப்பவர்கள்"
    },
    {
        "number": 110,
        "name": "سُورَةُ النَّصۡرِ",
        "englishName": "Triumph",
        "numberOfAyahs": 3,
        "tamilName": "மாபெரும் வெற்றி"
    },
    {
        "number": 111,
        "name": "سُورَةُ المَسَدِ",
        "englishName": "Thorns",
        "numberOfAyahs": 5,
        "tamilName": "முட்கள்"
    },
    {
        "number": 112,
        "name": "سُورَةُ الإِخۡلَاصِ",
        "englishName": "Absoluteness",
        "numberOfAyahs": 4,
        "tamilName": "பரிபூரணத்துவம்"
    },
    {
        "number": 113,
        "name": "سُورَةُ الفَلَقِ",
        "englishName": "Daybreak",
        "numberOfAyahs": 5,
        "tamilName": "வைகறை"
    },
    {
        "number": 114,
        "name": "سُورَةُ النَّاسِ",
        "englishName": "People",
        "numberOfAyahs": 6,
        "tamilName": "மனிதர்கள்"
    }
];
}