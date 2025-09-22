import 'package:appwrite/appwrite.dart';
import 'package:learning_english_web/constants/env_app.dart';
import 'package:learning_english_web/model/account.dart';

final server = AppwriteService();

class AppwriteService {
  late Client client;
  late TablesDB tablesDB;

  AppwriteService._internal();

  factory AppwriteService() {
    return _instance;
  }

  static final AppwriteService _instance = AppwriteService._internal();

  Future<bool> initialize() async {
    try {
      client = Client();
      client.setEndpoint(EnvApp.endPoint).setProject(EnvApp.projectID).setSelfSigned(status: true);
      tablesDB = TablesDB(client);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllAccount(List<AccountApp> accounts) async {
    try {
      int limit = 10;
      int offset = 0;

      while (true) {
        final response = await tablesDB.listRows(
            databaseId: EnvApp.databaseId,
            tableId: EnvApp.accountTableId,
            queries: [
              Query.limit(limit),
              Query.offset(offset)
            ]
        );

        if (response.rows.isEmpty) {
          break;
        }

        for (var item in response.rows) {
          accounts.add(AccountApp(item.data['user'], item.data['password'], item.data['id']));
        }

        offset += limit;
      }

      if (accounts.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getData(List<String> data) async {
    try {
      final res = await tablesDB.getRow(
        databaseId: EnvApp.databaseId,
        tableId: EnvApp.dataTableId,
        rowId: EnvApp.rowID,
      );

      data.addAll(List<String>.from(res.data['data']));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setData(List<String> data) async {
    try {
      Map<String, dynamic> map = {};
      map['username'] = EnvApp.userName;
      map['data'] = data;

      await tablesDB.updateRow(
          databaseId: EnvApp.databaseId,
          tableId: EnvApp.dataTableId,
          rowId: EnvApp.rowID,
          data: map
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}