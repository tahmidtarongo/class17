import 'package:auth_app/Repository/auth_repo.dart';
import 'package:auth_app/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Please Sign In',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            AppTextField(
              textFieldType: TextFieldType.EMAIL,
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Please Enter Your Email',
                  labelText: 'Email Address',
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10.0,
            ),
            AppTextField(
              textFieldType: TextFieldType.PASSWORD,
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Please Enter Your password',
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
              child: const Center(
                  child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
            ).onTap(()async{
              try{
                EasyLoading.show(status: 'Singing in');
                bool status = await AuthRepo().signInWithEmail(emailController.text, passwordController.text);
                if(status){
                  EasyLoading.showSuccess('Sign In Successfull');
                }else{
                  EasyLoading.showError('Email or Password is wrong');
                }
              }catch(e){
                EasyLoading.showError(e.toString());
              }
            }),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account yet?',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  'Sign Up Here',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ).onTap(() => const SignUp().launch(context))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
