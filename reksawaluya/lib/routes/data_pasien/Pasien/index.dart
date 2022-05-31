import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DPPasienView extends StatefulWidget {
  const DPPasienView({Key? key}) : super(key: key);

  @override
  _DPPasienViewState createState() => _DPPasienViewState();
}

class _DPPasienViewState extends State<DPPasienView> {
  final Network network = Get.find();
  final _cName = TextEditingController();
  final _cTanggal = TextEditingController();
  final _cJenis = TextEditingController();
  final _cNik = TextEditingController();
  final _cAlamat = TextEditingController();
  final _cTelpon = TextEditingController();
  final _cBpjs = TextEditingController();
  bool _isEdit = false;
  String? medicalRecord;
  ScreenshotController screenshotController = ScreenshotController();

  _downloadData() async {
      Widget ckartu = Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(alignment: Alignment.center,child: Text('RS Reksa Waluya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)),
              const Align(alignment: Alignment.center,child: Text('Kartu Pasien', style: TextStyle(fontSize: 16, color: Colors.black),)),
              const SizedBox(height: 8,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('No. RM:', style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('Nama:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('TTL:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('Jenis kelamin:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('NIK:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('Alamat:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('Nomor Telepon:', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Text('Nomor BPJS:', style: TextStyle(fontSize: 16, color: Colors.black),),
                    ],
                  ),
                  const SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$medicalRecord', style: const TextStyle(fontSize: 16, color: Colors.black)),
                      Text(_cName.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cTanggal.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cJenis.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cNik.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cTanggal.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cTelpon.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                      Text(_cBpjs.text, style: const TextStyle(fontSize: 16, color: Colors.black),),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8,)
            ],
          ),
        ),
      );
      screenshotController
          .captureFromWidget(ckartu)
          .then((capturedImage) async {
        Uint8List? theImage = capturedImage;
        final result = await ImageGallerySaver.saveImage(theImage);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Kartu Pasien Tersimpan.')));
      });
  }


  _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    medicalRecord = prefs.getString(Constant.medRecordKey);
    log('the med record $medicalRecord');
    if (medicalRecord != '-') {
      final result = await network.doGet('/pasien/detail/$medicalRecord');
      final d = jsonDecode(result.body);
      await prefs.setString(Constant.tanggalKey, d['date']);
      if (d['status'] == 'OK') {
        _cName.text = d['name'];
        _cTanggal.text = d['date'];
        _cJenis.text = d['gender'];
        _cNik.text = d['nik'];
        _cAlamat.text = d['address'];
        _cTelpon.text = d['telp'];
        _cBpjs.text = d['bpjs'];
        _isEdit = true;
      }
    }
    setState(() {

    });
  }

  _doSave() async {
    if (!_isEdit) {
      final p = {
        'name': _cName.text,
        'date': _cTanggal.text,
        'gender': _cJenis.text,
        'nik': _cNik.text,
        'address': _cAlamat.text,
        'telp': _cTelpon.text,
        'bpjs': _cBpjs.text,
      };
      final result = await network.doPost('/pasien/modify/', jsonEncode(p));
      var d = jsonDecode(result.body);
      if (d['status'] == 'OK') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constant.medRecordKey, d['medical_record']);
        await _fetchData();
        ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('Simpan data berhasil.')));
      }
    } else {
      final p = {
        'name': _cName.text,
        'date': _cTanggal.text,
        'gender': _cJenis.text,
        'nik': _cNik.text,
        'address': _cAlamat.text,
        'telp': _cTelpon.text,
        'bpjs': _cBpjs.text,
        'medical_record': medicalRecord,
      };
      final result = await network.doPut('/pasien/modify/', jsonEncode(p));
      var d = jsonDecode(result.body);
      if (d['status'] == 'OK') {
        ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('Update data berhasil.')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Nomor Rekam Medis: $medicalRecord'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              controller: _cName,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Nama Lengkap',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cTanggal,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Tempat, Tanggal Lahir',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cJenis,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Jenis Kelamin',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cNik,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Nomor Induk Kependudukan (NIK)',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cAlamat,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Alamat',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cTelpon,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Nomor Telepon',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _cBpjs,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: 'Nomor BPJS',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide())))),
                    ],
                  ),
              ),
            ),
            ElevatedButton(onPressed: () => _doSave(), child: const Text('Submit')),
            ElevatedButton(onPressed: () {
              _downloadData();
            }, child: const Text('Cetak Kartu Pasien')),
          ],
        ),
      ),
    );
  }
}
