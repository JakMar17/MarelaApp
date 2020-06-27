import 'package:shared_preferences/shared_preferences.dart';
import 'package:vreme/data/shared_preferences/shared_preferences.dart';

class SettingsPreferences {

  SharedPreferences _sharedPreferences;

  final String showCategory = "settings_show_categories";
  final String showClose = "settings_show_close_data";
  final String notifyWarnings = "settings_warnings_notify";
  final String notifyWarningsLevel = "settings_warnings_notify_level";
  final String notifyWarningRegions = "settings_warnings_notify_regions";

  SettingsPreferences() {
    Preferences p = Preferences();
    _sharedPreferences = p.getPreferences();
  }

  bool getSetting(String name) {
    try{
      bool x = _sharedPreferences.getBool(name);
      return x == null ? true : x;
      } catch(Exception) {
        return false;
      }
  }

  void setSetting(String name, bool value) {
    try{
        _sharedPreferences.setBool(name, value);
      } catch(Exception) {
        print("error");
      }
  }

  String getStringSetting(String name) {
    try{
      String x = _sharedPreferences.getString(name);
      return x;
      } catch(Exception) {
        return null;
      }
  }

  void setStringSetting(String name, String value) {
    try{
        _sharedPreferences.setString(name, value);
      } catch(Exception) {
        print("error");
      }
  }

  List<String> getStringListSetting(String name) {
    try{
      List<String> x = _sharedPreferences.getStringList(name);
      return x;
      } catch(Exception) {
        return null;
      }
  }

  void setStringListSetting(String name, List<String> values) {
    try{
        _sharedPreferences.setStringList(name, values);
      } catch(Exception) {
        print("error");
      }
  }
}

class SettingPreference {
  String id;
  String value;

  SettingPreference({
    this.id,
    this.value
  });
}