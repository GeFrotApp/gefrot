import "package:flutter/material.dart";

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
              ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Container(
                  alignment: Alignment.center,

                  child: Column(
                    children: <Widget>[

                      Expanded(
                        child: SingleChildScrollView(
                          child:
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(alignment: Alignment.centerLeft,child: Image.asset("assets/images/logo.png", height:MediaQuery.of(context).size.width*0.1,),),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.075),
                                    child: Text(header != null ? header : "", textAlign: TextAlign.center, style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width*0.056,
                                      color: Colors.white,
                                    ),
                                    ),)
                                ],
                              ),
                              Container(
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
                            ],
                          ),


                        ),
                      )
                    ],
                  ))),
        ));
  }
}
