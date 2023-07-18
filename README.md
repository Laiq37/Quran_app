Description
The Quran app is a cross-platform mobile application developed using Flutter, designed to provide a seamless Quran reading experience for users on both Android and iOS devices. The app incorporates various features and functionalities to enhance the user's interaction with the Quran.

Features
Multi-Language Support: The Quran app supports two languages, English and Tamil, allowing users to read the Quran in their preferred language.
![select_language](https://github.com/Laiq37/mahsa_chat/assets/51846274/4b427200-0d29-4ac1-98db-95e91f3f676e)

Go-To Page: Users can search for any specific verse (ayat) from any Surah (chapter) in the Quran. The selected verse is added to the "Go-To Listing" and saved locally using a SQLite database.
![find_ayaat_from_quran](https://github.com/Laiq37/mahsa_chat/assets/51846274/33d9c08d-f6f3-4b9d-8640-b66714ff068f)
![listing_of_goto_search_ayaat](https://github.com/Laiq37/mahsa_chat/assets/51846274/9781039f-e6bf-45c2-9d7e-0b9a27bfdd17)

Quran Page: This page lists all the Surahs in the Quran. Users can navigate through the Surahs and view the corresponding verses (ayat) within each Surah. The app also provides a search functionality within the Quran page, highlighting matching text in the verses.
![surah_listing](https://github.com/Laiq37/mahsa_chat/assets/51846274/709cc09b-5234-445c-81d1-cb2539d68580)
![find_ayaat_from_quran](https://github.com/Laiq37/mahsa_chat/assets/51846274/d8ed2d25-8e08-4c9e-a5ec-275a311cf817)

Multiple Language Options: Users have the flexibility to view the verses in three different languages: English, Arabic, and Tamil.
![arabic_ayaat_translation](https://github.com/Laiq37/mahsa_chat/assets/51846274/89634749-f595-453c-afe8-fa864ab98579)
![tamil_ayaat_translation](https://github.com/Laiq37/mahsa_chat/assets/51846274/3d193e75-d8ce-47ac-909c-99a07e2ac3fc)

Sharing Capability: The app allows users to easily share individual verses or multiple verses outside of the app, enabling them to share their favorite verses with friends and family.
![share_multiple_ayaat](https://github.com/Laiq37/mahsa_chat/assets/51846274/7e1233e4-f666-40c8-ba53-0ae74838c323)

Technologies Used
Flutter: The app is developed using the Flutter framework, providing a robust and cross-platform mobile development environment.
GetX: The GetX package is used for state management within the app, ensuring efficient and reactive application behavior.
SQLite: The app utilizes the Sqflite plugin, which is a SQLite database implementation for Flutter, to store and retrieve the user's saved "Go-To Listing."
