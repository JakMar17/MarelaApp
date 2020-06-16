import 'package:flutter/material.dart';
import 'package:vreme/data/shared_preferences/favorites.dart';
import 'package:vreme/screens/custom_search.dart';
import 'package:vreme/screens/drawer/about_app.dart';
import 'package:vreme/screens/home/home.dart';
import 'package:vreme/screens/home/loading.dart';
import 'package:vreme/screens/home/reordering_favorites.dart';
import 'package:vreme/screens/maps/map.dart';
import 'package:vreme/screens/settings/settings.dart';
import 'package:vreme/screens/text_napoved/text_napoved.dart';
import 'package:vreme/screens/vodotoki/list_vodotoki.dart';
import 'package:vreme/screens/vodotoki/vodotok_detail.dart';
import 'package:vreme/screens/vremenska_napoved/list_napoved.dart';
import 'package:vreme/screens/vremenska_napoved/napoved_detail.dart';
import 'package:vreme/screens/vremenske_razmere/list_postaje.dart';
import 'package:vreme/screens/vremenske_razmere/postaja.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Favorites favorites = Favorites();
  await favorites.setPreferences();

  runApp(MaterialApp(
    initialRoute: "/loading",
    routes: {
      '/': (context) => Home(),
      '/postaja': (context) => PostajaDetail(),
      '/loading': (context) => Loading(),
      '/postaje': (context) => ListOfPostaje(),
      '/vodotoki': (context) => ListOfVodotoki(),
      '/vodotok': (context) => VodotokDetail(),
      '/search': (context) => CustomSearch(),
      '/napovedi': (context) => ListOfNapovedi(),
      '/napoved': (context) => NapovedDetail(),
      '/napoved/tekst': (context) => TekstovnaNapoved(),
      '/map': (context) => MapOfSlovenia(),
      '/about': (context) => AboutApp(),
      '/reorder/favorites': (context) => ReorderingFavorites(),
      '/settings': (sontext) => SettingsScreen()
    },
    debugShowCheckedModeBanner: false,
  ));
}
