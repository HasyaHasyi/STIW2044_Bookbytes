import 'dart:async';
import 'dart:convert';
import 'package:bookbytes_app/shared/myserverconfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'mainpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    User user = User(
        userid: "0",
        useremail: "unregistered@email.com",
        username: "unregistered",
        userdatereg: "",
        userpassword: "");
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => MainPage(
                      userdata: user,
                    ))));
    checkandlogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
          child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,90,10,0),
              child: Center(child: Image.asset("assets/images/logo.png")),
            ),
            Text(
              "BookBytes",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
            Text(
              "Solution to Knowledge",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.pink),
            ),
            LoadingAnimationWidget.newtonCradle(color: Colors.pink, size: 200),
            Text("Version 0.1")
          ],
        ),
      )),
    );
  }

  checkandlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    bool rem = (prefs.getBool('rem')) ?? false;
    if (rem) {
      http.post(
          Uri.parse("${MyServerConfig.server}/bookbytes/php/login_user.php"),
          body: {"email": email, "password": password}).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == "success") {
            User user = User.fromJson(data['data']);
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainPage(
                              userdata: user,
                            ))));
          } else {
            User user = User(
                userid: "0",
                useremail: "unregistered@email.com",
                username: "Unregistered",
                userdatereg: "",
                userpassword: "");
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainPage(
                              userdata: user,
                            ))));
          }
        }
      });
    } else {
      User user = User(
          userid: "0",
          useremail: "unregistered@email.com",
          username: "Unregistered",
          userdatereg: "",
          userpassword: "");
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainPage(
                        userdata: user,
                      ))));
    }
  }
}
