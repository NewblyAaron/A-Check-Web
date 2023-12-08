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
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: 350,
            height: 500,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 450,
                        height: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 35, bottom: 30),
                              child:
                              Image(
                                  image: AssetImage("assets/images/small_logo_blue.png"),
                                  height: 100),
                            ),
                            const Text("Log in as a Student", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
                            const SizedBox(height: 25,),
                            buildForm(),
                            const SizedBox(height: 25,),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                        child: Divider()
                                    ),
                                    Text("     or     "),
                                    Expanded(
                                        child: Divider()
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25,),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // hoverColor: const Color(0xff153faa).withOpacity(0.8),
                                  // highlightColor: const Color(0xff153faa).withOpacity(0.4),
                                  // splashColor: const Color(0xff153faa).withOpacity(1),
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                        color: const Color(0xff153faa),
                                        width: 1,
                                      ),
                                      // adding color will hide the splash effect
                                      color: Colors.transparent,
                                    ),
                                    child: const Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.keyboard_backspace_rounded, color: Color(0xff153faa),size: 23,),
                                        SizedBox(width: 9,),
                                        Text(
                                          "Back to Login",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff153faa)),
                                        ),
                                      ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropDownSchool(BuildContext context, item) {
    return Container(
        child: (item == null)
            ? const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Row(
                  children: [
                    Icon(Icons.search_rounded, color: Color(0xff153faa),size: 23,),
                    SizedBox(width: 9,),
                    Text("Find your school",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff828282)
                        )
                    ),
                  ],
                ),
              )
            : ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              item.title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13.5, color: Colors.black),
            )
        )
    );
  }
  Form buildForm() {
    return Form(
        child: Column(
          children: [
            DropdownSearch<School>(
              dropdownBuilder: _customDropDownSchool,
              popupProps: const PopupProps.menu(
                  title: Text("Search school", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                  showSearchBox: true,
                  showSelectedItems: true,
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          // labelText: "School",
                      )
                  )
              ),
              asyncItems: state.getSearchedItems,
              itemAsString: (item) => item.name,
              compareFn: (item1, item2) => item1.id == item2.id,
              onChanged: state.onDropdownChanged,
              selectedItem: state.selectedSchool,
            ),
            const SizedBox(height:12),
            TextFormField(
              controller: state.idCon,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_circle_rounded,color:Colors.black54, size: 20,),
                  labelText: "Enter Student ID Number"
              ),
            ),
            const SizedBox(height:12),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: state.login,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  // adding color will hide the splash effect
                  color: const Color(0xff153faa),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ],
    ));
  }
}
