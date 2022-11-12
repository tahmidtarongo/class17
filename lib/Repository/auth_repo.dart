import 'dart:convert';

import 'package:auth_app/model/Sign_in_model.dart';
import 'package:auth_app/server_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Sign_up_model.dart';
import '../model/User_profile_model.dart';

class AuthRepo {

  Future<bool> signInWithEmail(String email, String password) async {
    String signInUrl = Config.serverUrl + Config.signInUrl;
    final prefs = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(signInUrl), body: <String, String>{'email': email, 'password': password});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(data);
      var message = SignInModel.fromJson(data);
      await prefs.setString('token', message.data!.token.toString());
      return true;
    }
    return false;
  }

  Future<bool> signUpWithEmail(String name, String email, String phoneNumber, String password) async {
    String signUpUrl = Config.serverUrl + Config.signUpUrl;
    var response = await http.post(Uri.parse(signUpUrl), body: <String, String>{'name': name, 'email': email, 'phone': phoneNumber, 'password': password});
    final prefs = await SharedPreferences.getInstance();
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //print(data);
      var message = SignUpModel.fromJson(data);
      await prefs.setString('token', message.data!.token.toString());
      print(message.message);
      return true;
    } else if (response.statusCode == 422) {
      throw Exception('User Have Exist');
    } else {
      throw Exception('User Have Exist');
    }
  }

  Future<UserProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    String url = Config.serverUrl + Config.profileUrl;
    var response = await http.get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token'
    });
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return UserProfileModel.fromJson(data);
    }else{
      throw Exception('User Not Found');
    }

  }

}
