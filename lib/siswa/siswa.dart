import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/siswa/nilai.dart';
import 'package:sqlite_flutter_crud/siswa/seleksi.dart';
import '../Authtentication/login.dart';
import 'admin.dart';
import 'listSiswa.dart';

class siswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penerimaan Peserta Didik',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo, // Set the background color to indigo
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/assets/sekolah.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16, // Atur jarak antara item secara horizontal
                mainAxisSpacing: 16,  // Atur jarak antara item secara vertikal
                childAspectRatio: 1.2,
                children: [
                    itemDashboard('Siswa', CupertinoIcons.person, Colors.amber, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => listSiswa()));
                    }),
                    itemDashboard('Nilai', CupertinoIcons.book_solid, Colors.green, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => nilai()));
                    }),
                    itemDashboard('Seleksi', CupertinoIcons.check_mark, Colors.blue, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => seleksi()));
                    }),
                    itemDashboard('Admin', CupertinoIcons.lock_shield_fill, Colors.grey, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => admin()));
                    }),
                ],
              ),

            ),
          const SizedBox(height: 20)
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              onPressed: () {
                showLogoutConfirmationDialog(context);
              },
            tooltip: 'Logout',
            child: Icon(Icons.logout, color: Colors.white),
            backgroundColor: Colors.red,
          ),
          Positioned(
            bottom: 14.0,
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Menambahkan onTap callback
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

}
