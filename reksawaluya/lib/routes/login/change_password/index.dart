import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late String _oldPass, _newPass;
  final Network network = Get.find();

  _doSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(Constant.emailKey);
    final payload = {
      'old_pass': _oldPass,
      'new_pass': _newPass,
      'email': email,
    };
    final result = await network.doPost('/user/resetpassword/', jsonEncode(payload));
    final d = jsonDecode(result.body);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(d['message'])));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      _oldPass = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Password Lama',
                        hintText: 'Masukkan password lama',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      _newPass = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Password Baru',
                        hintText: 'Masukkan password baru',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            ElevatedButton(
                onPressed: _doSave, child: const Text('Ubah Password'))
          ],
        ),
      ),
    );
  }
}
