import 'package:flutter/material.dart';

class CellActions extends StatelessWidget {
  const CellActions(
      {super.key,
      required this.data,
      this.onViewButtonPressed,
      this.onEditButtonPressed,
      this.viewTooltip,
      this.editTooltip});

  final dynamic data;
  final String? viewTooltip;
  final String? editTooltip;
  final Function(dynamic e)? onViewButtonPressed;
  final Function(dynamic e)? onEditButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (onViewButtonPressed is Function)
          IconButton(
            tooltip: viewTooltip,
            splashRadius: 15,
            onPressed: () {
              onViewButtonPressed!(data);
            },
            icon:
                const Icon(Icons.visibility_outlined, color: Color(0xff153faa)),
          ),
        if (onEditButtonPressed is Function)
          IconButton(
            tooltip: editTooltip,
            splashRadius: 15,
            onPressed: () {
              onEditButtonPressed!(data);
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black45,
            ),
          ),
      ],
    );
  }
}
