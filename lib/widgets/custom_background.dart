import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  CustomBackground({this.children, this.header, this.image});

  final List<Widget> children;
  final String header;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 137, 202, 204),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Color.fromARGB(255, 137, 202, 254).withOpacity(0.3), BlendMode.dstATop),
                image: AssetImage("assets/images/"+image),
                fit: BoxFit.fill,
              )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Container(
                  alignment: Alignment.center,

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
                            fontSize: MediaQuery.of(context).size.width*0.056,
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
                            margin: const EdgeInsets.all(32),
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
                  ))),
        ));
  }
}
