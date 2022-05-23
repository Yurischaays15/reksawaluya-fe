import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const dayMap = {
  'Senin': 1,
  'Selasa': 2,
  'Rabu': 3,
  'Kamis': 4,
  'Jumat': 5,
  'Sabtu': 6,
  'Minggu': 7
};

class KonfirmasiJadwalView extends StatefulWidget {
  final String poliName;
  final String doctorName;
  final Schedule schedule;
  final String poliKode;

  const KonfirmasiJadwalView(
      {Key? key,
      required this.poliName,
      required this.doctorName,
      required this.schedule,
      required this.poliKode})
      : super(key: key);

  @override
  _KonfirmasiJadwalViewState createState() => _KonfirmasiJadwalViewState();
}

class _KonfirmasiJadwalViewState extends State<KonfirmasiJadwalView> {
  String name = '';
  String formattedTanggal = '';
  final Network network = Get.find();

  _popData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constant.nameKey)!;
    var theDay = dayMap[widget.schedule.date];
    var now = DateTime.now();
    while (now.weekday != theDay) {
      now = now.add(const Duration(days: 1));
    }
    Intl.defaultLocale = "id_ID";
    initializeDateFormatting();
    var formatter = DateFormat('EEEE, dd MMMM yyyy');
    formattedTanggal = formatter.format(now);
    setState(() {});
  }


  _saveData() async {
    var payload = {
      'kode_poli': widget.poliKode,
      'tanggal': formattedTanggal,
      'hari': widget.schedule.date,
      'jam': widget.schedule.time
    };
    final result = await network.doPost('/pendaftaran/daftar/', jsonEncode(payload));
    var d = jsonDecode(result.body);
    if (d['status'] == "OK") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pendaftaran berhasil.')));
    }
  }

  @override
  void initState() {
    super.initState();
    _popData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Pendaftaran'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black45)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama: $name', style: AllStyles.primaryBody,),
                      Text('Poli  : ${widget.poliName}', style: AllStyles.primaryBody),
                      Text('Dokter: ${widget.doctorName}', style: AllStyles.primaryBody),
                      Text('Tanggal: $formattedTanggal', style: AllStyles.primaryBody),
                      Text('Hari: ${widget.schedule.date}', style: AllStyles.primaryBody),
                      Text('Jam: ${widget.schedule.time} WIB', style: AllStyles.primaryBody)
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: _saveData, child: const Text('Daftar'))
          ],
        ),
      ),
    );
  }
}
