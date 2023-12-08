import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/dashboard/student_dashboard.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => StudentLoginPageState();
}

class StudentLoginPageState extends State<StudentLoginPage> {
  @override
  Widget build(BuildContext context) => StudentLoginPageView(this);

  TextEditingController idCon = TextEditingController();
  School? selectedSchool;

  void login() {
    if (selectedSchool == null) {
      snackbarKey.currentState!
          .showSnackBar(const SnackBar(content: Text("Select a school!")));
      return;
    }

    selectedSchool?.ref.students.doc(idCon.text).get().then((value) {
      if (!value.exists) {
        snackbarKey.currentState!
            .showSnackBar(const SnackBar(content: Text("Invalid student ID!")));
        return;
      }

      final student = value.data!;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                StudentDashboard(school: selectedSchool!, student: student),
          ));
    });
  }

  Future<List<School>> getSearchedItems(String text) async {
    final schools = (await schoolsRef.get()).docs.map((e) => e.data).toList();

    return schools.where((e) => e.name.contains(text)).toList();
  }

  void onDropdownChanged(School? value) {
    setState(() => selectedSchool = value);
  }
}

class StudentLoginPageView
    extends WidgetView<StudentLoginPage, StudentLoginPageState> {
  const StudentLoginPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    Text("Student Login"),
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
        DropdownSearch<School>(
          popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(labelText: "School"))),
          asyncItems: state.getSearchedItems,
          itemAsString: (item) => item.name,
          compareFn: (item1, item2) => item1.id == item2.id,
          onChanged: state.onDropdownChanged,
          selectedItem: state.selectedSchool,
        ),
        TextFormField(
          controller: state.idCon,
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
