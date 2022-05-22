import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/poliklinik/add_poli/AddPoliS2.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class AddPoliView extends StatefulWidget {
  final PoliklinikModel? polinya;

  const AddPoliView({Key? key, this.polinya}) : super(key: key);

  @override
  _AddPoliViewState createState() => _AddPoliViewState();
}

class _AddPoliViewState extends State<AddPoliView> {
  final poliklinikName = TextEditingController();
  final poliklinikKode = TextEditingController();
  String image64 = '';
  File? imageFile;

  List<Doctors> doctors = [];
  final Network network = Get.find();

  _setData() {
    if (widget.polinya != null) {
      poliklinikName.text = widget.polinya?.poliklinikName ?? '';
      poliklinikKode.text = widget.polinya?.poliklinikKode ?? '';
      image64 = widget.polinya?.poliklinikIcon ?? '';
      doctors = widget.polinya?.doctors ?? [];
      print('image $image64');
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Poliklinik'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      controller: poliklinikName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Nama Poliklinik',
                          hintText: 'Masukkan nama poliklinik',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide())))),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      controller: poliklinikKode,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Kode Poliklinik',
                          hintText: 'Masukkan kode poliklinik',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide())))),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    image64 != ''
                        ? Image.memory(
                      base64Decode(image64),
                      height: 120,
                      width: 120,
                    )
                        : imageFile != null ? Image.file(
                      imageFile!,
                      height: 120,
                      width: 120,
                    ) : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          image64 = '';
                              imageFile = File(image.path);
                              setState(() {

                              });
                            }
                          }, child: Text('Pilih File')),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Doctors doc = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPoliS2View()),
                    );
                    setState(() {
                      doctors.add(doc);
                    });
                  },
                  child: const Text('Tambah Dokter')),
              ElevatedButton(
                  onPressed: () async {
                    if (widget.polinya != null) {
                      PoliklinikModel poliklinik = PoliklinikModel(
                          poliklinikId: widget.polinya?.poliklinikId!,
                          poliklinikName: poliklinikName.text,
                          poliklinikKode: poliklinikKode.text,
                          poliklinikIcon: imageFile != null ? base64Encode(imageFile!.readAsBytesSync()):image64 ,
                          doctors: doctors);
                      final result = await network.doPut('/poliklinik/detail/',
                          jsonEncode(poliklinik.toJson()));
                      return;
                    }
                    PoliklinikModel poliklinik = PoliklinikModel(
                        poliklinikName: poliklinikName.text,
                        poliklinikKode: poliklinikKode.text,
                        poliklinikIcon: imageFile != null ? base64Encode(imageFile!.readAsBytesSync()):image64,
                        doctors: doctors);
                    final result = await network.doPost(
                        '/poliklinik/detail/', jsonEncode(poliklinik.toJson()));
                  },
                  child: const Text('Simpan')),
              const SizedBox(
                height: 8,
              ),
              ...doctors.map((e) =>
              (Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black45)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              e.doctorName!,
                              style: AllStyles.primaryBody,
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  doctors.removeAt(doctors.indexOf(e));
                                  setState(() {});
                                },
                                icon: const Icon(Icons.cancel_outlined))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ...?e.schedule?.map((v) =>
                      (Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                              Border.all(color: Colors.black45)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  v.date!,
                                  style: AllStyles.primaryBody,
                                ),
                                Expanded(child: Container()),
                                Text(
                                  v.time!,
                                  style: AllStyles.primaryBody,
                                )
                              ],
                            ),
                          ),
                        ),
                      )))
                    ],
                  ),
                ),
              )))
            ],
          ),
        ),
      ),
    );
  }
}
