import 'package:auth_app/home_screen.dart';
import 'package:auth_app/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> goScreen() async{
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    if(token.isEmptyOrNull){
      await Future.delayed(const Duration(seconds: 5)).then((value) => const SignIn().launch(context));
    }else{
      await Future.delayed(const Duration(seconds: 5)).then((value) => const HomeScreen().launch(context));
    }

  }

  @override
  void initState() {
    goScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: CircleAvatar(
          radius: 70.0,
          backgroundColor: Colors.white,
          child: Text('Auth App',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
