import 'package:a_check_web/main.dart';
import 'package:a_check_web/student/students_page.dart';
import 'package:flutter/material.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Add Student",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 50,
                    color: Color(0xff000000),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "Student ID"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "First Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "Middle Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "Last Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "Mobile Number"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainApp()),
                  );
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
