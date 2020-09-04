import 'dart:math';

import 'package:flutter/material.dart';
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
//    setState(() {
//      userName = a;
//    });
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
    _availableGPS();
    return Center(
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
            Text('ユーザーID:' + a),
            Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: 40.0, width: 140.0),
                  child: RaisedButton(
                    color: const Color(0xfff3f3f3),
                    child: Text("デバイス検知を許可"), // 旧 ホスト
                    onPressed: () async {
                      await Nearby().startAdvertising(
                        a,
                        strategy,
                        onConnectionResult: (id, status) {},
                        onDisconnected: (id) {},
                        onConnectionInitiated: (String endpointId,
                            ConnectionInfo connectionInfo) {},
                      );
                    },
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: 40.0, width: 140.0),
                  child: RaisedButton(
                    color: const Color(0xfff3f3f3),
                    child: Text("デバイスを探す"), // 旧 クライアント
                    onPressed: () async {
                      await Nearby().startDiscovery(
                        a,
                        strategy,
                        onEndpointFound: (id, name, serviceId) {
                          _foundDevices(name);
                        },
                        onEndpointLost: (id) {
                          _lostDevices();
                        },
                      );
                    },
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: 40.0, width: 140.0),
                  child: RaisedButton(
                    color: const Color(0xfff3f3f3),
                    child: Text("全機能を停止"),
                    onPressed: () async {
                      await Nearby().stopAllEndpoints();
                      _lostDevices();
//                    _getPrefItems1();
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            Text("デバイスリスト"),
            Text(_deviceList[0]),
            Text(_deviceList[1]),
            Text(_deviceList[2]),
            Text(_deviceList[3]),
            Text(_deviceList[4]),
            Text(_deviceList[5]),
            Text(_deviceList[6]),
            Text(_deviceList[7]),
            Text(_deviceList[8]),
            Text(_deviceList[9]),
            Text(_deviceList[10]),
            Text(_deviceList[11]),
            Text(_deviceList[12]),
            Text(_deviceList[13]),
            Text(_deviceList[14]),
            Text(_deviceList[15]),
            Text(_deviceList[16]),
            Text(_deviceList[17]),
            Text(_deviceList[18]),
            Text(_deviceList[19]),
          ],
        ),
      ),
    );
  }
}
