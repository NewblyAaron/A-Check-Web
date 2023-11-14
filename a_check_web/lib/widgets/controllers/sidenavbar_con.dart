import 'package:a_check_web/widgets/sidenavbar.dart';
import 'package:flutter/material.dart';

class SideNavBarState extends State<SideNavBar> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() => selectedIndex = index);
    widget.onIndexChange(index);
  }

  @override
  Widget build(BuildContext context) => SideNavBarView(this);
}
