import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{
  static Database? _database;

  //Contructor privado para lograr un singleton
  DBProvider._(); 
  
  //Instanciando el singleton
  static final DBProvider dbp=DBProvider._();

  //Acceso a la base de datos
  Future<Database?> get getDataBase async{
    if(_database==null)
      _database=await initDB();
    return _database;  
  }
  
  Future<Database?> initDB() async{
    //Crear el directorio
    Directory	docDirectory=await getApplicationDocumentsDirectory();
    final path=join(docDirectory.path,'ScansDB.db');
    print(path);
    //Crear Base de datos
    return await openDatabase(
      path,
      version: 3,
      onOpen: (db){},
      onCreate: (db, version){
        db.execute("""
                  CREATE TABLE Scans(
                    id INTERGER PRIMARY KEY,
                    tipo TEXT,
                    valor TEXT                    
                  )
                  """);
      },
    ); 
  }

  Future<int> AddScanRaw(ScanModel newscan)async{
    final db=await getDataBase;
    int res=0;
    //final {id,tipo,valor}=newscan; Destructuración no soportada en Dart
    final id=newscan.id;
    final tipo=newscan.tipo;
    final valor=newscan.valor;
    if(db!=null)
       res=await db.rawInsert('''INSERT INTO 
                                 Scans(id,tipo,valor) 
                                 VALUE($id,"$tipo","$valor"})''');
    return res;
  }

  Future<int> AddScan(ScanModel newscan)async
  {
    final db=await getDataBase;
    int res=0;
    if(db!=null)
       res=await db.insert('Scans', newscan.toJson());
    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int pid) async
  {
     final db=await getDataBase;
     final res=await db?.query('Scans',where: 'id=?', whereArgs: [pid]);

     return res!.isNotEmpty?ScanModel.fromJson(res.first):null;
  }

  Future<List<ScanModel?>> getAllScans()async {
      final db=await getDataBase;
      final res=await db!.query('Scans');
       return res.isNotEmpty
              ? res.map((e) => ScanModel.fromJson(e)).toList()
              : [];
  }

  // Future<int> deleteAllScans()async{
  //     final db=await getDataBase;      
    

  // }
}
