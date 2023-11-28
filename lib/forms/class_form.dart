import 'package:a_check_web/forms/class_form_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/schedule_row.dart';
import 'package:flutter/material.dart';

class ClassForm extends StatefulWidget {
  const ClassForm({super.key});

  @override
  State<ClassForm> createState() => ClassFormState();
}

class ClassFormView extends WidgetView<ClassForm, ClassFormState> {
  const ClassFormView(super.state, {super.key});

  Widget buildScheduleList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Schedule",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextButton(
              onPressed: state.addSchedule,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Add Schedule',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        ListView(
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
                .toList())
      ],
    );
  }

  Widget buildClassInfo() {
    return Form(
      key: state.formKey,
      child: Column(
        children: [
          const Text("Add Class",
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
              //controller: state.idCon,
              //validator: Validators.hasValue,
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
              decoration: const InputDecoration(labelText: "Code"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              // controller: state.fNameCon,
              // validator: Validators.hasValue,
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
              decoration: const InputDecoration(labelText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              // controller: state.mNameCon,
              // validator: Validators.hasValue,
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
              decoration: const InputDecoration(labelText: "Section"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            buildClassInfo(),
            buildScheduleList(),
            ElevatedButton(
              onPressed: () {}, //state.finalize,
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
