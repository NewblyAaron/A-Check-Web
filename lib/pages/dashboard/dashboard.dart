import 'package:a_check_web/pages/dashboard/dashboard_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardView extends WidgetView<Dashboard, DashboardState> {
  const DashboardView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
