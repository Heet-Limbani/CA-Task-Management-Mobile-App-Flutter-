import 'package:flutter/material.dart';
import 'package:task_manager/API/Urls.dart' as url;
import 'package:task_manager/ui/pages/sidebar/sidebarAdmin.dart';
import '../../../API/model/genModel.dart';

class EditPaymentMethod extends StatefulWidget {
  const EditPaymentMethod({Key? key}) : super(key: key);

  @override
  State<EditPaymentMethod> createState() => _EditPaymentMethodState();
}

class _EditPaymentMethodState extends State<EditPaymentMethod> {
  TextEditingController nameController=TextEditingController();


  Future<void> editData(int id, String input) async {
    genModel? genmodel =
    await url.Urls.postApiCall(method: '${url.Urls.editPaymentMethod}',
        params: {
          "id":id,
          "name":input
        });
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        // final data = genmodel.data;
        //print(input);
        // dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');
        setState(() {});
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final Map arguments =
    ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Edit Payment Method",
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
              int id=int.parse(arguments['userId']);
              String input=nameController.text;
              editData(id,input);
            }, child: Text(
                'Submit'
            )),
          ],
        ),
      ),
    );
  }
}
