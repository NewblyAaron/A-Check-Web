import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key, required this.teacher}) : super(key: key);

  final Teacher teacher;

  @override
  State<TeacherProfile> createState() => TeacherState();
}

class TeacherView extends WidgetView<TeacherProfile, TeacherState> {
  const TeacherView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(widget.teacher),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                buildTeacherInfo(widget.teacher),
                const SizedBox(height: 24),
                buildEnrolledClasses(),
              ],
            )),
      ],
    );
  }

  Widget buildHeader(Teacher teacher) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTeacherPhoto(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        teacher.fullName.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        teacher.id,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildTeacherPhoto() {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomRight,
        fit: StackFit.loose,
        children: [
          Container(
            height: 112,
            width: 112,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xffD7E5CA), Color(0xffF9F3CC)]),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              border: Border.fromBorderSide(BorderSide()),
            ),
            // TODO: display image of teacher from firebase
            child: const Placeholder(),
            // child: state.teacher.facePhotoBytes != null
            //     ? Image.memory(state.teacher.facePhotoBytes!)
            //     : const Icon(Icons.person_add_alt),
          ),
          Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 1)]),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
              )),
        ],
      ),
    );
  }

  Widget buildTeacherInfo(Teacher teacher) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Teacher Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(teacher.email!),
              leading: const Icon(Icons.email),
            ),
            ListTile(
              title: Text(teacher.phoneNumber!),
              leading: const Icon(Icons.phone),
            ),
          ],
        )
      ],
    );
  }

  Widget buildEnrolledClasses() {
    return StreamBuilder(
        stream: state.getEnrolledClasses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final classes = snapshot.data!.docs.map((e) => e.data).toList();

          if (classes.isEmpty) {
            return const Text("No handled classes!");
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Handled Classes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(snapshot.hasData
                        ? "${snapshot.data!.docs.length}"
                        : "..."),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: classes
                      .map((e) => Card(
                            child: ListTile(
                              title: Text(e.name),
                              subtitle: Text(e.section),
                            ),
                          ))
                      .toList(),
                ),
              ]);
        });
  }
}
