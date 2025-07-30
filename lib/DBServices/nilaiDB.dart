import 'dart:convert';
import 'package:http/http.dart' as http;
import 'nilaiC.dart';

class NilaiDB {
  static const ROOT = 'http://192.168.1.7/PPDB/nilai_actions.php';
  static const _GET_NILAI_ACTION = 'GET_NILAI';
  static const _ADD_NILAI_ACTION = 'ADD_NILAI';
  static const _UPDATE_NILAI_ACTION = 'UPDATE_NILAI';
  static const _DELETE_NILAI_ACTION = 'DELETE_NILAI';

  static Future<List<Nilai>> getNilai() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_NILAI_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getNilai Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Nilai> list = parseResponse(response.body);
        return list;
      } else {
        return <Nilai>[];
      }
    } catch (e) {
      return <Nilai>[];
    }
  }

  static List<Nilai> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Nilai>((json) => Nilai.fromJson(json)).toList();
  }

  static Future<String> addNilai(Nilai nilai) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_NILAI_ACTION;
      map['NISN'] = nilai.NISN;
      map['BIndo'] = nilai.BIndo;
      map['MTK'] = nilai.MTK;
      map['IPA'] = nilai.IPA;
      map['BInggris'] = nilai.BInggris;
      map['PKN'] = nilai.PKN;
      map['SB'] = nilai.SB;
      map['Rerata'] = nilai.Rerata;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Add Nilai Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateNilai(Nilai nilai) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_NILAI_ACTION;
      map['id'] = nilai.id; // Provide the id for the update
      map['NISN'] = nilai.NISN;
      map['BIndo'] = nilai.BIndo;
      map['MTK'] = nilai.MTK;
      map['IPA'] = nilai.IPA;
      map['BInggris'] = nilai.BInggris;
      map['PKN'] = nilai.PKN;
      map['SB'] = nilai.SB;
      map['Rerata'] = nilai.Rerata;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Nilai Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deleteNilai(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_NILAI_ACTION;
      map['id'] = id.toString();

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Delete Nilai Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
