import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ---------
// スプラッシュ
// ---------
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  bool _first = true;

  @override
  void initState() {
    super.initState();
    _getPrefItems();
    new Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // スプラッシュアニメーション
        child: const CircularProgressIndicator(),
      ),
    );
  }

  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      _first = prefs.getBool('first') ?? true;
    });
  }

  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setBool('first', false);
  }

  void handleTimeout() {
    // ログイン画面へ
    if (_first) {
      _setPrefItems();
      Navigator.of(context).pushReplacementNamed("/tutorial");
    } else {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }
}

// -----------------------------------------------------------------------------
// スプラッシュ2
// -----------------------------------------------------------------------------

// ignore: non_constant_identifier_names
String _Name, _Room, _Dormitory;
var _data1;
String a;

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  bool second;

  _getPrefItems() async {
    second = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      second = prefs.getBool('second') ?? true;
    });
  }

  _getPrefItems1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      a = prefs.getString('id') ?? 'IDがありません';
    });
  }

  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setBool('second', false);
    await prefs.setString('id', a);
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      _Name = prefs.getString('Name') ?? "無";
      _Dormitory = prefs.getString('Dormitory') ?? "無";
      _Room = prefs.getString('Room') ?? "000";
    });

    final getresponse =
        await http.post("https://test.takedano.com/getdata.php", body: {
      "Name": _Name,
      "Dormitory": _Dormitory,
      "Room": _Room,
    });
    setState(() {
      _data1 = json.decode(getresponse.body);
      a = _data1[0]['id'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefItems();
    if (second) {
      getdata();
      _setPrefItems();
    } else {
      _getPrefItems1();
    }
    new Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        //スプラッシュアニメーション
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void handleTimeout() {
    // ログイン画面へ
    Navigator.of(context).pushReplacementNamed("/next");
  }
}
