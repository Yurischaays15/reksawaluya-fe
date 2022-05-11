import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/models/PasienModel.dart';
import 'package:reksawaluya/network/network.dart';

class PasienAdminDetailView extends StatefulWidget {
  final PasienModel pasien;
  const PasienAdminDetailView({Key? key, required this.pasien}) : super(key: key);

  @override
  _PasienAdminDetailViewState createState() => _PasienAdminDetailViewState();
}

class _PasienAdminDetailViewState extends State<PasienAdminDetailView> {
  final Network network = Get.find();
  final _cName = TextEditingController();
  final _cTanggal = TextEditingController();
  final _cJenis = TextEditingController();
  final _cNik = TextEditingController();
  final _cAlamat = TextEditingController();
  final _cTelpon = TextEditingController();
  final _cBpjs = TextEditingController();

  _fetchData() async {
    _cName.text = widget.pasien.name!;
    _cTanggal.text = widget.pasien.date!;
    _cJenis.text = widget.pasien.gender!;
    _cNik.text = widget.pasien.nik!;
    _cAlamat.text = widget.pasien.address!;
    _cTelpon.text = widget.pasien.telp!;
    _cBpjs.text = widget.pasien.bpjs!;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yakin mau dihapus?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                await network.doGet('/pasien/delete/${widget.pasien.medicalRecord}');
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Data berhasil dihapus.')));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _doUbah() async {
    var payload = {
      'medical_record': widget.pasien.medicalRecord,
      'name': _cName.text,
      'date': _cTanggal.text,
      'gender': _cJenis.text,
      'nik': _cNik.text,
      'address': _cAlamat.text,
      'telp': _cTelpon.text,
      'bpjs': _cBpjs.text,
    };
    
    final result = await network.doPut('/pasien/modify/', jsonEncode(payload));
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Data berhasil diubah.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(d['reason'])));
    }
    
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
        title: const Text('Detail Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Nomor Rekam Medis: ${widget.pasien.medicalRecord}'),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      controller: _cName,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        // name = text;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(onPressed: _showMyDialog, child: const Text('Hapus Data')),
                const SizedBox(width: 8,),
                ElevatedButton(onPressed: _doUbah, child: const Text('Ubah'))

              ],)
            ],
          ),
        ),
      ));
  }
}
