import 'package:auth_app/Repository/auth_repo.dart';
import 'package:auth_app/model/User_profile_model.dart';
import 'package:auth_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FutureBuilder<UserProfileModel>(
        future: AuthRepo().getProfile(),
          builder: (_, snapshot) {
        if(snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(snapshot.data?.data?.user?.image ?? ''),
              ),
              Text(
                snapshot.data?.data?.user?.name ?? '',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                snapshot.data?.data?.user?.email ?? '',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                snapshot.data?.data?.user?.phone ?? '',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                snapshot.data?.data?.user?.wallet?.balance.toString() ?? '',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Log Out').onTap(() async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', '');
                SplashScreen().launch(context);
              }),
            ],
          );
        } else{
          return CircularProgressIndicator();
        }
      })),
    );
  }
}
