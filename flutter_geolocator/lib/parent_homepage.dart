import 'package:flutter_geolocator_example/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUI2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Parent Basic Info:'),
          centerTitle: false,
          backgroundColor: Colors.purple[300],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Container(
                  width: double.infinity,
                  height: 270,
                  child: Container(
                    alignment: Alignment(0.0, 2.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/parent.jpg'),
                      radius: 90.0,
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Text(
                "JANE DOE",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rajasthan, India",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  elevation: 2.0,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      child: Text(
                        "PARENT OF JOHN DOE",
                        style: TextStyle(
                            letterSpacing: 2.0, fontWeight: FontWeight.w300),
                      ))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Text("Get Live Status")),
            ],
          ),
        ));
  }
}
