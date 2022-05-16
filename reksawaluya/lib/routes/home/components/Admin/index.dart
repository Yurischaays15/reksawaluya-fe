import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:reksawaluya/routes/antrian/index.dart';
import 'package:reksawaluya/routes/data_pasien/index.dart';
import 'package:reksawaluya/routes/home/components/MenuBox/index.dart';
import 'package:reksawaluya/routes/pendaftaran/index.dart';
import 'package:reksawaluya/routes/poliklinik/index.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset('assets/images/logo.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuBox(
                destination: const DataPasienView(),
                  text: 'Pasien',
                  icon: LineIcon.personEnteringBooth(
                    size: 60,
                  )),
              const SizedBox(
                width: 20,
              ),
              MenuBox(
                destination: const PendaftaranView(),
                  text: 'Pendaftaran\nAntrian',
                  icon: LineIcon.clipboard(
                    size: 60,
                  ))
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuBox(
                destination: const PoliklinikView(),
                  text: 'Informasi\nPoliklinik',
                  icon: LineIcon.hospital(
                    size: 60,
                  )),
              const SizedBox(
                width: 20,
              ),
              MenuBox(
                destination: const AntrianView(),
                  text: 'Informasi\nAntrian',
                  icon: LineIcon.clock(
                    size: 60,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
