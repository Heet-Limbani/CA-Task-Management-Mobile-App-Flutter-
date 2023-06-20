import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/API/Urls.dart' as url;
import 'package:task_manager/ui/pages/DashBoard/sidebarAdmin.dart';

import '../../../API/model/countDataModel.dart';
import '../../../API/model/genModel.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({Key? key}) : super(key: key);

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  TextEditingController nameController=TextEditingController();

  Future<void> postData(String input) async {
    genModel? genmodel =
    await url.Urls.postApiCall(method: '${url.Urls.addPaymentMethod}',
    params: {
      "name":input
    });
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        // final data = genmodel.data;
        print(input);
        // dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');
        setState(() {});
      }
    }
  }

  // Future<void> postData(String input) async{
  //   final response = await http.post(
  //     Uri.parse('${url.Urls.addPaymentMethod}'),
  //     body: {
  //       "name": input
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data=jsonDecode(response.body);
  //     print('API response: $data');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Payment Method",
          style: Theme
              .of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarAdmin(),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            // SizedBox(height: 10,),
            TextField(
              controller: nameController,
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              String input=nameController.text;
              postData(input);
            }, child: Text(
              'Submit'
            )),
          ],
        ),
      ),
    );
  }
}
