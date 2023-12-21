//Buyer page

import 'dart:convert';
import 'package:bookbytes_app/models/book.dart';
import 'package:bookbytes_app/models/user.dart';
import 'package:bookbytes_app/shared/mydrawer.dart';
import 'package:bookbytes_app/shared/myserverconfig.dart';
import 'package:bookbytes_app/views/bookDetails.dart';
import 'package:bookbytes_app/views/newbookpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class MainPage extends StatefulWidget {
  final User userdata;
  const MainPage({super.key, required this.userdata});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Book> bookList = <Book>[];
  var title = " ";
  var numofpage = 1;
  var curpage = 1;
  var numofresult = 0;
  late double screenWidth, screenHeight;

  TextEditingController searchControl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    loadBooks(title);
  }

  int axiscount = 2;

  @override
  Widget build(BuildContext context) {
    
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar( 
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //CircleAvatar(backgroundImage: AssetImage('')),
              Center(
                child: Text(
                  "BookBytes",
                  style: TextStyle(
                    color: Colors.black,
                  ),
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
        page: "books",
        userdata: widget.userdata,
      ),
      body: bookList.isEmpty
          ? 
          LiquidPullToRefresh(
            onRefresh: () async {
              loadBooks(title);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.yellow.shade100, Colors.yellow.shade300],
                ),),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,10,5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/welcome.png"),
                      Container(
                        child: const Center(child: Text("Hi, Welcome!", style: TextStyle(fontSize:19, color: Colors.blue, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Container(
                            child: const Center(
                              child: Text(
                                "Unfortunately, this page is under development. Stay tuned!",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        LoadingAnimationWidget.prograssiveDots(color: Colors.pink, size: 45),
                    ],
                  ),
                ),
              ),
            ),
          ) 


          : Column(
              children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchControl,
              onChanged: (text) {
                title = text;
                loadBooks(title);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: axiscount,
                      childAspectRatio: 0.8, // Adjust this value to make the card more square-shaped
                      children: List.generate(bookList.length, (index) {
                        return InkWell(
                              onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookDetails(user: widget.userdata, book: bookList[index])),
                              );
                            },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: Container(
                                    width: screenWidth,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.network(
                                      fit: BoxFit.fill,
                                      "${MyServerConfig.server}/bookbyte/assets/books/${bookList[index].bookId}.png",
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        truncateString(bookList[index].bookTitle.toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text("RM ${bookList[index].bookPrice}"),
                                      Text("Available ${bookList[index].bookQty} unit"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (curpage > 1) {
                            curpage--;
                            loadBooks(title);
                          }
                        },
                        child: const Text("Prev"),
                      ),
                    ),
                    Text(curpage.toString() +
                        "/" +
                        numofpage.toString() +
                        " pages"),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (curpage < numofpage) {
                            curpage++;
                            loadBooks(title);
                          }
                        },
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  // void newBook() {
  //   if (widget.userdata.userid.toString() == "0") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Please register an account"),
  //       backgroundColor: Colors.red,
  //     ));
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (content) => NewBookPage(
  //                   userdata: widget.userdata,
  //                 )));
  //   }
  // }

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return str + "...";
    } else {
      return str;
    }
  }

  

   void loadBooks(String title) {
    http.get(Uri.parse(
          "${MyServerConfig.server}/bookbyte/php/load_books.php?title=$title&pageno=$curpage"),)
        .then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          bookList.clear();
          data['data']['books'].forEach((v) {
            bookList.add(Book.fromJson(v));
          });
          numofpage = int.parse(data['numofpage'].toString());
          numofresult = int.parse(data['numberofresult'].toString());
        } else {
          //if no status failed
        }
      }
      setState(() {});
    });
  }
}