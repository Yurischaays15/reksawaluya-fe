import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/login/change_password/index.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({Key? key}) : super(key: key);

  @override
  _AccountInfoViewState createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  late String email, name, nik, address, phone;
  late int id;
  final _cName = TextEditingController();
  final _cNik = TextEditingController();
  final _cAddress = TextEditingController();
  final _cPhone = TextEditingController();
  final _cEmail = TextEditingController();
  final Network network = Get.find();

  _doSave() async {
    var payload = {
      'id': id,
      'email': email,
      'name': name,
      'nik': nik,
      'address': address,
      'phone': phone,
    };
    final result = await network.doPost('/user/detail/', jsonEncode(payload));
    final d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constant.emailKey, email);
      await prefs.setString(Constant.nameKey, name);
      await prefs.setString(Constant.nikKey, nik);
      await prefs.setString(Constant.addressKey, address);
      await prefs.setString(Constant.phoneKey, phone);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Update data berhasil.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong.')));
    }
  }

  _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt(Constant.userIdKey)!;
    name = prefs.getString(Constant.nameKey)!;
    _cName.text = prefs.getString(Constant.nameKey)!;
    nik = prefs.getString(Constant.nikKey)!;
    _cNik.text = prefs.getString(Constant.nikKey)!;
    address = prefs.getString(Constant.addressKey)!;
    _cAddress.text = prefs.getString(Constant.addressKey)!;
    phone = prefs.getString(Constant.phoneKey)!;
    _cPhone.text = prefs.getString(Constant.phoneKey)!;
    email = prefs.getString(Constant.emailKey)!;
    _cEmail.text = prefs.getString(Constant.emailKey)!;
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Akun'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: _cName,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          name = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Nama Lengkap',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: _cNik,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          nik = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'NIK',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: _cAddress,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          address = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Alamat',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: _cPhone,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          phone = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Nomor Telepon',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: _cEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          email = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                TextButton(
                  child: const Text('Lupa password?'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordView()),
                  ),
                ),
                ElevatedButton(
                    onPressed: _doSave, child: const Text('Ubah Data'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
