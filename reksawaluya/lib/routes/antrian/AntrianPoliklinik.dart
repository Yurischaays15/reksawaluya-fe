import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AntrianPoliklinikView extends StatefulWidget {
  final String kodepoli;
  final String poliName;

  const AntrianPoliklinikView(
      {Key? key, required this.kodepoli, required this.poliName})
      : super(key: key);

  @override
  _AntrianPoliklinikViewState createState() => _AntrianPoliklinikViewState();
}

class _AntrianPoliklinikViewState extends State<AntrianPoliklinikView> {
  final Network network = Get.find();
  String tanggalNow = '';
  int antrianNow = 0;

  _fetchData() async {
    Intl.defaultLocale = "id_ID";
    initializeDateFormatting();
    var formatter = DateFormat('EEEE, dd MMMM yyyy');
    var now = DateTime.now();
    tanggalNow = formatter.format(now);
    var result = await network.doGet('/antrian/now/${widget.kodepoli}');
    print(result.body);
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      antrianNow = d['antrian'];
    }
    setState(() {

    });
  }
  
  _addAntrian() async {
    final result = await network.doGet('/antrian/add/${widget.kodepoli}');
    var d = jsonDecode(result.body);
    print(d.toString());
    if (d['status'] == 'OK') {
      antrianNow = d['antrian'];
    }
    setState(() {

    });
  }

  _reduceAntrian() async {
    final result = await network.doGet('/antrian/reduce/${widget.kodepoli}');
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      antrianNow = d['antrian'];
    }
    setState(() {

    });
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
        title: const Text('Antrian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.poliName,
                      style: AllStyles.primaryMenu(),
                    ),
                    Text(
                      tanggalNow,
                      style: AllStyles.primaryBody,
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black45)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Antrian Saat Ini',
                        style: AllStyles.primaryMenu(),
                      ),
                      Text(
                        antrianNow.toString(),
                        style: AllStyles.primaryMenu(),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: _reduceAntrian, icon: const Icon(Icons.skip_previous),  iconSize: 80),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle_fill),  iconSize: 80),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: _addAntrian, icon: const Icon(Icons.skip_next), iconSize: 80,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
