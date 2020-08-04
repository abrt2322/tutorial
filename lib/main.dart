import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/tutorial': (_) => new MyHomePage(),
      '/home': (_) => new MyApp(),
      '/next': (_) => new Next(),
    },
  ));
}

int c;
// ignore: non_constant_identifier_names
String _Name, _Room, _Dormitory;

String a;
int b;
var _data1;
String x,y,z;

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
        // TODO: スプラッシュアニメーション
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
    if(_first){
      _setPrefItems();
      Navigator.of(context).pushReplacementNamed("/tutorial");
    }else{
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }
}

// ---------
// ログイン画面
// ---------

class T extends StatefulWidget {
  @override
  _T createState() => _T();
}

class _T extends State<T> {
  // ignore: non_constant_identifier_names
  TextEditingController Name =new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Dormitory =new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Room =new TextEditingController();

  // ignore: missing_return
  Future<List> senddata() async {
    setState(() {
      x = Name.text;
      y = Dormitory.text;
      z = Room.text;
    });

    await http.post("https://test.takedano.com/insertdata.php", body: {
      "Name": x,
      "Dormitory": y,
      "Room": z,
    });


  }

  _setPrefItems1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setString('Name',x);
  }
  _setPrefItems2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setString('Dormitory',y);
  }
  _setPrefItems3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setString('Room', z);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text("お名前",style: TextStyle(fontSize: 18.0),),
                TextField(
                  controller: Name,
                  decoration: InputDecoration(
                      hintText: 'Name'
                  ),
                ),
                Text("寮",style: TextStyle(fontSize: 18.0),),
                TextField(
                  controller: Dormitory,
                  decoration: InputDecoration(
                      hintText: 'Dormitory'
                  ),
                ),
                Text("部屋番",style: TextStyle(fontSize: 18.0),),
                TextField(
                  controller: Room,
                  decoration: InputDecoration(
                      hintText: 'Room'
                  ),
                ),
                RaisedButton(
                  child: Text("登録する"),
                  onPressed: (){
                    _setPrefItems1();
                    _setPrefItems2();
                    _setPrefItems3();
                    senddata();
                    Name.clear();
                    Dormitory.clear();
                    Room.clear();
                    Alert(context: context, title: "登録は完了しました" , desc: "画面下の'next'を押してください").show();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                onPressed: (){
//                  getdata();
                  Navigator.of(context).pushReplacementNamed("/home");
                },
              )
          ));
        },
      ),
    );
  }


  final pages = [
    PageModel.withChild(
      child: Padding(
        child: T(),
        padding: EdgeInsets.only(bottom: 25.0),
      ),
      color: const Color(0xFF0097A7),
      doAnimateChild: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/02.png',
        title: 'Screen 2',
        body: 'See the increase in productivity & output',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/03.png',
        title: 'Screen 3',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Image.asset('assets/02.png', width: 300.0, height: 300.0),
        ),
        color: const Color(0xFF5886d6),
        doAnimateChild: false)
  ];


}


// ---------
// ホーム画面
// ---------

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('点呼システム(仮称) 機能テスト'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<Body> {

  final Strategy strategy = Strategy.P2P_STAR;

  bool second;
  String p;
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


  Future<void> getdata() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      _Name = prefs.getString('Name') ?? "けや";
      _Dormitory = prefs.getString('Dormitory') ?? "にま";
      _Room = prefs.getString('Room') ?? "105";
    });

    final getresponse = await http.post("https://test.takedano.com/getdata.php" , body: {
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
    if(second){
      getdata();
      _setPrefItems();
    }else{
      _getPrefItems1();
    }
  }

  String userName = Random().nextInt(10000).toString();
//  String userName = a;
  void _userNameForm(String e) {
    setState(() {
      userName = e;
    });
  }

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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text("入力フォーム"),
            Wrap(
              children: <Widget>[
                new TextField(
                  decoration:
                  new InputDecoration(labelText: "Enter your userName"),
                  onChanged: _userNameForm,
                ),
              ],
            ), // 入力フォーム
            Divider(),
            Text("ユーザー名:" + userName),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  child: Text("デバイス検知を許可"), // 旧 ホスト
                  onPressed: () async {
                    await Nearby().startAdvertising(
                      userName,
                      strategy,
                      onConnectionResult: (id, status) {},
                      onDisconnected: (id) {},
                      onConnectionInitiated:
                          (String endpointId, ConnectionInfo connectionInfo) {},
                    );
                  },
                ),
                RaisedButton(
                  child: Text("デバイスを探す"), // 旧 クライアント
                  onPressed: () async {
                    await Nearby().startDiscovery(
                      userName,
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
                RaisedButton(
                  child: Text("全機能を停止"),
                  onPressed: () async {
                    await Nearby().stopAllEndpoints();
                    _lostDevices();
//                    _getPrefItems1();
                  },
                ),
              ],
            ),
            Divider(),
            Text(a),
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