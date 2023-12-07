import 'package:flutter/material.dart';

class TableActionsRow extends StatelessWidget {
  const TableActionsRow(
      {super.key,
      required this.onAddButtonPressed,
      required this.onDeleteAllButtonPressed,
      this.addTooltip,
      this.deleteAllTooltip});

  final Function() onAddButtonPressed;
  final Function() onDeleteAllButtonPressed;
  final String? addTooltip, deleteAllTooltip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.person_add,
            color: Color(0xff153faa),
          ),
          splashRadius: 25,
          tooltip: addTooltip,
          onPressed: onAddButtonPressed,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(
            Icons.delete_sweep,
            color: Colors.black54,
          ),
          splashRadius: 25,
          tooltip: deleteAllTooltip,
          onPressed: onDeleteAllButtonPressed,
        ),
      ],
    );
  }
}
