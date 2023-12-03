import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  const ListRow({super.key, required this.object});

  final Object object;

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subtitle = "";

    if (object is Person) {
      title = (object as Person).fullName;

      if (object is Student) {
        subtitle = (object as Student).id;
      } else if (object is Teacher) {
        subtitle = (object as Teacher).email!;
      } else if (object is Guardian) {
        subtitle = "Guardian of a student lol";
      }
    }

    if (object is SchoolClass) {
      title = (object as SchoolClass).name;
      subtitle = "${(object as SchoolClass).subjectCode} ${(object as SchoolClass).section}";
    }

    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.account_circle_rounded,
          size: 40,
        ),
        dense: false,
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        selectedTileColor: Colors.blue.shade100,
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                hoverColor: Colors.green.withOpacity(0.3),
                icon: const Icon(Icons.edit_note_rounded, size: 30),
                tooltip: 'Edit',
                onPressed: () {},
              ),
              const SizedBox(width: 40),
              IconButton(
                highlightColor: Colors.red.withOpacity(0.3),
                icon: const Icon(Icons.delete_outline, size: 30),
                tooltip: 'Delete',
                onPressed: () {},
              ),
            ]),
      ),
    );
  }
}
