import 'package:flutter/material.dart';
import 'package:reksawaluya/routes/antrian/AntrianAdmin.dart';
import 'package:reksawaluya/routes/antrian/AntrianPasien.dart';
import 'package:reksawaluya/routes/antrian/AntrianPoliklinik.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AntrianDirectorView extends StatefulWidget {
  final String kodepoli;
  final String poliName;
  const AntrianDirectorView({Key? key, required this.kodepoli, required this.poliName}) : super(key: key);

  @override
  _AntrianDirectorViewState createState() => _AntrianDirectorViewState();
}

class _AntrianDirectorViewState extends State<AntrianDirectorView> {

  Widget _screen = Container();

  _popScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt(Constant.roleKey);
    if (role == Constant.rolePatient) {
      _screen = AntrianPasienView(kodepoli: widget.kodepoli, poliName: widget.poliName);
    }
    if (role == Constant.roleAdmin) {
      _screen = AntrianAdminView(kodepoli: widget.kodepoli, poliName: widget.poliName);
    }
    if (role == Constant.rolePoli) {
      _screen = AntrianPoliklinikView(kodepoli: widget.kodepoli, poliName: widget.poliName);
    }
    setState(() {});

  }
  @override
  void initState() {
    super.initState();
    _popScreen();
    
  }

  @override
  Widget build(BuildContext context) {
    return _screen;
  }
}
