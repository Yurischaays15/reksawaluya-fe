import 'package:flutter/material.dart';
import 'package:reksawaluya/routes/data_pasien/index.dart';
import 'package:reksawaluya/routes/poliklinik/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranPasienView extends StatefulWidget {
  const PendaftaranPasienView({Key? key}) : super(key: key);

  @override
  _PendaftaranPasienViewState createState() => _PendaftaranPasienViewState();
}

class _PendaftaranPasienViewState extends State<PendaftaranPasienView> {
  List<Widget> wHolder = [];

  populateScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? medRecord = prefs.getString(Constant.medRecordKey);
    String? dateBorn = prefs.getString(Constant.tanggalKey);
    if (medRecord != null && medRecord != '-') {
      List<Widget> p = [
        Text('Nomor Rekam Medis: $medRecord'),
        Text('Tanggal lahir: $dateBorn'),
        ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PoliklinikView()),
            ), child: const Text('Lanjut'))
      ];
      setState(() {
        wHolder = p;
      });
    } else {
      List<Widget> p = [
        const Text('Anda belum mempunyai data pasien.'),
        ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DataPasienView()),
            ), child: const Text('Register Pasien baru'))
      ];
      setState(() {
        wHolder = p;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    populateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...wHolder],
        ),
      ),
    );
  }
}
