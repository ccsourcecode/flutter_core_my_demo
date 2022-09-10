import 'package:gsheets/gsheets.dart';
import '../models/house_entity.dart';

class GoogleSheetsProvider {
  final GSheets _gsheets;

  late Worksheet? _worksheet;

  GoogleSheetsProvider(String credentials) : _gsheets = GSheets(credentials);

  Future<void> initializeForWorksheet(
      String spreadsheetId, String worksheetTitle) async {
    print("start1");
    final excel = await _gsheets.spreadsheet(spreadsheetId);

    print("start2");
    _worksheet = excel.worksheetByTitle(worksheetTitle);
    _worksheet ??= await excel.addWorksheet(worksheetTitle);

    print("start3");
  }

  Future<List<HouseEntity>> getHouses() async {
    /// skips the first row which is the header
    print("9");
    final houses = (await _worksheet!.values.allRows()).skip(1).toList();
    print("10");

    return houses.map((value) => HouseEntity.fromSheets(value)).toList();
    // return List.generate(
    //     houses.length,
    //     (index) => HouseEntity(
    //           name: houses[index][0],
    //           address: houses[index][0],
    //         ));
  }

  Future<bool> deleteHouse(int index) {
    /// We add one to the index so that we can:
    /// 1. Start at index 1
    /// 2. Skip the first row
    return _worksheet!.deleteRow(index + 2);
  }

  Future<bool> addHouse(String name, String address) {
    return _worksheet!.values.appendRow([name, address]);
  }
}
