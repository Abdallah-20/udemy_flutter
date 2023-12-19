import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('First App'),
        actions: [
          IconButton(
              onPressed: onclicked,
              icon: Icon(
                Icons.notification_important,
              )),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              print("Search");
            },
          ),
        ],
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Image(
                    image: NetworkImage(
                      'https://wallpaperaccess.com/full/5252278.jpg',
                    ),
                    height: 200,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.black.withOpacity(0.4),
                    width: 200,
                    child: Text(
                      "Jujutsu Kaisen",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.orange[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onclicked() {
    print("button clicked");
  }
}
