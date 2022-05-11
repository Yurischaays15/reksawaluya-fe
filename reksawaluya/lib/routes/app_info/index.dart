import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rumah Sakit Reksa Waluya'),
            const SizedBox(height: 12,),
            const Text(
                'Jl. Mojopahit No 422, Mergelo, Kranggan, Kec. Prajurit Kulon, Mojokerto, 61323'),
            const SizedBox(height: 12,),
            const Text('Hubungi Kami'),
            const SizedBox(height: 8,),
            Row(
              children: [
                LineIcon.phone(
                  size: 30,
                ),
                const SizedBox(width: 18,),
                const Text('(0321) 322170/322171')
              ],
            ),
            Row(
              children: [
                LineIcon.whatSApp(
                  size: 30,
                ),
                const SizedBox(width: 18,),
                const Text('0813-3121-6208')
              ],
            ),
            Row(
              children: [
                LineIcon.instagram(
                  size: 30,
                ),
                const SizedBox(width: 18,),
                const Text('@reksa_waluya')
              ],
            ),
            Row(
              children: [
                LineIcon.facebook(
                  size: 30,
                ),
                const SizedBox(width: 18,),
                const Text('Rumah Sakit Reksa Waluya')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
