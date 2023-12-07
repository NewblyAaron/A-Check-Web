import 'package:flutter/material.dart';

class CellActions extends StatelessWidget {
  const CellActions(
      {super.key,
      required this.data,
      required this.onViewButtonPressed,
      required this.onEditButtonPressed,
      this.viewTooltip,
      this.editTooltip});

  final dynamic data;
  final String? viewTooltip;
  final String? editTooltip;
  final Function(dynamic o)? onViewButtonPressed;
  final Function(dynamic o)? onEditButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          tooltip: viewTooltip,
          splashRadius: 15,
          onPressed: () {
            if (onViewButtonPressed is Function) {
              onViewButtonPressed!(data);
            }
          },
          icon: const Icon(Icons.visibility_outlined, color: Color(0xff153faa)),
        ),
        IconButton(
          tooltip: editTooltip,
          splashRadius: 15,
          onPressed: () {
            if (onEditButtonPressed is Function) {
              onEditButtonPressed!(data);
            }
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
