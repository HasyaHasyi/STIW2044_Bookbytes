//seller page

import 'package:bookbytes_app/shared/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/user.dart';

class OrderPage extends StatefulWidget {
  final User userdata;
  const OrderPage({super.key, required this.userdata});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
                  "Order Books",
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
          page: 'seller',
          userdata: widget.userdata,
        ),
        body: 
        Container(
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
                    Container(width: 600, height: 400,
                      child: 
                      Image.asset("assets/images/buy_book.png")),
                    Container(
                      child: const Center(child: Text("Come again later!", style: TextStyle(fontSize:19, color: Colors.blue, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                          child: const Center(
                            child: Text(
                              "Many interesting books are coming ...",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ),
                      
                      ),
                LoadingAnimationWidget.prograssiveDots(color: Colors.pink, size: 40),
                ], ),
                ),
          ),
        ),
                );
  }
}