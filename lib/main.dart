import 'package:flutter/material.dart';
import 'ThemeItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<ThemeItem> data = List();

  String dynTheme;
  Future<void> getDefault() async {
    data = ThemeItem.getThemeItems();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynTheme = prefs.getString("dynTheme") ?? 'light-purple-amber';
    print(dynTheme);
  }

  @override
  Widget build(BuildContext context) {
    getDefault();
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (Brightness brightness) {
          getDefault();
          for (int i = 0; i < data.length; i++) {
            if (data[i].slug == this.dynTheme) {
              return data[i].themeData;
            }
          }
          return data[0].themeData;          
        },
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            theme: theme,
            title: "Switching themes like a fox",
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        });
  }
}
