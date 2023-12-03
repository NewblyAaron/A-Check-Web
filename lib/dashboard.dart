import 'package:flutter/material.dart';
import 'package:dynamic_table/dynamic_table.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40, top:60, bottom: 40),
              child: Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        "De La Cruz, John",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Ateneo De Naga University",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_drop_down, size: 25),
                    tooltip: 'Profile',
                    onPressed: null,
                  ),
                ]),
          ],
        ),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: DynamicTable(
              header: const Text("Student Table"),
              rowsPerPage: 10,
              showFirstLastButtons: false,
              availableRowsPerPage: const [
                10,
                15,
                20,
              ],// rowsPerPage should be in availableRowsPerPage
              columnSpacing: 30,
              showCheckboxColumn: false,
              onRowsPerPageChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Rows Per Page Changed to $value"),
                  ),
                );
              },
              rows: [DynamicTableDataRow(
                index: 0,
                onSelectChanged: (value) {
                },
                cells:[
                  DynamicTableDataCell(value: "202010824"),
                  DynamicTableDataCell(value: "Samantha Mae De Las Nieves"),
                  DynamicTableDataCell(value: "yes"),
                  DynamicTableDataCell(value: "Male"),
                  DynamicTableDataCell(value:"5"),
                ],
              ),
              ],
              columns: [
                DynamicTableDataColumn(
                    label: const Text("Student ID"),
                    onSort: (columnIndex, ascending) {},
                    dynamicTableInputType: DynamicTableTextInput()),
                // dynamicTableInputType: DynamicTableInputType.text()),
                DynamicTableDataColumn(
                    label: const Text("Student Name"),
                    onSort: (columnIndex, ascending) {},
                    isEditable: false,
                    dynamicTableInputType: DynamicTableTextInput()),
                // dynamicTableInputType: DynamicTableInputType.text()),
                DynamicTableDataColumn(
                  label: const Text("Email Address"),
                  onSort: (columnIndex, ascending) {},
                  // dynamicTableInputType: DynamicTableDateInput()
                    dynamicTableInputType: DynamicTableInputType.text(
                      decoration: const InputDecoration(
                        hintText: "Enter Email Address",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 1,
                    )
                ),
                DynamicTableDataColumn(
                    label: const Text("Mobile Number"),
                    onSort: (columnIndex, ascending) {},
                    dynamicTableInputType: DynamicTableInputType.text(
                      decoration: const InputDecoration(
                        hintText: "Enter Mobile Number",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 1,
                    )),
                DynamicTableDataColumn(
                    label: const Text("Absences"),
                    onSort: (columnIndex, ascending) {},
                    dynamicTableInputType: DynamicTableInputType.text(
                      decoration: const InputDecoration(
                        hintText: "",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 1,
                    )),
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 0.1,
          ),
          Flexible(
            flex: 1,
            child:
                Container(
                    alignment: Alignment.center,
                    child: const Text('Select a class to view details.')),
          ),
        ],
      ),
    );
  }
}
