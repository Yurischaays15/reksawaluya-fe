import 'package:flutter/material.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/routes/poliklinik/add_poli/AddPoli.dart';
import 'package:reksawaluya/routes/poliklinik/detail_poli/detailjadwal.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPoliklinik extends StatefulWidget {
  final PoliklinikModel poliklinik;

  const DetailPoliklinik({Key? key, required this.poliklinik})
      : super(key: key);

  @override
  _DetailPoliklinikState createState() => _DetailPoliklinikState();
}

class _DetailPoliklinikState extends State<DetailPoliklinik> {
  List<Widget> widgets = [];
  bool isAdminOrPoli = false;

  _populateList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdminOrPoli = prefs.getInt(Constant.roleKey) == Constant.roleAdmin || prefs.getInt(Constant.roleKey) == Constant.rolePoli;
    setState(() {

    });
    for (var schedule in widget.poliklinik.doctors!) {
      List<Widget> details = [];
      for (var tania in schedule.schedule!) {
        Widget h = Row(
          children: [
            Text(tania.date!),
            Expanded(child: Container()),
            Text(tania.time!),
          ],
        );
        details.add(h);
      }
      Widget container = Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: const Color(0xFF000000)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailJadwalView(
                          poliKode: widget.poliklinik.poliklinikKode!,
                          poliName: widget.poliklinik.poliklinikName!,
                          schedules: schedule)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(schedule.doctorName!),
                    const SizedBox(height: 10),
                    const Text('Jadwal Praktek:'),
                    ...details,
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ));
      widgets.add(container);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _populateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.poliklinik.poliklinikName!)),
      floatingActionButton: isAdminOrPoli ? FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPoliView(polinya: widget.poliklinik,)),
          );
          _populateList();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ):null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
