import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_tutorial/src/home/data/model/sample_model.dart';

class SqlDataBase {
  static final SqlDataBase instance = SqlDataBase._instance();

  Database? _database;

  Future<Database> get database async {
    if(_database != null){
      return _database!;
    }else{
      await _initDataBase();
      return _database!;
    }
  }

  SqlDataBase._instance() {
    _initDataBase();
  }

  factory SqlDataBase() {
    return instance;
  }

  Future<void> _initDataBase() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'sample.db');
    _database = await openDatabase(path, version: 1, onCreate: _databaseCreate);
  }

  // db open
  Future<void> _databaseCreate(Database db, int version) async {
    await db.execute('''
    
      create table ${SampleModel.tableName} (
        ${SampleFields.id} integer primary key autoincrement,
        ${SampleFields.name} text not null,
        ${SampleFields.yn} integer not null,
        ${SampleFields.value} double not null,
        ${SampleFields.createdAt} text not null     
      )
    
    ''');
  }

  // db close
  Future<void> closeDataBase() async {
    if(_database != null) {
      await _database!.close();
    }
  }
}
