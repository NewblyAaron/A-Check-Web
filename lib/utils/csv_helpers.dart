import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

const _csvConverter = ListToCsvConverter();

class CsvHelpers {
  static Future<List<dynamic>> importFromCsvFile(
      {required Uint8List bytes}) async {
    final toUtf8 = const Utf8Decoder().convert(bytes);
    return const CsvToListConverter().convert(toUtf8);
  }

  static Future<String> exportToCsvFile(
      {required String fileName,
      required List<dynamic> header,
      required List<dynamic> data}) async {
    List<List<dynamic>> rows = [];

    // set first row as header names
    rows.add(header);

    // iterate through data, adding new row
    for (var values in data) {
      rows.add(values);
    }

    // convert to csv
    final dir = await getDownloadsDirectory();
    final csvFile = File("${dir?.path}/$fileName.csv");
    String csv = _csvConverter.convert(rows);
    await csvFile.writeAsString(csv);
    return csvFile.path;
  }
}
