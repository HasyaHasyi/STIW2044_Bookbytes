import 'dart:convert';
import 'package:bookbytes_app/models/user.dart';
import 'package:bookbytes_app/shared/myserverconfig.dart';
import 'package:bookbytes_app/views/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookDetails extends StatefulWidget {
  final User user;
  final Book book;

  const BookDetails({Key? key, required this.user, required this.book}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late double screenWidth, screenHeight;
  bool bookowner = false;

  @override
  Widget build(BuildContext context) {
    if (widget.user.userid == widget.book.userId) {
      bookowner = true;
    } else {
      bookowner = false;
    }
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.bookTitle!),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                enabled: bookowner,
                child: const Text("Update"),
              ),
              PopupMenuItem<int>(
                enabled: bookowner,
                value: 1,
                child: const Text("Delete"),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                if (widget.book.userId == widget.user.userid) {
                  // Implement update logic
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Not allowed!!!"),
                    backgroundColor: Colors.red,
                  ));
                }
              } else if (value == 1) {
                if (widget.book.userId == widget.user.userid) {
                  // Implement delete logic
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Not allowed!!!"),
                    backgroundColor: Colors.red,
                  ));
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth,
              child: Image.network(
                "${MyServerConfig.server}/bookbyte/assets/books/${widget.book.bookId}.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              height: screenHeight * 0.6,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.book.bookTitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    widget.book.bookAuthor!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("ISBN ${widget.book.bookIsbn}"),
                  const SizedBox(height: 8),
                  Text(
                    widget.book.bookDesc ?? '',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "RM ${widget.book.bookPrice}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Quantity Available ${widget.book.bookQty}"),
                  ElevatedButton(
                    onPressed: () {
                     
                      if (widget.user.useremail == 'unregistered@email.com') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (content) => LoginPage(),
                          ),
                        );
                      } else {
                        // Add to cart function
                        if (int.parse(widget.book.bookQty ?? '0') > 0) {
                          insertCartDialog();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Out of stock"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: const Text(
            "Insert to cart?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                insertCart();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void insertCart() {
  print("buyer_id: ${widget.user.userid.toString()}");
  print("seller_id: ${widget.book.sellerId.toString()}");
  print("book_id: ${widget.book.bookId.toString()}");
  print("cart_qty: 1");
  print("book_price: ${widget.book.bookPrice.toString()}");
    http.post(
      Uri.parse("${MyServerConfig.server}/bookbyte/php/insertcarts.php"),
      body: {
        "buyer_id": "1",
        "seller_id": widget.book.sellerId.toString(),
        "book_id": widget.book.bookId.toString(),
        "book_price": widget.book.bookPrice.toString(),
      },
    ).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Success"),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
