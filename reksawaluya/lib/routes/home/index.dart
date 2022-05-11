import 'package:flutter/material.dart';
import 'package:reksawaluya/routes/account_info/index.dart';
import 'package:reksawaluya/routes/app_info/index.dart';
import 'package:reksawaluya/routes/home/components/Admin/index.dart';
import 'package:reksawaluya/routes/home/components/Pasien/index.dart';
import 'package:reksawaluya/routes/home/components/Poliklinik/index.dart';
import 'package:reksawaluya/routes/login/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  Widget mainScreen = Container();
  String appTitle = '';
  String name = '';
  String email = '';

  _determineScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constant.secondNameKey)!;
    email = prefs.getString(Constant.emailKey)!;
    int? role = prefs.getInt(Constant.roleKey);
    if (role == Constant.rolePatient) {
      mainScreen = const PasienView();
      appTitle = 'Hai, Pasien';
    }
    if (role == Constant.roleAdmin) {
      mainScreen = const AdminView();
      appTitle = 'Hai, Admin';
    }
    if (role == Constant.rolePoli) {
      mainScreen = const PoliklinikView();
      appTitle = 'Hai, Poliklinik';
    }
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    _determineScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: mainScreen,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name),
                    Text(email)
                  ],
                ),
              ),
              ListTile(
                title: const Text('Akun'),
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountInfoView()),
                  );
                  _determineScreen();
                },
              ),
              ListTile(
                title: const Text('Info Aplikasi'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AppInfoView()),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(Constant.loggedInKey, false);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginView()),
                      ModalRoute.withName("/CheckoutSuccess"));
                },
              ),
            ],
          ),
        )
    );
  }
}
