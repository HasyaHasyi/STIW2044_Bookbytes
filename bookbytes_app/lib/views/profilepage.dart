//Profile page

import 'package:bookbytes_app/shared/mydrawer.dart';
import 'package:bookbytes_app/views/loginpage.dart';
import 'package:bookbytes_app/views/registrationpage.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  final User userdata;
  const ProfilePage({super.key, required this.userdata});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
            backgroundColor: Colors.yellow,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
            )),


        drawer: MyDrawer(
          page: 'account',
          userdata: widget.userdata,
        ),



        body: 
        Container(decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.yellow.shade100, Colors.yellow.shade300],
    ),),
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.0),
              Container(
                child: Center(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/profile_pic.png'),
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
        
              SizedBox(height: 60.0),
              Row(
                children: [
                  SizedBox(width: 28,),
                  Container(
                    child: 
                  Text('PROFILE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),),
                ],
              ),
        
        
        
        
              
              SizedBox(height: 17.0),
              Row(
                children: [
                  SizedBox(width: 30.0),
                  Icon(Icons.email, color: Colors.pink,),
                  SizedBox(width: 16.0),
                  Text('Email: ${widget.userdata.useremail}'),
                ],
              ),
              SizedBox(height: 8.0),
              
              Row(
                children: [
                  SizedBox(width: 30.0),
                  Icon(Icons.person, color: Colors.pink,),
                  SizedBox(width: 16.0),
                  Text('Name: ${widget.userdata.username}'),
                ],
              ),
              SizedBox(height: 8.0),
        
              Row(
                children: [
                  SizedBox(width: 30.0),
                  Icon(Icons.password, color: Colors.pink,),
                  SizedBox(width: 16.0),
                  Text('Password: ${widget.userdata.username}'),
                ],
              ),
              
              SizedBox(height: 30.0),
              Row(
                children: [
                  SizedBox(width: 28,),
                  Container(
                    child: 
                  Text('REGISTRATION DETAILS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),),
                ],
              ),
        
              SizedBox(height: 17.0),
              Row(
                children: [
                  SizedBox(width: 30.0),
                  Icon(Icons.date_range, color: Colors.pink,),
                  SizedBox(width: 16.0),
                  Text('Date: ${widget.userdata.userdatereg}'),
                ],
              ),
              SizedBox(height: 8.0),
        
              SizedBox(height: 17.0),
              Row(
                children: [
                  SizedBox(width: 30.0),
                  Icon(Icons.payment, color: Colors.pink,),
                  SizedBox(width: 16.0),
                  Text('ID: ${widget.userdata.userid}'),
                ],
              ),
              SizedBox(height: 10.0),
        
        
        
        
        
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => const LoginPage()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow, // Button color
                      ),
                    ),
        
                    SizedBox(width: 50.0),
        
                    ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => const RegistrationPage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow, // Button color
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
        
              Container(
                child: Text('Old pal? Hit login. \nNewcomer? Sign up and let’s make it official!', style: TextStyle(fontSize: 11.5, color: Colors.pink, ), textAlign: TextAlign.center,)
                ,
              ),
              
              
            ],
          ),
              ),
        ),
    );













  }

  }