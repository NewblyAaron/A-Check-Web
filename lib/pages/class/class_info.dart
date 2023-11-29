import 'package:a_check_web/model/school_class.dart';
import 'package:flutter/material.dart';

class ClassInfo extends StatelessWidget {
  const ClassInfo({super.key, required this.schoolClass});

  final SchoolClass schoolClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisSize:MainAxisSize.max,
          children: [
            Padding(
              padding:const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child:Container(
                height:80,
                width:80,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child:Image.network(
                    "https://cdn.pixabay.com/photo/2020/09/21/13/38/woman-5590119_960_720.jpg",
                    fit:BoxFit.cover),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child:Text(
                teacher.fullName,
                textAlign: TextAlign.start,
                overflow:TextOverflow.clip,
                style:const TextStyle(
                  fontWeight:FontWeight.w700,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child:
              Text(
                teacher.email.toString(),
                textAlign: TextAlign.start,
                overflow:TextOverflow.clip,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:12,
                  color:Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child:Text(
                teacher.phoneNumber.toString(),
                textAlign: TextAlign.start,
                overflow:TextOverflow.clip,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.italic,
                  fontSize:12,
                  color:Color(0xff7c7c7c),
                ),
              ),
            ),
            const Padding(
              padding:EdgeInsets.fromLTRB(0, 30, 0, 0),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisSize:MainAxisSize.max,
                children:[
                  Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisSize:MainAxisSize.max,
                    children: [
                      Text(
                        "Classes",
                        textAlign: TextAlign.start,
                        overflow:TextOverflow.clip,
                        style:TextStyle(
                          fontWeight:FontWeight.w400,
                          fontStyle:FontStyle.normal,
                          fontSize:12,
                          color:Color(0xff808080),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child:Text(
                          "3",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style:TextStyle(
                            fontWeight:FontWeight.w700,
                            fontStyle:FontStyle.normal,
                            fontSize:20,
                            color:Color(0xff3a57e8),
                          ),
                        ),
                      ),
                    ],),

                  Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisSize:MainAxisSize.max,
                    children: [
                      Text(
                        "Students",
                        textAlign: TextAlign.start,
                        overflow:TextOverflow.clip,
                        style:TextStyle(
                          fontWeight:FontWeight.w400,
                          fontStyle:FontStyle.normal,
                          fontSize:12,
                          color:Color(0xff808080),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child:Text(
                          "26",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style:TextStyle(
                            fontWeight:FontWeight.w700,
                            fontStyle:FontStyle.normal,
                            fontSize:20,
                            color:Color(0xff3a57e8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
