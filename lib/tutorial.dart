import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

import 'tutorial_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("チュートリアルはスキップできません"),
          ));
        },
        finishCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
              content: Text("チュートリアル終了"),
              action: SnackBarAction(
                label: "ホームへ",
                onPressed: () {
//                  getdata();
                  Navigator.of(context).pushReplacementNamed("/home");
                },
              )));
        },
      ),
    );
  }

  final pages = [
//    PageModel.withChild(
//      child: Padding(
//        child: T(),
//        padding: EdgeInsets.only(bottom: 25.0),
//      ),
//      color: const Color(0xFF0097A7),
//      doAnimateChild: true),
    PageModel(
        color: const Color(0xFF2e499d),
        imageAssetPath: 'images/1.png',
        title: 'Roll call system',
        body: 'Now, we are starting tutorial and setting!',
        doAnimateImage: true),
    PageModel.withChild(
        child: new Padding(
          padding: new EdgeInsets.only(bottom: 25.0),
          child: T(),
        ),
        color: const Color(0xFF2e499d),
        doAnimateChild: true),
    PageModel(
        color: const Color(0xFF2e499d),
        imageAssetPath: 'images/3.png',
        title: 'How to use this app?',
        body: '1. 点呼当番か非点呼者か洗濯 \n'
            '2. 非点呼者がID送信ボタンを押下\n '
            '3. 点呼当番が点呼完了ボタンを押下\n ',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF2e499d),
        imageAssetPath: 'images/2.png',
        title: 'Setting Finish!',
        body: 'You are finished setting this up\n'
            'Please enter under button "finish" ',
        doAnimateImage: true)
//    PageModel(
//        child: Padding(
//          padding: EdgeInsets.only(bottom: 25.0),
//          child: Image.asset('asset/02.png', width: 300.0, height: 300.0),
//        ),
//        color: const Color(0xFF2e499d),
//        doAnimateChild: false)
  ];
}
