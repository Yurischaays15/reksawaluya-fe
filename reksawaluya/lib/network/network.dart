import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Network extends GetxController {

  Map<String, String> _networkHeader = {};

  // final baseUrl = 'https://adminreksawaluya.my.id/admin/';
  final baseUrl = 'https://adminreksawaluya.my.id/';

  _getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return {"Content-Type": "application/json"};
    }
    token = 'Token $token';
    log('the token $token' );
    var headers = {"Content-Type": "application/json", "Authorization": token};
    return headers;
  }

  addToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool(Constant.loggedInKey, true);
    _networkHeader = await _getHeader();
  }

  doGet(String path) async {
    return http.get(Uri.parse(baseUrl + path), headers: _networkHeader);
  }

  doPost(String path, String body) async {
    return http.post(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }

  doPut(String path, String body) async {
    return http.put(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }



  @override
  void onInit() async {
    super.onInit();
    _networkHeader = await _getHeader();
  }

}