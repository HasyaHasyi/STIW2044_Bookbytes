import 'package:flutter/material.dart';

import '../models/user.dart';
import '../shared/mydrawer.dart';

class CommunityPage extends StatefulWidget {
  final User userdata;

  const CommunityPage({super.key, required this.userdata});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( 
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //CircleAvatar(backgroundImage: AssetImage('')),
                Text(
                  "Comunity Page",
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
          page: "community",
          userdata: widget.userdata,
        ),
        body: Container(
          decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.yellow.shade100, Colors.yellow.shade300],
    ),),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Center(child: Text("Looking For Fun Books Community?", style: TextStyle(fontSize:19, color: Colors.blue, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                      ),
                    ),
                    Container(width: 600, height: 400,
                      child: Image.asset("assets/images/community.png")),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                          child: const Center(
                            child: Text(
                              "Coming Soon to You!",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ),
                      
                      ),
                ], ),
                ),
          ),
        ),
                );
        
        
  }
}