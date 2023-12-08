import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => StudentLoginPageState();
}

class StudentLoginPageState extends State<StudentLoginPage> {
  @override
  Widget build(BuildContext context) => StudentLoginPageView(this);

  void login() {
    print('pressy');
  }
}

class StudentLoginPageView extends WidgetView<StudentLoginPage, StudentLoginPageState> {
  const StudentLoginPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 500,
                child: Column(
                  children: [
                    Text("Register"),
                    buildForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Form buildForm() {
    return Form(
        child: Column(
      children: [
        // TextFormField(
        //   decoration: InputDecoration(labelText: "School ID"),
        // ),
        TextFormField(
          decoration: InputDecoration(labelText: "Student ID"),
        ),
        MaterialButton(
          onPressed: state.login,
          child: Text("Enter"),
        )
      ],
    ));
  }
}
