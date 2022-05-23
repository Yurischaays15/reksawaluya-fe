import 'package:flutter/material.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/routes/poliklinik/detail_poli/konfirmasi_jadwal.dart';

class InfoDetailJadwalView extends StatefulWidget {
  final String poliName;
  final Doctors schedules;
  final String poliKode;

  const InfoDetailJadwalView(
      {Key? key,
      required this.poliName,
      required this.schedules,
      required this.poliKode})
      : super(key: key);

  @override
  _InfoDetailJadwalViewState createState() => _InfoDetailJadwalViewState();
}

class _InfoDetailJadwalViewState extends State<InfoDetailJadwalView> {
  List<Widget> widgets = [];

  _popList() {
    for (var sched in widget.schedules.schedule!) {
      Widget hrPraktek = Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black45)),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => KonfirmasiJadwalView(
                //         poliKode: widget.poliKode,
                //           poliName: widget.poliName,
                //           doctorName: widget.schedules.doctorName!,
                //           schedule: sched)),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(sched.date!),
                    Expanded(child: Container()),
                    Text(sched.time!)
                  ],
                ),
              ),
            ),
          ));
      widgets.add(hrPraktek);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _popList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poliName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.schedules.doctorName!),
              const SizedBox(
                height: 10,
              ),
              ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
