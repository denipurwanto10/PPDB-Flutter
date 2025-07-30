// admin.dart
import 'package:flutter/material.dart';
import '../DBServices/userC.dart';
import '../DBServices/userDB.dart';

class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<admin> {
  List<User> _userList = [];
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _usrName;
  late TextEditingController _usrPassword;
  late User _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Data Admin",
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
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          final User user = _userList[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: Text(
                user.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Username: ${user.username}\n'
                    'Password : ${user.password}\n',
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(user.username),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _Dialog(user.username),
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

  void _showForm(String? username) async {
    String? _selectedJenkel;
    if (username != null) {
      final currentBrg =
      _userList.firstWhere((element) => element.username == username);
      _usrName.text = currentBrg.username;
      _usrPassword.text = currentBrg.password;
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
              controller: _usrName,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _usrPassword,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (username == null) {
                  await _addItem();
                } else {
                  await _updateItem(_usrName.text);
                }
                _clear();
                Navigator.of(context).pop();
              },
              child: Text(username == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  void _clear() {
    _usrName.text = '';
    _usrPassword.text = '';
  }

  void _Dialog(String username) {
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
                _deleteItem(username);
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
      User newUser = User(
        username: _usrName.text,
        password: _usrPassword.text,
      );

      String result = await Services.addUser(newUser);

      if (result == "success") {
        _getUser();
        _showSnackBar('User added successfully!');
      } else {
        _showSnackBar('Failed to add User.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _updateItem(String username) async {
    try {
      User updatedUser = User(
        username: _usrName.text,
        password: _usrPassword.text,
      );

      String result = await Services.updateUser(updatedUser);

      if (result.contains("success")) {
        _getUser();
        _showSnackBar('User updated successfully!');
      } else {
        _showSnackBar('Failed to update User.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }


  Future<void> _deleteItem(String username) async {
    try {
      String result = await Services.deleteUser(username);

      if (result.contains("success")) {
        _getUser();
        _showSnackBar('User deleted successfully!');
      } else {
        _showSnackBar('Failed to delete User.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }


  void _getUser() {
    Services.getUser().then((user) {
      setState(() {
        _userList = user.cast<User>();
      });
      print("Length ${user.length}");
    });
  }

  @override
  void initState() {
    super.initState();
    _userList = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _usrName = TextEditingController();
    _usrPassword = TextEditingController();
    _getUser();
  }
}

