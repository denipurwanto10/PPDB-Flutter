// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../DBServices/siswaC.dart';
// import '../DBServices/siswaDB.dart';
// import '../SQLite/sql_helper.dart';
//
// class listSiswa extends StatefulWidget {
//   const listSiswa({Key? key, }) : super(key: key);
//   @override
//   listSiswaState createState() => listSiswaState();
// }
//
// class listSiswaState extends State<listSiswa> {
//   List<Siswa> _siswaList = [];
//   late GlobalKey<ScaffoldState> _scaffoldKey;
//   // controller for the First Name TextField we are going to create.
//   late TextEditingController _firstNameController;
//   // controller for the Last Name TextField we are going to create.
//   late TextEditingController _lastNameController;
//   late Siswa _selectedEmployee;
//   late bool _isUpdating;
//   late String _titleProgress;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
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
//       body: ListView.builder(
//         itemCount: _siswaList.length,
//         itemBuilder: (context, index) {
//           final Siswa siswa = _siswaList[index];
//           return Card(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.amber,
//                 child: Text(
//                   '${index + 1}',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               title: Text(siswa.nama, style: TextStyle(fontWeight: FontWeight.bold,),),
//               subtitle: Text(
//                   // 'NISN : ${siswa[index]['NISN']}\n'
//                   // 'Jenis Kelamin : ${siswa[index]['jenkel']}\n'
//                   // 'No KK : ${siswa[index]['KK']}\n'
//                   // 'Tanggal Lahir : ${siswa[index]['tgl_lahir']}\n'
//                   // 'Alamat : ${siswa[index]['alamat']}\n'
//                   // 'Agama : ${siswa[index]['agama']}\n'
//                   'NISN: ${siswa.NISN}\n'
//                       'Jenis Kelamin : ${siswa.jenkel}\n'
//                       'No KK : ${siswa.KK}\n'
//                       'Tanggal Lahir : ${siswa.tgl_lahir}\n'
//                       'Alamat : ${siswa.alamat}\n'
//                       'Agama : ${siswa.agama}'
//               ),
//               trailing: SizedBox(
//                 width: 100,
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                         // onPressed: () => _showForm(siswa[index]['NISN']),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                         // onPressed: () => _deleteItem(siswa[index]['NISN']),
//                       // onPressed: () => _Dialog(siswa[index]['NISN']),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         // show modal add barang
//         child: const Icon(Icons.add),
//         onPressed: () {
//           _showForm(null);
//           _clear();
//         },
//       ),
//     );
//   }
//
//
//   List<Map<String, dynamic>> siswa= [];
//   bool _isLoading = true;
//
//   final TextEditingController _NISN = TextEditingController();
//   final TextEditingController _nama = TextEditingController();
//   final TextEditingController _jenkel = TextEditingController();
//   final TextEditingController _KK = TextEditingController();
//   final TextEditingController _tgl_lahir = TextEditingController();
//   final TextEditingController _alamat = TextEditingController();
//   final TextEditingController _agama = TextEditingController();
//
//   // void refreshDaftSiswa() async {
//   //   final data = await SQLHelper.getItems();
//   //   setState(() {
//   //     siswa = data;
//   //     _isLoading = false;
//   //   });
//   // }
//
//   void _showForm(String? NISN) async {  // call when floating button is pressed
//     String? _selectedJenkel;
//     if (NISN != null) {  // id == null -> crt new brg, else upd existing brg
//       final currentBrg = siswa.firstWhere((element) => element['NISN'] == NISN);
//       _NISN.text = currentBrg['NISN'];
//       _nama.text = currentBrg['nama'];
//       _selectedJenkel = currentBrg['jenkel'];
//       _KK.text = currentBrg['KK'];
//       _tgl_lahir.text = currentBrg['tgl_lahir'];
//       _alamat.text = currentBrg['alamat'];
//       _agama.text = currentBrg['agama'];
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
//                 controller: _NISN,
//                 decoration: const InputDecoration(hintText: 'NISN'),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _nama,
//                 decoration: const InputDecoration(hintText: 'nama'),
//               ),
//               const SizedBox( height: 20, ),
//               DropdownButtonFormField<String>(
//                 value: _selectedJenkel,
//                 items: ['Laki - Laki', 'Perempuan']
//                     .map((jenkel) => DropdownMenuItem(
//                   value: jenkel,
//                   child: Text(jenkel),
//                 ))
//                     .toList(),
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedJenkel = value;
//                     _jenkel.text = value ?? '';
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Jenis Kelamin',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox( height: 10, ),
//               TextField(
//                 controller: _KK,
//                 decoration: const InputDecoration(hintText: 'No KK'),
//               ),
//               const SizedBox( height: 20, ),
//               TextFormField(
//                 controller: _tgl_lahir,
//                 decoration: const InputDecoration(hintText: 'Tanggal Lahir', icon: Icon(Icons.calendar_month_sharp)),
//                 keyboardType: TextInputType.datetime,
//                 onTap: () {
//                   showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   ).then((pickedDate) {
//                     if (pickedDate != null) {
//                       _tgl_lahir.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                     }
//                   });
//                 },
//               ),
//               const SizedBox( height: 20, ),
//               TextField(
//                 controller: _alamat,
//                 decoration: const InputDecoration(hintText: 'Alamat'),
//               ),
//               const SizedBox( height: 20, ),
//               TextField(
//                 controller: _agama,
//                 decoration: const InputDecoration(hintText: 'Agama'),
//               ),
//               const SizedBox( height: 20, ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (NISN == null) { await _addItem();  }      // Sve new brg
//                   else { await _updateItem(_NISN.text);  } // Save upd brg
//                   _clear();
//                   Navigator.of(context).pop();     // Close the bottom sheet
//                 },
//                 child: Text(NISN == null ? 'Create New' : 'Update'),
//               )
//             ],
//           ),
//         ));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // refreshDaftSiswa();
//     _siswaList = [];
//     _isUpdating = false;
//     _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
//     _firstNameController = TextEditingController();
//     _lastNameController = TextEditingController();
//     _getSiswa();
//   }
//
//   void _clear() {
//     _NISN.text = '';
//     _nama.text = '';
//     _jenkel.text = '';
//     _KK.text = '';
//     _tgl_lahir.text = '';
//     _alamat.text = '';
//     _agama.text = '';
//   }
//
//   Future<void> _addItem() async {  // Add a new brg to the database
//     await SQLHelper.createItem(
//         _NISN.text,
//         _nama.text,
//         _jenkel.text,
//         _KK.text,
//         _tgl_lahir.text,
//         _alamat.text,
//         _agama.text
//     );
//     // refreshDaftSiswa();
//     _clear();
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar( content: Text('Siswa Successfully Added!'), )
//     );
//   }
//
//   Future<void> _updateItem(String NISN) async {   // Update an existing brg
//     await SQLHelper.updateItem(
//         _NISN.text,
//         _nama.text,
//         _jenkel.text,
//         _KK.text,
//         _tgl_lahir.text,
//         _alamat.text,
//         _agama.text
//     );
//     // refreshDaftSiswa();
//     _clear();
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar( content: Text('Siswa Successfully updated!'), )
//     );
//   }
//
//   void _deleteItem(String NISN) async {    // Delete an item brg
//     await SQLHelper.deleteItem(NISN);
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar( content: Text('Siswa Successfully deleted!'), )
//     );
//     // refreshDaftSiswa();
//   }
//
//   void _Dialog(String NISN) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete'),
//           content: Text('Apakah Anda yakin ingin Hapus?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Tutup dialog
//               },
//               child: Text('No'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteItem(NISN);
//                 Navigator.pop(context);
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // new DB Method
//   _getSiswa() {
//     // _showProgress('Loading Employees...');
//     Services.getSiswa().then((siswa) {
//       setState(() {
//         _siswaList = siswa.cast<Siswa>();
//       });
//       // _showProgress(widget.title); // Reset the title...
//       print("Length ${siswa.length}");
//     });
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../DBServices/siswaC.dart';
import '../DBServices/siswaDB.dart';

class listSiswa extends StatefulWidget {
  const listSiswa({Key? key}) : super(key: key);

  @override
  listSiswaState createState() => listSiswaState();
}

class listSiswaState extends State<listSiswa> {
  List<Siswa> _siswaList = [];
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _NISN;
  late TextEditingController _nama;
  late TextEditingController _jenkel;
  late TextEditingController _KK;
  late TextEditingController _tgl_lahir;
  late TextEditingController _alamat;
  late TextEditingController _agama;
  late Siswa _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Data Siswa",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _siswaList.length,
        itemBuilder: (context, index) {
          final Siswa siswa = _siswaList[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: Text(
                siswa.nama,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'NISN: ${siswa.NISN}\n'
                      'Jenis Kelamin : ${siswa.jenkel}\n'
                      'No KK : ${siswa.KK}\n'
                      'Tanggal Lahir : ${siswa.tgl_lahir}\n'
                      'Alamat : ${siswa.alamat}\n'
                      'Agama : ${siswa.agama}'
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(siswa.NISN),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _Dialog(siswa.NISN),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showForm(null);
          _clear();
        },
      ),
    );
  }

  void _showForm(String? NISN) async {
    String? _selectedJenkel;
    if (NISN != null) {
      final currentBrg = _siswaList.firstWhere((element) => element.NISN == NISN);
      _NISN.text = currentBrg.NISN;
      _nama.text = currentBrg.nama;
      _selectedJenkel = currentBrg.jenkel;
      _KK.text = currentBrg.KK;
      _tgl_lahir.text = currentBrg.tgl_lahir;
      _alamat.text = currentBrg.alamat;
      _agama.text = currentBrg.agama;
    }

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
              controller: _NISN,
              decoration: const InputDecoration(hintText: 'NISN'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nama,
              decoration: const InputDecoration(hintText: 'nama'),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value: _selectedJenkel,
              items: ['Laki - Laki', 'Perempuan']
                  .map((jenkel) => DropdownMenuItem(
                value: jenkel,
                child: Text(jenkel),
              ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedJenkel = value;
                  _jenkel.text = value ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'Jenis Kelamin',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _KK,
              decoration: const InputDecoration(hintText: 'No KK'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _tgl_lahir,
              decoration: const InputDecoration(
                  hintText: 'Tanggal Lahir', icon: Icon(Icons.calendar_month_sharp)),
              keyboardType: TextInputType.datetime,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                ).then((pickedDate) {
                  if (pickedDate != null) {
                    _tgl_lahir.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _alamat,
              decoration: const InputDecoration(hintText: 'Alamat'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _agama,
              decoration: const InputDecoration(hintText: 'Agama'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (NISN == null) {
                  await _addItem();
                } else {
                  await _updateItem(_NISN.text);
                }
                _clear();
                Navigator.of(context).pop();
              },
              child: Text(NISN == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  void _clear() {
    _NISN.text = '';
    _nama.text = '';
    _jenkel.text = '';
    _KK.text = '';
    _tgl_lahir.text = '';
    _alamat.text = '';
    _agama.text = '';
  }

  void _Dialog(String NISN) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Apakah Anda yakin ingin Hapus?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(NISN);
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _addItem() async {
    try {
      // Assuming you have a Siswa class constructor
      Siswa newSiswa = Siswa(
        NISN: _NISN.text,
        nama: _nama.text,
        jenkel: _jenkel.text,
        KK: _KK.text,
        tgl_lahir: _tgl_lahir.text,
        alamat: _alamat.text,
        agama: _agama.text,
        seleksi: 'Di Proses', // Assuming there is a default value for seleksi
      );

      // Call your service method to add the new Siswa
      String result = await Services.addSiswa(newSiswa);

      if (result == "success") {
        _getSiswa();
        _showSnackBar('Siswa added successfully!');
      } else {
        _showSnackBar('Failed to add Siswa.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _updateItem(String NISN) async {
    try {
      // Assuming you have a Siswa class constructor
      Siswa updatedSiswa = Siswa(
        NISN: _NISN.text,
        nama: _nama.text,
        jenkel: _jenkel.text,
        KK: _KK.text,
        tgl_lahir: _tgl_lahir.text,
        alamat: _alamat.text,
        agama: _agama.text,
        seleksi: '1', // Assuming there is a default value for seleksi
      );

      // Call your service method to update the Siswa
      String result = await Services.updateSiswa(updatedSiswa);

      if (result == "success") {
        _getSiswa();
        _showSnackBar('Siswa updated successfully!');
      } else {
        _showSnackBar('Failed to update Siswa.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _deleteItem(String NISN) async {
    try {
      // Call your service method to delete the Siswa
      String result = await Services.deleteSiswa(NISN);

      if (result == "success") {
        _getSiswa();
        _showSnackBar('Siswa deleted successfully!');
      } else {
        _showSnackBar('Failed to delete Siswa.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  void _getSiswa() {
    Services.getSiswa().then((siswa) {
      setState(() {
        _siswaList = siswa.cast<Siswa>();
      });
      print("Length ${siswa.length}");
    });
  }

  @override
  void initState() {
    super.initState();
    _siswaList = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _NISN = TextEditingController();
    _nama = TextEditingController();
    _jenkel = TextEditingController();
    _KK = TextEditingController();
    _tgl_lahir = TextEditingController();
    _alamat = TextEditingController();
    _agama = TextEditingController();
    _getSiswa();
  }
}
