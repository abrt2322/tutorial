import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class Splash3 extends StatefulWidget {
  @override
  _Splash3State createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  var _nowTime = DateTime.now();
  final _dateFormat = new DateFormat.Hms();

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    Timer.periodic(Duration(milliseconds: 33),
        (Timer timer) => setState(() => _nowTime = DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    var text = _dateFormat.format(_nowTime);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('What do you do?'),
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
              Image.asset('images/3.png'),
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Image.asset(
                        'images/4.png',
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/next');
//                  changeDiceFace();
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Image.asset(
                        'images/5.png',
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
      ),
    );
  }
}
