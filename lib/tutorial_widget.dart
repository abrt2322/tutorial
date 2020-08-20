import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

String x, y, z;

class T extends StatefulWidget {
  @override
  _T createState() => _T();
}

class _T extends State<T> {
  // ignore: non_constant_identifier_names
  TextEditingController Name = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Dormitory = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Room = new TextEditingController();

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
    await prefs.setString('Name', x);
  }

  _setPrefItems2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    await prefs.setString('Dormitory', y);
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
                Text(
                  "お名前",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: Name,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                Text(
                  "寮",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: Dormitory,
                  decoration: InputDecoration(hintText: 'Dormitory'),
                ),
                Text(
                  "部屋番",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: Room,
                  decoration: InputDecoration(hintText: 'Room'),
                ),
                RaisedButton(
                  child: Text("登録する"),
                  onPressed: () {
                    _setPrefItems1();
                    _setPrefItems2();
                    _setPrefItems3();
                    senddata();
                    Name.clear();
                    Dormitory.clear();
                    Room.clear();
                    Alert(
                            context: context,
                            title: "登録は完了しました",
                            desc: "画面下の'next'を押してください")
                        .show();
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
