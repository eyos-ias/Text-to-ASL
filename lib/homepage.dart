import 'package:first/Start.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            width: 200.0,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'images/Icon1.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Commusign',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Language at Your Fingertips',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(248, 18, 202, 156)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondStart()),
                  );
                },
                child: Text(
                  'Explore',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
