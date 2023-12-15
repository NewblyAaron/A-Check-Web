import 'package:flutter/material.dart';

class TableActionsRow extends StatelessWidget {
  const TableActionsRow(
      {super.key,
      this.onAddButtonPressed,
      this.onDeleteAllButtonPressed,
      this.onImportButtonPressed,
      this.addTooltip,
      this.deleteAllTooltip,
      this.importTooltip});

  final Function()? onAddButtonPressed, onDeleteAllButtonPressed, onImportButtonPressed;
  final String? addTooltip, deleteAllTooltip, importTooltip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onAddButtonPressed is Function) IconButton(
          icon: const Icon(
            Icons.add,
            color: Color(0xff153faa),
          ),
          splashRadius: 25,
          tooltip: addTooltip,
          onPressed: onAddButtonPressed,
        ),
        const SizedBox(
          width: 10,
        ),
        if (onDeleteAllButtonPressed is Function) IconButton(
          icon: const Icon(
            Icons.delete_sweep,
            color: Colors.black54,
          ),
          splashRadius: 25,
          tooltip: deleteAllTooltip,
          onPressed: onDeleteAllButtonPressed,
        ),
        const SizedBox(
          width: 10,
        ),
        if (onImportButtonPressed is Function) IconButton(
          icon: const Icon(
            Icons.upload_rounded,
            color: Colors.black54,
          ),
          splashRadius: 25,
          tooltip: importTooltip,
          onPressed: onImportButtonPressed,
        ),
      ],
    );
  }
}
