import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';
import 'data_model.dart';
import '../component/common.dart';

const MONGO_URL = "mongodb+srv://$USERNAME:$PASSWORD@cluster0.fmrfcsv.mongodb.net/$DATABASE_NAME?retryWrites=true&w=majority&appName=Cluster0";
const USERNAME = "everyone";
const PASSWORD = "NOb7jpHjkBRbKYBJ";
const DATABASE_NAME = "Dictionary";
const COLLECTION_CONTENT = 'Content';

final database = Database();

class Database {
  Database._internal();
  static final Database _instance = Database._internal();
  factory Database() {
    return _instance;
  }

  var _db;
  static var collection;
  String _username = '';
  String _password = '';

  Future<StatusApp> connect() async {
    try {
      _db = await Db.create(MONGO_URL).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Connection to MongoDB timed out');
      });
      await _db.open().timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Connection to MongoDB timed out');
      });
      collection = _db.collection( );
      return StatusApp.success;
    } catch(e) {
      return StatusApp.connectError;
    }
  }

  Future<StatusApp> disconnect() async {
    try {
      await _db.close();
      return StatusApp.success;
    } catch(e) {
      return StatusApp.disconnectError;
    }
  }

  Future<StatusApp> save(var grammar, var words) async {
    try {
      StatusApp ret = await connect();
      if(ret != StatusApp.success) return ret;

      var data = await collection.findOne({"username": _username});
      if(data == null || data["password"] != _password) return StatusApp.incorrectAccount;

      data["words"] = words;
      data["grammar"] = grammar;
      await collection.updateOne(where.eq('username', _username), modify.set('words', words).set('grammar', grammar));
      ret = await disconnect();

      return StatusApp.success;
    } catch(e) {
      return StatusApp.error;
    }
  }

  Future<StatusApp> login(String user, String pw) async {
    try {
      _username = user;
      _password = pw;

      StatusApp ret = await connect();
      if(ret != StatusApp.success) return ret;

      var data = await collection.findOne({"username": user});
      if(data == null || data["password"] != pw) return StatusApp.incorrectAccount;

      ret = await disconnect();
      if(ret != StatusApp.success) return ret;

      dataModel.loadData(data);
      return StatusApp.success;
    } catch(e) {
      return StatusApp.error;
    }
  }

  void logout() {
    _username = '';
    _password = '';
    dataModel.reset();
  }
}