import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _theme = "Light";
  var _themeData = ThemeData.light();

  @override
  void initState(){
    super.initState();
    _loadTheme();
  }

  _loadTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      _theme = (prefs.getString("theme") ?? "Light");
      _themeData = _theme == "Dark" ? ThemeData.dark() : ThemeData.light();
    });
  }

  _setTheme(theme) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      _theme = theme;
      _themeData = _theme == "Dark" ? ThemeData.dark() : ThemeData.light();
      prefs.setString("theme", theme);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Shared Preferences",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _setTheme("Light");
              },
              child: Text(
                "Claro",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _setTheme("Dark");
              },
              child: Text(
                "Escuro",
              ),
            ),
          ],
        ),
      ),
    );
  }
}