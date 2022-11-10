import 'dart:convert';

import 'package:auth_app/model/Sign_in_model.dart';
import 'package:auth_app/server_config.dart';
import 'package:http/http.dart' as http;

class AuthRepo{


  Future<bool> signInWithEmail(String email, String password) async{
    String signInUrl = Config.serverUrl + Config.signInUrl;
    var response = await http.post(Uri.parse(signInUrl),body: <String, String>{
      'email': email,
      'password':password
    });
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      //print(data);
      var message = SignInModel.fromJson(data);
      print(message.message);
      return true;
    }
    return false;
  }

}