import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AntrianPasienView extends StatefulWidget {
  final String kodepoli;
  final String poliName;

  const AntrianPasienView(
      {Key? key, required this.kodepoli, required this.poliName})
      : super(key: key);

  @override
  _AntrianPasienViewState createState() => _AntrianPasienViewState();
}

class _AntrianPasienViewState extends State<AntrianPasienView> {
  String tanggalNow = '';
  String nama = '';
  String hari = '';
  String pukul = '';
  final Network network = Get.find();
  int antrianNow = 0;
  int antrianKita = 0;

  _initialData() async {
    Intl.defaultLocale = "id_ID";
    initializeDateFormatting();
    var formatter = DateFormat('EEEE, dd MMMM yyyy');
    var now = DateTime.now();
    tanggalNow = formatter.format(now);
    print(tanggalNow);
    setState(() {});
    var result = await network.doGet('/antrian/now/${widget.kodepoli}');
    print(result.body);
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      antrianNow = d['antrian'];
    }
    setState(() {
      antrianNow;
    });

   var result1 = await network.doGet(
        '/pendaftaran/daftar/?tanggal=$tanggalNow&kodepoli=${widget.kodepoli}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nama = prefs.getString(Constant.nameKey)!;
    print(result1.body);
    d = jsonDecode(result1.body);
    print(d);
    if (d['status'] == 'OK') {
      hari = d['hari'];
      pukul = d['jam'];
      antrianKita = d['antrian'];
    }
    setState(() {
      hari;
      pukul;
      antrianKita;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black45)),
              child: Column(children: [
                Row(),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Nama: ${nama}',
                  style: AllStyles.primaryMenu(),
                ),
                Text(
                  'Poli: ${widget.poliName}',
                  style: AllStyles.primaryBody,
                ),
                // Text(
                //   'Hadir pada: ${hari != '' ? tanggalNow: ''}',
                //   style: AllStyles.primaryBody,
                // ),
                Text(
                  'Hari periksa: ${hari}',
                  style: AllStyles.primaryBody,
                ),
                Text(
                  'Pukul: ${pukul}',
                  style: AllStyles.primaryBody,
                ),
                const SizedBox(
                  height: 15,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black45)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'POLI \n${widget.poliName}\nAntrian',
                          style: AllStyles.primaryMenu(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          antrianKita.toString(),
                          style: AllStyles.primaryMenu(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black45)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Antrian \nSekarang \n',
                          style: AllStyles.primaryMenu(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          antrianNow.toString(),
                          style: AllStyles.primaryMenu(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
