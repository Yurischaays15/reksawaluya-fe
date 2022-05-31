import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/models/PasienModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/data_pasien/Admin/PasienAdminDetail.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class DPAdminView extends StatefulWidget {
  const DPAdminView({Key? key}) : super(key: key);

  @override
  _DPAdminViewState createState() => _DPAdminViewState();
}

class _DPAdminViewState extends State<DPAdminView> {
  final Network network = Get.find();
  List<Widget> childs = [];

  _fetchPasiens() async {
    childs.clear();
    List<PasienModel> pasiens = [];
    final result = await network.doGet('/pasien/list');
    Iterable d = jsonDecode(result.body);
    pasiens = List<PasienModel>.from(
        d.map((model) => PasienModel.fromJson(model)));
    for (var element in pasiens) {
      var h = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black45)),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasienAdminDetailView(pasien: element)),
                );
                _fetchPasiens();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(element.name!, style: AllStyles.primaryBody,),
                  ],
                ),
              ),
            ),
          ));
          childs.add(h);
    }
    setState(() {

    });
  }



  @override
  void initState() {
    super.initState();
    _fetchPasiens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //         onPressed: () async {
      //           await Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const AddPasienView()),
      //           );
      //           _fetchPasiens();
      //         },
      //         backgroundColor: Colors.cyanAccent,
      //         child: const Icon(Icons.add_outlined),
      //       ),
      body: SingleChildScrollView(
      child: Column( 
        children: [
          const SizedBox(height: 10,),
          ...childs,
                    
        ],
      ),
    ),
    );
  }
}
