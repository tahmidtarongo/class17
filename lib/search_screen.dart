import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  String? searchedText;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppTextField(
                textFieldType: TextFieldType.PHONE,
                onChanged: (val){
                  setState(() {
                    searchedText = val;
                  });
                },
                decoration:
                    InputDecoration(border: OutlineInputBorder(), labelText: 'Search Here', prefixIcon: Icon(Icons.search), hintText: 'Search Your Queries Here'),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 100,
                itemBuilder: (_,i){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Text(i.toString(),style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),)),
              ).visible(searchedText.isEmptyOrNull ? true : i.toString().contains(searchedText!));
            })
          ],
        ),
      ),
    );
  }
}
