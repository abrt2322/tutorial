import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

String a;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2e499d),
        title: const Text('点呼係の画面'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<Body> {
  final Strategy strategy = Strategy.P2P_STAR;

  _getPrefItems1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      a = prefs.getString('id') ?? "0";
    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefItems1();
    _initTimer();
//    setState(() {
//      userName = a;
//    });
  }

  var _nowTime = DateTime.now();
  final _dateFormat = new DateFormat.Hms();

  void _initTimer() {
    Timer.periodic(Duration(milliseconds: 33),
        (Timer timer) => setState(() => _nowTime = DateTime.now()));
  }

  String userName = Random().nextInt(10000).toString();
//  String userName = a;
//  String userName = a;
//  void _userNameForm(String e) {
//    setState(() {
//      userName = e;
//    });
//  }

  List<String> _deviceList = List.filled(20, "");
  int i = 0;

  void _foundDevices(String e) {
    setState(() {
      _deviceList[i] = e;
      i++;
      if (i > 19) i = 0;
    });
  }

  void _lostDevices() {
    setState(() {
      _deviceList = List.filled(20, "");
      i = 0;
    });
  }

  Future<void> _availableGPS() async {
    if (!await Nearby().checkLocationPermission()) {
      Nearby().askLocationPermission();
    }
    if (!await Nearby().checkLocationEnabled()) {
      Nearby().enableLocationServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = _dateFormat.format(_nowTime);
    _availableGPS();
    return Container(
      color: const Color(0xFFbcbcbc),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: ListView(
          children: <Widget>[
//            Text("入力フォーム"),
//            Wrap(
//              children: <Widget>[
//                new TextField(
//                  decoration:
//                  new InputDecoration(labelText: "Enter your userName"),
//                  onChanged: _userNameForm,
//                ),
//              ],
//            ), // 入力フォーム
//            Divider(),

            Center(
              child: Text(
                '現在時刻：' + text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black.withOpacity(1.0),
                ),
              ),
            ),
            Center(
              child: Text(
                'ユーザーID:' + a,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black.withOpacity(1.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Image.asset(
                        'images/4.png',
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/next");
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Image.asset(
                        'images/4.png',
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/next");
                      },
                    ),
                  ),
//                ConstrainedBox(
//                  constraints:
//                      BoxConstraints.expand(height: 40.0, width: 140.0),
//                  child: RaisedButton(
//                    color: const Color(0xfff3f3f3),
//                    child: Text("デバイス検知を許可"), // 旧 ホスト
//                    onPressed: () async {
//                      await Nearby().startAdvertising(
//                        a,
//                        strategy,
//                        onConnectionResult: (id, status) {},
//                        onDisconnected: (id) {},
//                        onConnectionInitiated: (String endpointId,
//                            ConnectionInfo connectionInfo) {},
//                      );
//                    },
//                  ),
//                ),
//                ConstrainedBox(
//                  constraints:
//                      BoxConstraints.expand(height: 40.0, width: 140.0),
//                  child: RaisedButton(
//                    color: const Color(0xfff3f3f3),
//                    child: Text("デバイスを探す"), // 旧 クライアント
//                    onPressed: () async {
//                      await Nearby().startDiscovery(
//                        a,
//                        strategy,
//                        onEndpointFound: (id, name, serviceId) {
//                          _foundDevices(name);
//                        },
//                        onEndpointLost: (id) {
//                          _lostDevices();
//                        },
//                      );
//                    },
//                  ),
//                ),
//                ConstrainedBox(
//                  constraints:
//                      BoxConstraints.expand(height: 40.0, width: 140.0),
//                  child: RaisedButton(
//                    color: const Color(0xfff3f3f3),
//                    child: Text("全機能を停止"),
//                    onPressed: () async {
//                      await Nearby().stopAllEndpoints();
//                      _lostDevices();
////                    _getPrefItems1();
//                    },
//                  ),
//                ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Center(
                child: Text(
                  "点呼リスト",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.black.withOpacity(1.0),
                  ),
                ),
              ),
            ),

            Center(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "101 - 武田恋 :",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'images/8.png',
                                width: 15.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'images/9.png',
                                width: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "101 - 武田恋：",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'images/8.png',
                                width: 15.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'images/9.png',
                                width: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
