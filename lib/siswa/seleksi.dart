import 'package:flutter/material.dart';
import '../DBServices/siswaC.dart';
import '../DBServices/siswaDB.dart';

class seleksi extends StatefulWidget {
  const seleksi({Key? key}) : super(key: key);

  @override
  _SeleksiState createState() => _SeleksiState();
}

class _SeleksiState extends State<seleksi> {
  List<Map<String, dynamic>> combinedData = [];
  List<Siswa> _siswaList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() async {
    Services.getSiswaAndNilai().then((data) {
      print("Fetched Data: $data");
      setState(() {
        combinedData = data;
        _isLoading = false; // Set _isLoading to false after data is loaded
      });
      print("Length ${data.length}");
    });
  }

  Future<void> _updateItem(String NISN) async {
    await Services.updateSiswaStatus(NISN, 'Lulus');
    refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Siswa LULUS !')),
    );
  }

  Future<void> _updateItem2(String NISN) async {
    await Services.updateSiswaStatus(NISN, 'Tidak Lulus');
    refreshData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Siswa TIDAK LULUS !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          "Seleksi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: combinedData.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> data = combinedData[index];

          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: Text(
                'Status : ${data['seleksi']}',
                style: TextStyle(
                  color: data['seleksi'] == 'Lulus'
                      ? Colors.green
                      : data['seleksi'] == 'Di Proses'
                      ? Colors.grey
                      : Colors.red,
                ),
              ),
              subtitle: Text(
                'NISN : ${data['NISN']}\n'
                    'Nama : ${data['nama']}\n'
                    'Nilai Rata-rata : ${data['nilai_rata_rata']}',
              ),
              trailing: data['seleksi'] != null
                  ? IconButton(
                icon: const Icon(
                  Icons.mode_edit_outline_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => _showForm(data['NISN']),
              )
                  : const Icon(
                Icons.edit_off_sharp,
                color: Colors.red,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showForm(String? NISN) async {
    if (NISN != null) {
      // You can retrieve the current data based on NISN from combinedData list
      final currentData = combinedData.firstWhere(
            (element) => element['NISN'] == NISN,
      );

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
                controller: TextEditingController(text: currentData['NISN']),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefix: Text("NISN : "),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(text: currentData['nama']),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefix: Text("Nama : "),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: TextEditingController(text: currentData['nilai_rata_rata']),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefix: Text("Nilai Rata-rata : "),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      await _updateItem2(NISN!);
                      refreshData();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tidak Lulus'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      await _updateItem(NISN!);
                      refreshData();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Lulus'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
