import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE siswa(
        NISN TEXT PRIMARY KEY,
        nama TEXT,
        jenkel TEXT,
        KK TEXT,
        tgl_lahir TEXT,
        alamat TEXT,
        agama TEXT,
        seleksi TEXT
      )
      """);

    await database.execute("""CREATE TABLE nilai(
        id INTEGER PRIMARY KEY,
        NISN TEXT,
        BIndo TEXT,
        MTK TEXT,
        IPA TEXT,
        BInggris TEXT,
        PKN TEXT,
        SB TEXT,
        Rerata TEXT,
        FOREIGN KEY (NISN) REFERENCES siswa (NISN)
      )
      """);

    await database.execute('''
    CREATE TRIGGER hapus_nilai AFTER DELETE ON siswa
    BEGIN
      DELETE FROM nilai WHERE old.NISN = nilai.NISN;
    END
    ''');

    await database.execute('''
    CREATE TRIGGER auto_create_nilai AFTER INSERT ON siswa
    BEGIN
      INSERT INTO nilai (NISN) VALUES (new.NISN);
    END
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'PPDB.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // siswa
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('siswa', orderBy: "NISN");
  }

  static Future<int> createItem(String? NISN, String? nama, String? jenkel, String? KK, String? tgl_lahir, String? alamat, String? agama) async {
    final db = await SQLHelper.db();

    final data = {
      'NISN': NISN,
      'nama': nama,
      'jenkel': jenkel,
      'KK': KK,
      'tgl_lahir': tgl_lahir,
      'alamat': alamat,
      'agama': agama,
      'seleksi': "Di Proses"
    };
    final id = await db.insert('siswa', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateItem(String? NISN, String? nama, String? jenkel, String? KK, String? tgl_lahir, String? alamat, String? agama) async {
    final db = await SQLHelper.db();

    final data = {
      'NISN': NISN,
      'nama': nama,
      'jenkel': jenkel,
      'KK': KK,
      'tgl_lahir': tgl_lahir,
      'alamat': alamat,
      'agama': agama,
      'seleksi': "Di Proses"
    };

    final result =
    await db.update('siswa', data, where: "NISN = ?", whereArgs: [NISN]);
    return result;
  }

  static Future<void> deleteItem(String NISN) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("siswa", where: "NISN = ?", whereArgs: [NISN]);
    } catch (err) {
      debugPrint("Something went wrong when deleting siswa: $err");
    }
  }

  // nilai
  static Future<List<Map<String, dynamic>>> getItems2() async {
    final db = await SQLHelper.db();
    return db.query('nilai', orderBy: "id");
  }

  static Future<int> updateItem2(int id, String? BIndo, String? MTK, String? IPA, String? BInggris, String? PKN, String? SB, String? Rerata) async {
    final db = await SQLHelper.db();

    final data = {
      'BIndo': BIndo,
      'MTK': MTK,
      'IPA': IPA,
      'BInggris': BInggris,
      'PKN': PKN,
      'SB': SB,
      'Rerata': Rerata,
    };

    final result = await db.update('nilai', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // seleksi
  static Future<List<Map<String, dynamic>>> getItems3() async {
    final db = await SQLHelper.db();
    return db.query('nilai', orderBy: "id");
  }

  static Future<int> updateLulus(String NISN) async {
    final db = await SQLHelper.db();

    final data = {
      'seleksi': "Lulus"
    };

    final result = await db.update('siswa', data, where: "NISN = ?", whereArgs: [NISN]);
    return result;
  }

  static Future<int> updateTolak(String NISN) async {
    final db = await SQLHelper.db();

    final data = {
      'seleksi': "Tidak Lulus"
    };

    final result = await db.update('siswa', data, where: "NISN = ?", whereArgs: [NISN]);
    return result;
  }

}