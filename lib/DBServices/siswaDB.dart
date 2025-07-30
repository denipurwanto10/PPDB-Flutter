// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'siswaC.dart';
//
// class Services {
//   // find web server (apache) address using ipconfig localhost is not work
//   //static const ROOT = 'http://localhost/EmployeesDB/employee_actions.php';
//   static const ROOT = 'http://192.168.1.7/PPDB/siswa_actions.php';
//   static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
//   static const _GET_ALL_ACTION = 'GET_ALL';
//   static const _ADD_SISWA_ACTION = 'ADD_SISWA';
//   static const _UPDATE_SISWA_ACTION = 'UPDATE_SISWA';
//   static const _DELETE_SISWA_ACTION = 'DELETE_SISWA';
//
//   // Method to create the table Employees.
//   static Future<String> createTable() async {
//     try {
//       // add the parameters to pass to the request.
//       var map = Map<String, dynamic>();
//       map['action'] = _CREATE_TABLE_ACTION;
//       //final response = await http.post(ROOT, body: map);
//       final response = await http.post(Uri.parse(ROOT), body: map);
//       print('Create Table Response: ${response.body}');
//       if (200 == response.statusCode) {
//         return response.body;
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return "error";
//     }
//   }
//
//   static Future<List<Siswa>> getSiswa() async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _GET_ALL_ACTION;
//       final response = await http.post(Uri.parse(ROOT), body: map);
//       print('getEmployees Response: ${response.body}');
//       if (200 == response.statusCode) {
//         List<Siswa> list = parseResponse(response.body);
//         return list;
//       } else {
//         return <Siswa>[]; // pengganti List<Employee>() uses list literal
//       }                       // no initial size is provided,use list literal
//     } catch (e) {
//       return <Siswa>[]; // return an empty list on exception/error
//     }
//   }
//
//   static List<Siswa> parseResponse(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<Siswa>((json) => Siswa.fromJson(json)).toList();
//   }
//
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'siswaC.dart';

class Services {
  static const ROOT = 'http://192.168.1.7/PPDB/siswa_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_SISWA_ACTION = 'ADD_SISWA';
  static const _UPDATE_SISWA_ACTION = 'UPDATE_SISWA';
  static const _DELETE_SISWA_ACTION = 'DELETE_SISWA';
  static const _UPDATE_SISWA_STATUS_ACTION = 'UPDATE_SISWA_STATUS';
  static const _GET_SELEKSI_ACTION = 'GET_SELEKSI';

  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Siswa>> getSiswa() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getSiswa Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Siswa> list = parseResponse(response.body);
        return list;
      } else {
        return <Siswa>[];
      }
    } catch (e) {
      return <Siswa>[];
    }
  }

  static List<Siswa> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Siswa>((json) => Siswa.fromJson(json)).toList();
  }

  static Future<String> addSiswa(Siswa siswa) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_SISWA_ACTION;
      map['NISN'] = siswa.NISN;
      map['nama'] = siswa.nama;
      map['jenkel'] = siswa.jenkel;
      map['KK'] = siswa.KK;
      map['tgl_lahir'] = siswa.tgl_lahir;
      map['alamat'] = siswa.alamat;
      map['agama'] = siswa.agama;
      map['seleksi'] = siswa.seleksi;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Add Siswa Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateSiswa(Siswa siswa) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_SISWA_ACTION;
      map['NISN'] = siswa.NISN;
      map['nama'] = siswa.nama;
      map['jenkel'] = siswa.jenkel;
      map['KK'] = siswa.KK;
      map['tgl_lahir'] = siswa.tgl_lahir;
      map['alamat'] = siswa.alamat;
      map['agama'] = siswa.agama;
      map['seleksi'] = siswa.seleksi;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Siswa Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deleteSiswa(String nisn) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_SISWA_ACTION;
      map['NISN'] = nisn;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Delete Siswa Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  static Future<String> updateSiswaStatus(String nisn, String status) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_SISWA_STATUS_ACTION;
      map['NISN'] = nisn;
      map['status'] = status;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Siswa Status Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  static Future<String> getSeleksi(String nisn) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_SELEKSI_ACTION;
      map['NISN'] = nisn;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get Seleksi Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  static Future<List<Map<String, dynamic>>> getSiswaAndNilai() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;

      // Fetch data from the siswa table
      final responseSiswa = await http.post(Uri.parse(ROOT), body: map);
      print('getSiswa Response: ${responseSiswa.body}');
      if (responseSiswa.statusCode != 200) {
        return <Map<String, dynamic>>[]; // Return an empty list on error
      }

      List<Siswa> siswaList = parseResponse(responseSiswa.body);

      // Fetch data from the nilai table
      final responseNilai = await http.post(Uri.parse(ROOT), body: map);
      print('getNilai Response: ${responseNilai.body}');
      if (responseNilai.statusCode != 200) {
        return <Map<String, dynamic>>[]; // Return an empty list on error
      }

      List<Map<String, dynamic>> nilaiList = json.decode(responseNilai.body).cast<Map<String, dynamic>>();

      // Perform a join operation based on a common key (e.g., NISN)
      List<Map<String, dynamic>> combinedData = [];

      for (Siswa siswa in siswaList) {
        Map<String, dynamic> nilaiData = nilaiList.firstWhere(
              (nilai) => nilai['NISN'] == siswa.NISN,
          orElse: () => {},
        );

        // Combine data from siswa and nilai
        Map<String, dynamic> combined = {
          'NISN': siswa.NISN,
          'nama': siswa.nama,
          'seleksi': siswa.seleksi,
          'nilai_rata_rata': nilaiData['Rerata'],
          // Add other fields as needed
        };

        combinedData.add(combined);
      }

      return combinedData;
    } catch (e) {
      return <Map<String, dynamic>>[]; // Return an empty list on exception/error
    }
  }
}