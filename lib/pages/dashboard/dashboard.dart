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
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              shrinkWrap: true,
              children: [
                buildMostAccumulatedStudents(),
                buildMaxAbsentStudents(),
                buildMostAccumulatedClasses(),
                buildMaxAbsentClasses()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildMostAccumulatedStudents() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      color: const Color(0xffffffff),
      shadowColor: const Color(0xffd5d2d2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Most Accumulated Absences",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 400,
              height: 200,
              child: FutureBuilder(
                future: state.getTotalAbsentStudents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!.entries.map((e) {
                        return ListTile(
                          title: Text(e.key.fullName),
                          leading: FutureBuilder(
                            future: e.key.getPhotoUrl(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final url = snapshot.data!;

                                return CircleAvatar(
                                  backgroundColor:const Color(0xff153faa),
                                  foregroundImage: NetworkImage(url),
                                  child: Text(
                                      "${e.key.firstName[0]}${e.key.lastName[0]}", style: TextStyle(fontSize: 12)),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          trailing: Text(e.value.toString()),
                        );
                      }).toList());
                    } else {
                      return const Center(child: Text("None so far!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Card buildMaxAbsentStudents() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      color: const Color(0xffffffff),
      shadowColor: const Color(0xffd5d2d2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Most Maximum Absences",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 400,
              height: 200,
              child: FutureBuilder(
                future: state.getMostMaxAbsentStudents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!.entries.map((e) {
                        return ListTile(
                          title: Text(e.key.fullName),
                          leading: FutureBuilder(
                            future: e.key.getPhotoUrl(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final url = snapshot.data!;

                                return CircleAvatar(
                                  foregroundImage: NetworkImage(url),
                                  child: Text(
                                      "${e.key.firstName[0]}${e.key.lastName[0]}"),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          trailing: Text(e.value.toString()),
                        );
                      }).toList());
                    } else {
                      return const Center(child: Text("None so far!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Card buildMostAccumulatedClasses() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      color: const Color(0xffffffff),
      shadowColor: const Color(0xffd5d2d2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            const Text(
              "Most Accumulated Absences (Classes)",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 400,
              height: 200,
              child: FutureBuilder(
                future: state.getTotalAbsentClasses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!.entries.map((e) {
                        return ListTile(
                          title: Text(e.key.name),
                          leading: CircleAvatar(
                            child: Text(e.key.name.splitMapJoin(
                              ' ',
                              onMatch: (p0) => '',
                              onNonMatch: (p0) => p0.toString()[0],
                            )),
                          ),
                          trailing: Text(e.value.toString()),
                        );
                      }).toList());
                    } else {
                      return const Center(child: Text("None so far!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Card buildMaxAbsentClasses() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      color: const Color(0xffffffff),
      shadowColor: const Color(0xffd5d2d2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            const Text(
              "Most Maximum Absences (Classes)",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 400,
              height: 200,
              child: FutureBuilder(
                future: state.getMostMaxAbsentClasses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!.entries.map((e) {
                        return ListTile(
                          title: Text(e.key.name),
                          leading: CircleAvatar(
                            child: Text(e.key.name.splitMapJoin(
                              ' ',
                              onMatch: (p0) => '',
                              onNonMatch: (p0) => p0.toString()[0],
                            )),
                          ),
                          trailing: Text(e.value.toString()),
                        );
                      }).toList());
                    } else {
                      return const Center(child: Text("None so far!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
