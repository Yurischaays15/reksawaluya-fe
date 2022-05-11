import 'package:flutter/material.dart';
import 'package:reksawaluya/main.dart';
import 'package:reksawaluya/routes/pendaftaran/components/Pasien/index.dart';
import 'package:reksawaluya/routes/pendaftaran/components/pendaftaran_admin_view.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranView extends StatefulWidget {
  const PendaftaranView({Key? key}) : super(key: key);

  @override
  _PendaftaranViewState createState() => _PendaftaranViewState();
}

class _PendaftaranViewState extends State<PendaftaranView> {
  Widget mainScreen = Container();

  _determineScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt(Constant.roleKey);
    print('the roler $role');
    if (role == Constant.rolePatient) {
      mainScreen = const PendaftaranPasienView();
    }
    if (role == Constant.roleAdmin) {
      mainScreen = const PendaftaranAdminView();
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
          title: const Text('Pendaftaran'),
        ),
        body: mainScreen);
  }
}
