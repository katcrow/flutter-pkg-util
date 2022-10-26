import 'package:sqflite_tutorial/src/home/data/repository/sql_database.dart';
import '../model/sample_model.dart';

class SqlSampleCrudRepo {
  static Future<SampleModel> create(SampleModel sampleModel) async {
    var db = await SqlDataBase().database;
    var id = await db.insert(SampleModel.tableName, sampleModel.toJson());
    return sampleModel.clone(id: id);
  }

  static Future<List<SampleModel>> getList() async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      SampleModel.tableName,
      columns: [
        SampleFields.id,
        SampleFields.name,
        SampleFields.yn,
        // SampleFields.value,
        SampleFields.createdAt,
      ],
    );
    return result.map((data) {
      return SampleModel.fromJson(data);
    }).toList();
  }

  static Future<SampleModel?> getSampleOne(int id) async {
    var db = await SqlDataBase().database;
    var result = await db.query(
      SampleModel.tableName,
      columns: [
        SampleFields.id,
        SampleFields.name,
        SampleFields.yn,
        SampleFields.value,
        SampleFields.createdAt,
      ],
      where: '${SampleFields.id} = ?',
      whereArgs: ['$id']
    );
    var list = result.map((data) {
      return SampleModel.fromJson(data);
    }).toList();

    if(list.isNotEmpty){
      return list.first;
    } else {
      return null;
    }
  }

  static Future<int> updateSampleOne(SampleModel sampleModel) async {
    var db = await SqlDataBase().database;
    return await db.update(
        SampleModel.tableName,
        sampleModel.toJson(), // Map 으로
        where: '${SampleFields.id} = ?',
        whereArgs: ['${sampleModel.id}']
    );
  }

  static Future<int> deleteSampleOne(int id) async {
    var db = await SqlDataBase().database;
    return await db.delete(
        SampleModel.tableName,
        where: '${SampleFields.id} = ?',
        whereArgs: ['$id']
    );
  }


}
