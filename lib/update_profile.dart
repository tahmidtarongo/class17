

import 'dart:io';

import 'package:auth_app/home_screen.dart';
import 'package:auth_app/model/User_profile_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Repository/auth_repo.dart';



class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, required this.userProfileModel}) : super(key: key);

  final UserProfileModel userProfileModel;
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  String imagePath = 'No Data';
  File imageData = File('No Data');
  void getImage() async{
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageData = File(image?.path ?? 'No Data');
      imagePath = image?.path ?? 'No Data';
    });
    
  }


  @override
  void initState() {
    nameController.text = widget.userProfileModel.data!.user!.name!;
    emailController.text = widget.userProfileModel.data!.user!.email!;
    phoneController.text = widget.userProfileModel.data!.user!.phone!;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please Update Profile',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(50.0),
              image: imagePath !='No Data' ? DecorationImage(image: FileImage(imageData),fit: BoxFit.cover) : DecorationImage(image: NetworkImage('https://opensource.org/sites/default/files/public/osi_keyhole_300X300_90ppi_0.png'),fit: BoxFit.cover),
              ),
            ).onTap(() => getImage()),
            SizedBox(height: 10.0,),
            AppTextField(
              textFieldType: TextFieldType.NAME,
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Please Enter Your Full Name',
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10.0,
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
              textFieldType: TextFieldType.PHONE,
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Please Enter Your Phone Number',
                  labelText: 'Phone',
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
            ).onTap(() async{
              try{
                EasyLoading.show(status: 'Signing Up');
                var status = await AuthRepo().updateProfileWithOutImage(nameController.text, emailController.text, phoneController.text);
                if(status){
                  EasyLoading.showSuccess('Sign Up Successful');
                  HomeScreen().launch(context);
                } else{
                  EasyLoading.showError('User Exist');
                }
              }catch (e){
                print(e.toString());
                EasyLoading.showError(e.toString());
              }
            }),

          ],
        ),
      ),
    );
  }
}
