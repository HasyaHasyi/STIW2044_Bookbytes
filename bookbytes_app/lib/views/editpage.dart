import 'package:bookbytes_app/shared/myserverconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bookbytes_app/models/user.dart';
import 'dart:convert';
import 'dart:io';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
  final User user;
  const SettingsPage({super.key, required this.user});
}

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.yellow,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.yellow.shade100, Colors.yellow.shade300],
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Account",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Change Name"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      String newname = _nameController.text;
                                    _updateName(newname);
                                    Navigator.of(context).pop();
                                    },
                                    child: Text("Update"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.pink, 
                                      onPrimary: Colors.white, 
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Change Name"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink, 
                          onPrimary: Colors.white, 
                        ),
                      ),
                    
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Change Password"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _oldpasswordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Old Password",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  
                                  TextFormField(
                                    controller: _newpasswordController,
                                    obscureText: true,
                                     decoration: InputDecoration(
                                        hintText: "New Password",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                  ),
                                  ],
        
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Update"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.pink, // Set button color to pink
                                      onPrimary: Colors.white, // Set text color to white
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Change Password"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink, // Set button color to pink
                          onPrimary: Colors.white, // Set text color to white
                        ),
                      ),
                      
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.volume_up_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Notifications",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildNotificationOptionRow("Book Recommendation", true),
                      buildNotificationOptionRow("Community", true),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "SIGN OUT",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.2,
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Set button color to pink
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

            Row buildNotificationOptionRow(String title, bool isActive) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: isActive,
                      onChanged: (bool val) {},
                    ),
                  ),
                ],
              );
            }

        

















            GestureDetector buildAccountOptionRow(BuildContext context, String title) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(title),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "$title",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Update"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink, // Set button color to pink
                              onPrimary: Colors.white, // Set text color to white
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
      
              );
            }          
            
    
    
    
    //UPDATE NEW NAME METHOD
    void _updateName(String newname) {
    http.post(
        Uri.parse("${MyServerConfig.server}/bookbyte/php/updateprofile.php"),
        body: {
          "userid": widget.user.userid,
          "newname": newname,
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.username = newname;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
      print(response.body);
      print(response.statusCode);
    });
  }



  /* ***********************************************************************************
  UPDATE NEW PASSWORD METHOD    
  *************************************************************************************8 */  
  void changePass() {
    http.post(
        Uri.parse("${MyServerConfig.server}/bookbyte/php/updateprofile.php"),
        body: {
          "userid": widget.user.userid,
          "oldpass": _oldpasswordController.text,
          "newpass": _newpasswordController.text,
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });

            }

}