import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';

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
    final csv = _csvConverter.convert(rows);
    final bytes = utf8.encode(csv);
    return await FileSaver.instance.saveFile(
        name: fileName, bytes: bytes, ext: "csv", mimeType: MimeType.csv);
  }
}
