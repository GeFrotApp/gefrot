import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  CustomBackground({this.children, this.header});

  final List<Widget> children;
  final String header;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

            body: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/caminhão.jpg"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          " |",
                          style: TextStyle(fontSize: 33, color: Colors.white),
                        ),
                        Text(
                          "GeFrot",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "| ",
                          style: TextStyle(fontSize: 33, color: Colors.white),
                        ),
                        Text(header != null ? header : "", style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
),)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(16),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children,
                                ),
                              )),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
