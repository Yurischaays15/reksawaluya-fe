import 'package:flutter/material.dart';
import 'package:reksawaluya/routes/data_pasien/Admin/index.dart';
import 'package:reksawaluya/routes/data_pasien/Pasien/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPasienView extends StatefulWidget {
  const DataPasienView({Key? key}) : super(key: key);

  @override
  _DataPasienViewState createState() => _DataPasienViewState();
}

class _DataPasienViewState extends State<DataPasienView> {
  Widget mainScreen = Container();
  _determineScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt(Constant.roleKey);
    if (role == Constant.rolePatient) {
      mainScreen = const DPPasienView();
    }
    if (role == Constant.roleAdmin) {
      mainScreen = const DPAdminView();
    }
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    _determineScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pasien'),
      ),
      body: mainScreen,
    );
  }
}
