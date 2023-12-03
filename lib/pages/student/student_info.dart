import 'package:a_check_web/model/person.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key, required this.student});

  final Student student;

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
                student.fullName,
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
                student.email.toString(),
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
                student.phoneNumber.toString(),
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
          ],
        ),
      ),
    );
  }
}
