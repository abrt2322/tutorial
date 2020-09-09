import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
//class Which extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(){
//  return MaterialApp(
//  title: 'What do you want to do?',
//  theme: ThemeData(
//  visualDensity: VisualDensity.adaptivePlatformDensity,
//  ),
//  home: Splash3(title: 'What do you want to do?'),
//  );
//  }
//}

class Others extends StatefulWidget {
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  var _nowTime = DateTime.now();
  final _dateFormat = new DateFormat.Hms();
  String a = "";

  @override
  void initState() {
    super.initState();
    _initTimer();
    _getPrefItems1();
  }

  _getPrefItems1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      a = prefs.getString('id') ?? "0";
    });
  }

  void _initTimer() {
    Timer.periodic(Duration(milliseconds: 33),
        (Timer timer) => setState(() => _nowTime = DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    var text = _dateFormat.format(_nowTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('一般階員の画面'),
        backgroundColor: const Color(0xFF2e499d),
      ),
      body: Container(
        color: const Color(0xFFbcbcbc),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '現在時刻：' + text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black.withOpacity(1.0),
              ),
            ),
            Text(
              'ユーザーID:' + a,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black.withOpacity(1.0),
              ),
            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//            RaisedButton(
//              child: Text("Button"),
//              color: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(10.0),
//              ),
//              onPressed: () {},
//            ),
//            RaisedButton(
//              child: Text("Button"),
//              color: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(10.0),
//              ),
//              onPressed: () {},
//            ),
//              Image.asset('images/7.png'),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Image.asset(
                      'images/6.png',
                    ),
                    onPressed: () {
//                  changeDiceFace();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
