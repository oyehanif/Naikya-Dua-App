import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

import '../../hive/dua_hive.dart';


class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});


  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int counter = 0000000;
  double x1 = 20.0, y1 = 150.0, x1Prev = 100.0, y1Prev = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    counter = DuaHive.getCount() ;
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DuaHive.saveCount(counter);
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(title: const Text('Tasbhi'),centerTitle: true,backgroundColor:  CupertinoColors.inactiveGray,),
      body:
      Container(
        color: CupertinoColors.inactiveGray,
        child: Stack(

          children: [
          Positioned(
          left: x1,
          top: y1,
          child: GestureDetector(
            onPanDown:(d){
              x1Prev = x1;
              y1Prev = y1;
            },
            onPanUpdate: (details) {
              setState(() {
                x1 = x1Prev + details.localPosition.dx;
                y1 = y1Prev + details.localPosition.dy;
              });
            },
            child:
            Center(
              child: Container(
                height: 200,
                width: mediaQuery.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:Column(
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color:Colors.black,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.fromLTRB(20,20,20,0),
                        alignment: Alignment.centerRight,
                        child:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SevenSegmentDisplay(
                            value: counter.toString(),
                            size: 4,
                            backgroundColor: Colors.transparent,
                            // segmentStyle: HexSegmentStyle(
                            //   enabledColor: const Color(0xFF00FF00),
                            //   disabledColor: const Color(0xFF00FF00).withOpacity(0.15),
                            //   segmentBaseSize: const Size(1.0, 2.0),
                            // ),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(children: [
                            RawMaterialButton(
                              onPressed: () {
                                if(counter != 0) {
                                  setState(() {
                                    counter = counter - 1;
                                  });
                                }
                              },
                              elevation: 2.0,
                              fillColor: Colors.white,
                              // padding: EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.horizontal_rule,
                                size: 12.0,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  counter = 000000;
                                });
                              },
                              elevation: 2.0,
                              fillColor: Colors.white,
                              // padding: EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.refresh,
                                size: 12.0,
                              ),
                            ),
                          ],),
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                counter = counter + 1;
                              });
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.add,
                              size: 35.0,
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ),
          ),
        ),


        ]
            ),
      ));
  }
}
