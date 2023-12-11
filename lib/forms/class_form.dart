import 'package:a_check_web/forms/class_form_con.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:a_check_web/widgets/schedule_row.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ClassForm extends StatefulWidget {
  const ClassForm({super.key, this.schoolClass});

  final SchoolClass? schoolClass;

  @override
  State<ClassForm> createState() => ClassFormState();
}

class ClassFormView extends WidgetView<ClassForm, ClassFormState> {
  const ClassFormView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          buildClassInfo(),
          buildTeacherDropdown(),
          buildScheduleList(),
          const Spacer(flex: 1),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildScheduleList() {
    return Column(
      children: [
        SizedBox(
          width: 600,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Schedule",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                TextButton(
                  onPressed: state.addSchedule,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Add Schedule',
                    style: TextStyle(color: Color(0xff153faa)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 545,
          child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: state.schedules
                  .map((e) => ScheduleRow(
                        schedule: e,
                        index: state.schedules.indexOf(e),
                        onEdit: state.editSchedule,
                        onDelete: state.deleteSchedule,
                      ))
                  .toList()),
        )
      ],
    );
  }

  Widget buildClassInfo() {
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Text("Add Class",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xff000000),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 600,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: state.codeCon,
                enabled: widget.schoolClass == null,
                validator: Validators.hasValue,
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
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.class_rounded,color:Colors.black54, size: 20,),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'e.g. MTH101',
                    labelText: "Class Code"),
              ),
            ),
          ),
          SizedBox(
            width: 600,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: state.nameCon,
                validator: Validators.hasValue,
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
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.label_important_rounded,color:Colors.black54, size: 20,),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'e.g. Mathematics in the Modern World',
                    labelText: "Class Name"),
              ),
            ),
          ),
          SizedBox(
            width: 600,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: state.sectionCon,
                enabled: widget.schoolClass == null,
                validator: Validators.hasValue,
                obscureText: false,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.black54,
                ),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.label_important_rounded,color:Colors.black54, size: 20,),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'e.g. ZT21',
                    labelText: "Class Section"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTeacherDropdown() {
    return SizedBox(
      width: 600,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownSearch<Teacher>(
          popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      labelText: "Teacher ID", hintText: "e.g. 123")),
              isFilterOnline: true),
          dropdownDecoratorProps: const DropDownDecoratorProps(
              baseStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Colors.black54,
              ),
              dropdownSearchDecoration: InputDecoration(
                  prefixIcon: Icon(Icons.face,color:Colors.black54, size: 20,),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  labelText: "Teacher ID",
                  hintText: "Select a teacher")),
          asyncItems: state.getSearchedItems,
          itemAsString: (item) => "${item.fullName} (${item.id})",
          compareFn: (item1, item2) => item1.id == item2.id,
          onChanged: state.onDropdownChanged,
          selectedItem: state.selectedTeacher,
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      children: [
        Material(
          color: Colors.grey.shade100,
          child: InkWell(
            hoverColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.4),
            splashColor: Colors.grey.withOpacity(0.5),
            onTap: state.cancel,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Material(
          color: const Color(0xff153faa).withOpacity(0.6),
          child: InkWell(
            hoverColor: const Color(0xff153faa).withOpacity(0.8),
            highlightColor: const Color(0xff153faa).withOpacity(0.4),
            splashColor: const Color(0xff153faa).withOpacity(1),
            onTap: state.finalize,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
