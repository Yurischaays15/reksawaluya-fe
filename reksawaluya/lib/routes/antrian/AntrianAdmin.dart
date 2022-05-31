import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
class AntrianAdminView extends StatefulWidget {
  final String kodepoli;
  final String poliName;
  const AntrianAdminView({Key? key, required this.kodepoli, required this.poliName}) : super(key: key);

  @override
  _AntrianAdminViewState createState() => _AntrianAdminViewState();
}

class _AntrianAdminViewState extends State<AntrianAdminView> {
  String tanggalNow = '';
  int antrianNow = 0;
  int antrianLatest = 0;
  final Network network = Get.find();

  _initialData() async {
    Intl.defaultLocale = "id_ID";
    initializeDateFormatting();
    var formatter = DateFormat('EEEE, dd MMMM yyyy');
    var now = DateTime.now();
    tanggalNow = formatter.format(now);
    setState(() {});
    var result = await network.doGet('/antrian/now/${widget.kodepoli}');
    print(result.body);
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      antrianNow = d['antrian'];
    }
    result = await network.doGet('/pendaftaran/latest/?tanggal=$tanggalNow&kodepoli=${widget.kodepoli}');
    print(result.body);
    d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      antrianLatest = d['antrian'];
    }
    setState(() {
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
        title: const Text('Informasi Antrian'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black45)),
              child: Column(
                children: [
                  Row(),
                  const SizedBox(height: 8,),
                  Text(widget.poliName, style: AllStyles.primaryMenu(),),
                  Text(tanggalNow, style: AllStyles.primaryBody,),
                  const SizedBox(height: 8,)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
            Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black45)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Antrian Saat Ini', style: AllStyles.primaryMenu(),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(antrianNow.toString(), style: AllStyles.primaryMenu(),),
              ),
            ],
          )),
                Expanded(child: Container()),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Antrian Terakhir', style: AllStyles.primaryMenu(),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(antrianLatest.toString(), style: AllStyles.primaryMenu(),),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
