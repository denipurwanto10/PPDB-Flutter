// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../SQLite/sql_helper.dart';
//
// class nilai extends StatefulWidget {
//   const nilai({Key? key, }) : super(key: key);
//   @override
//   nilaiState createState() => nilaiState();
// }
//
// class nilaiState extends State<nilai> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text(
//           "Data Siswa",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: nilai.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.green,
//                 child: Text(
//                   '${index + 1}',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               title: Text('NISN : ${nilai[index]['NISN']}'),
//                subtitle:
//                  Text(
//                 'B.Indonesia : ${nilai[index]['BIndo']}\n'
//                     'Matematika : ${nilai[index]['MTK']}\n'
//                     'IPA : ${nilai[index]['IPA']}\n'
//                     'B.Inggris : ${nilai[index]['BInggris']}\n'
//                     'PKN : ${nilai[index]['PKN']}\n'
//                     'Seni Budaya : ${nilai[index]['SB']}\n'
//                     'Rata - Rata : ${nilai[index]['Rerata']}\n'
//                  ),
//               trailing: SizedBox(
//                 width: 70,
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit_note_sharp, color: Colors.black, size: 50,),
//                       onPressed: () => _showForm(nilai[index]['id']),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   List<Map<String, dynamic>> nilai= [];
//   bool _isLoading = true;
//
//   final TextEditingController _BIndo = TextEditingController();
//   final TextEditingController _MTK = TextEditingController();
//   final TextEditingController _IPA = TextEditingController();
//   final TextEditingController _BInggris = TextEditingController();
//   final TextEditingController _PKN = TextEditingController();
//   final TextEditingController _SB = TextEditingController();
//   final TextEditingController _Rerata = TextEditingController();
//
//   void refreshData() async {
//     final data = await SQLHelper.getItems2();
//     setState(() {
//       nilai = data;
//       _isLoading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     refreshData();
//   }
//
//   void _showForm(int? id) async {  // call when floating button is pressed
//     if (id != null) {  // id == null -> crt new brg, else upd existing brg
//       final currentBrg = nilai.firstWhere((element) => element['id'] == id);
//       _BIndo.text = currentBrg['BIndo']?.toString() ?? '';
//       _MTK.text = currentBrg['MTK']?.toString() ?? '';
//       _IPA.text = currentBrg['IPA']?.toString() ?? '';
//       _BInggris.text = currentBrg['BInggris']?.toString() ?? '';
//       _PKN.text = currentBrg['PKN']?.toString() ?? '';
//       _SB.text = currentBrg['SB']?.toString() ?? '';
//       _Rerata.text = currentBrg['Rerata']?.toString() ?? '';
//     }
//
//     showModalBottomSheet(
//         context: context, elevation: 5, isScrollControlled: true,
//         builder: (_) => SingleChildScrollView(
//           padding: EdgeInsets.only(top: 15, left: 15, right: 15,
//             // this will prevent the soft keyboard from covering txt fields
//             bottom: MediaQuery.of(context).viewInsets.bottom + 120,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextField(
//                 controller: _BIndo,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'B.Indonesia'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _MTK,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'Matematika'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _IPA,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'IPA'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _BInggris,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'B.Inggris'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _PKN,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'PKN'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _SB,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'Seni Budaya'),
//               ),
//               const SizedBox( height: 10, ),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     border: Border.all(
//                       color: Colors.white, // Warna border
//                       width: 0.5, // Lebar border
//                     ),
//                     borderRadius: BorderRadius.circular(8.0), // Bentuk border (dalam hal ini sudut bulat)
//                   ),
//                   child: TextButton(
//                     onPressed: () {
//                       int x1 = int.parse(_BIndo.text);
//                       int x2 = int.parse(_MTK.text);
//                       int x3 = int.parse(_IPA.text);
//                       int x4 = int.parse(_BInggris.text);
//                       int x5 = int.parse(_PKN.text);
//                       int x6 = int.parse(_SB.text);
//                       List<int> myValues = [x1, x2, x3, x4, x5, x6];
//                       double average = calculateAverage(myValues);
//                       _Rerata.text = average.toStringAsFixed(1);
//                     },
//                     child: Text(
//                       'Hitung Rata-rata',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _Rerata,
//                 readOnly: true,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'Rata - Rata'),
//               ),
//               const SizedBox( height: 10, ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (id == null) {  }
//                   else { await _updateItem(id);  }
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(id == null ? 'Create New' : 'Save'),
//               )
//             ],
//           ),
//         ));
//   }
//
//   double calculateAverage(List<int> values) {
//     if (values.isEmpty) {
//       return 0.0;
//     }
//     int sum = 0;
//     for (int value in values) {
//       sum += value;
//     }
//     return sum / values.length.toDouble();
//   }
//
//   Future<void> _updateItem(int id) async {   // Update an existing brg
//     await SQLHelper.updateItem2(
//       id,
//       _BIndo.text,
//       _MTK.text,
//       _IPA.text,
//       _BInggris.text,
//       _PKN.text,
//       _SB.text,
//       _Rerata.text,
//     );
//     refreshData();
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar( content: Text('Nilai Successfully updated!'), )
//     );
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class nilai extends StatefulWidget {
  const nilai({Key? key}) : super(key: key);

  @override
  _nilaiState createState() => _nilaiState();
}

class _nilaiState extends State<nilai> {
  List<Map<String, dynamic>> nilai = [];
  bool _isLoading = true;

  final TextEditingController _BIndo = TextEditingController();
  final TextEditingController _MTK = TextEditingController();
  final TextEditingController _IPA = TextEditingController();
  final TextEditingController _BInggris = TextEditingController();
  final TextEditingController _PKN = TextEditingController();
  final TextEditingController _SB = TextEditingController();
  final TextEditingController _Rerata = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.7/PPDB/nilai_actions.php'),
      body: {'action': 'GET_ALL'},
    );

    if (response.statusCode == 200) {
      setState(() {
        nilai = List<Map<String, dynamic>>.from(json.decode(response.body));
        _isLoading = false;
      });
    }
  }

  Future<void> _updateItem(String NISN) async {
    await _calculateRerata();
    await _updateNilai(NISN);

    refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nilai Successfully updated!')),
    );
  }

  Future<void> _updateNilai(String NISN) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.7/PPDB/nilai_actions.php'),
      body: {
        'action': 'UPDATE_NILAI',
        'NISN': NISN,
        'BIndo': _BIndo.text,
        'MTK': _MTK.text,
        'IPA': _IPA.text,
        'BInggris': _BInggris.text,
        'PKN': _PKN.text,
        'SB': _SB.text,
        'Rerata': _Rerata.text,
      },
    );

    if (response.body == 'success') {
      print('Update Nilai Success');
    } else {
      print('Update Nilai Failed');
    }
  }

  Future<void> _calculateRerata() async {
    int x1 = int.parse(_BIndo.text);
    int x2 = int.parse(_MTK.text);
    int x3 = int.parse(_IPA.text);
    int x4 = int.parse(_BInggris.text);
    int x5 = int.parse(_PKN.text);
    int x6 = int.parse(_SB.text);
    List<int> myValues = [x1, x2, x3, x4, x5, x6];
    double average = calculateAverage(myValues);
    _Rerata.text = average.toStringAsFixed(1);
  }

  double calculateAverage(List<int> values) {
    if (values.isEmpty) {
      return 0.0;
    }
    int sum = 0;
    for (int value in values) {
      sum += value;
    }
    return sum / values.length.toDouble();
  }

  void _showForm(String NISN) {
    final currentNilai = nilai.firstWhere((element) => element['NISN'] == NISN);
    _BIndo.text = (currentNilai['BIndo'] as String?) ?? '';
    _MTK.text = (currentNilai['MTK'] as String?) ?? '';
    _IPA.text = (currentNilai['IPA'] as String?) ?? '';
    _BInggris.text = (currentNilai['BInggris'] as String?) ?? '';
    _PKN.text = (currentNilai['PKN'] as String?) ?? '';
    _SB.text = (currentNilai['SB'] as String?) ?? '';
    _Rerata.text = (currentNilai['Rerata'] as String?) ?? '';

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _BIndo,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'B.Indonesia'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _MTK,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Matematika'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _IPA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'IPA'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _BInggris,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'B.Inggris'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _PKN,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'PKN'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _SB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Seni Budaya'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.white,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () {
                    int x1 = int.parse(_BIndo.text);
                    int x2 = int.parse(_MTK.text);
                    int x3 = int.parse(_IPA.text);
                    int x4 = int.parse(_BInggris.text);
                    int x5 = int.parse(_PKN.text);
                    int x6 = int.parse(_SB.text);
                    List<int> myValues = [x1, x2, x3, x4, x5, x6];
                    double average = calculateAverage(myValues);
                    _Rerata.text = average.toStringAsFixed(1);
                  },
                  child: Text(
                    'Hitung Rata-rata',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _Rerata,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Rata - Rata'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateItem(NISN);
                Navigator.of(context).pop();
              },
              child: Text(NISN == null ? 'Update' : 'Save'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addItem() async {
    await _calculateRerata();
    await _insertNilai();

    refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nilai Successfully added!')),
    );
  }

  Future<void> _insertNilai() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.7/PPDB/nilai_actions.php'),
      body: {
        'action': 'ADD_NILAI',
        'BIndo': _BIndo.text,
        'MTK': _MTK.text,
        'IPA': _IPA.text,
        'BInggris': _BInggris.text,
        'PKN': _PKN.text,
        'SB': _SB.text,
        'Rerata': _Rerata.text,
      },
    );

    if (response.body == 'success') {
      print('Insert Nilai Success');
    } else {
      print('Insert Nilai Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Data Nilai",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: nilai.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: Text('NISN : ${nilai[index]['NISN']}'),
              subtitle: Text(
                'B.Indonesia : ${nilai[index]['BIndo']}\n'
                    'Matematika : ${nilai[index]['MTK']}\n'
                    'IPA : ${nilai[index]['IPA']}\n'
                    'B.Inggris : ${nilai[index]['BInggris']}\n'
                    'PKN : ${nilai[index]['PKN']}\n'
                    'Seni Budaya : ${nilai[index]['SB']}\n'
                    'Rata - Rata : ${nilai[index]['Rerata']}\n',
              ),
              trailing: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit_note_sharp,
                        color: Colors.black,
                        size: 50,
                      ),
                      onPressed: () =>
                          _showForm(nilai[index]['NISN']),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
