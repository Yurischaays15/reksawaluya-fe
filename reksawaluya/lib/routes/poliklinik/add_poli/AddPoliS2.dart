import 'package:flutter/material.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class AddPoliS2View extends StatefulWidget {
  const AddPoliS2View({Key? key}) : super(key: key);

  @override
  _AddPoliS2ViewState createState() => _AddPoliS2ViewState();
}

class _AddPoliS2ViewState extends State<AddPoliS2View> {
  List<Schedule> schedules = [];
  String doctorName = '';
  String time = '';
  String dropdownValue = 'Senin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Dokter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        doctorName = text;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Nama Dokter',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide())))),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Jadwal',
                  style: AllStyles.primaryBody,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.purpleAccent),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurple,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onChanged: (text) {
                                  time = text;
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    labelText: 'Waktu',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide()))))),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Schedule schedule = Schedule(
                              id: schedules.length + 1,
                              date: dropdownValue,
                              time: time);
                          schedules.add(schedule);
                          setState(() {

                          });
                        },
                        child: const Text('Tambah')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, Doctors(doctorName: doctorName, schedule: schedules));
                        },
                        child: const Text('Simpan')),
                  ),
                ],
              ),
              ...schedules
                  .map((e) => (Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black45)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  e.date!,
                                  style: AllStyles.primaryBody,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  e.time!,
                                  style: AllStyles.primaryBody,
                                )
                              ],
                            ),
                          ),
                        ),
                      )))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
