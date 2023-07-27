import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/Urls.dart' as url;
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';
import '../../../API/model/genModel.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({Key? key}) : super(key: key);

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  TextEditingController nameController = TextEditingController();

  Future<void> postData() async {
    genModel? genmodel =
        await url.Urls.postApiCall(method: '${Urls.addPaymentMethod}', params: {
      "name": nameController.text,
    });
    if (genmodel != null) {
      if (genmodel.status == true) {
        Fluttertoast.showToast(
            msg: genmodel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.shade400,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    }
  }

  void clearData() {
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Settings > Payment Method",
          style: Theme.of(context)
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
            Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 10,),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  postData();
                  clearData();
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
