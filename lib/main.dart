import 'package:flutter/material.dart';
import 'package:tutorial/App.dart';
import 'package:tutorial/Splash.dart';
import 'package:tutorial/test.dart';
import 'package:tutorial/test2.dart';
import 'package:tutorial/tutorial.dart';


void main() {
  runApp(new MaterialApp(
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/tutorial': (_) => new MyHomePage(),
      '/home': (_) => new Splash2(),
      '/which': (_) => new Splash3(),
      '/others': (_) => new Others(),
      '/next': (_) => new MyApp(),
    },
  ));
}

// デフォルト設定 //


//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text("Home"),
//      ),
//      body: new Center(
//        child: new RaisedButton(
//          child: const Text("Launch Next Screen"),
//          onPressed: () {
//            // その他の画面へ
//            Navigator.of(context).pushNamed("/next");
//          },
//        ),
//      ),
//    );
//  }
//}



// ---------
// その他画面
// ---------
class Next extends StatefulWidget {
  @override
  _NextState createState() => new _NextState();
}

class _NextState extends State<Next> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Next"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Launch Next Screen"),
              onPressed: () {
                // その他の画面へ
                Navigator.of(context).pushNamed("/next");
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Home"),
              onPressed: () {
                // ホーム画面へ戻る　
                Navigator.popUntil(context, ModalRoute.withName("/home"));
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("Logout"),
              onPressed: () {
                // 確認ダイアログ表示
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      content: const Text('Do you want logout?'),
                      actions: <Widget>[
                        new FlatButton(
                          child: const Text('No'),
                          onPressed: () {
                            // 引数をfalseでダイアログ閉じる
                            Navigator.of(context).pop(false);
                          },
                        ),
                        new FlatButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            // 引数をtrueでダイアログ閉じる
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                ).then<void>((aBool) {
                  // ダイアログがYESで閉じられたら...
                  if (aBool) {
                    // 画面をすべて除いてスプラッシュを表示
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Splash()),
                            (_) => false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}