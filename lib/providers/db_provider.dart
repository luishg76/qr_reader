import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import '../models/scan_model.dart';

class DBProvider{
  static Database? _database;

  //Contructor privado para lograr un singleton
  DBProvider._(); 
  
  //Instanciando el singleton
  static final DBProvider dbp=DBProvider._();

  //Acceso a la base de datos
  Future<Database?> get getDataBase async{
    //if(_database==null)
    _database ?? await initDB();
    return _database;  
  }

  Future<Database?> initDB() async{
    //Crear el directorio
    Directory	docDirectory=await getApplicationDocumentsDirectory();
    final path=p.join(docDirectory.path,'ScansDB.db');    
    //Crear Base de datos
    return await openDatabase(
      path,
      version: 8,
      onOpen: (db){},
      onCreate: (Database db,int version) async {
        await db.execute('''CREATE TABLE Scans (
                            id	INTEGER NOT NULL,
                            tipo TEXT,
                            valor TEXT,
                            PRIMARY KEY(id AUTOINCREMENT))''');
      },
    );
  }

  Future<int> addScanRaw(ScanModel newscan)async{
    final db=await getDataBase;
    int res=0;
    //final {id,tipo,valor}=newscan; Destructuración no soportada en Dart    
    final tipo=newscan.tipo;
    final valor=newscan.valor;
    res=await db!.rawInsert('INSERT INTO Scans(tipo,valor) VALUES("$tipo","$valor")');    
    return res;
  }

  Future<int> addScan(ScanModel newscan)async
  {
    final db=await getDataBase;
    int res=0;
    res=await db!.insert('Scans', newscan.toJson());   
    return res;
  }

  Future<int> updateScan(ScanModel scan) async{
     final db=await getDataBase;
     final res=await db!.update('Scans', scan.toJson(), where: 'id=?',whereArgs: [scan.id]);
     return res;
  }

  Future<ScanModel?> getScanById(int pid) async
  {
     final db=await getDataBase;
     final res=await db!.query('Scans',where: 'id=?', whereArgs: [pid]);
     return res.isNotEmpty ? ScanModel.fromJson(res.first): null;
  }

  Future<List<ScanModel?>> getSansByTipo(String tipo)async
  {
    final db=await getDataBase;
     final res=await db!.query('Scans',where: 'tipo=?', whereArgs: [tipo]);
     return res.isNotEmpty? res.map((e) => ScanModel.fromJson(e)).toList():[];
     
  }

  Future<List<ScanModel?>> getAllScans()async {
      final db=await getDataBase;
      final res=await db!.query('Scans');
       return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> deleteScansById(int id)async
  {
     final db=await getDataBase;
     final res=await db!.delete('Scans', where: 'id=?', whereArgs:[id]);
     return res;    
  }

  Future<int> deleteAllScans()async{
       final db=await getDataBase;
       final res=await db!.delete('Scans');
       return res;
  }
}
