import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/AdminDataModel/companyCommentEditDataModel.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class EditCompanyComments extends StatefulWidget {
  final String id;

  const EditCompanyComments({required this.id, Key? key}) : super(key: key);

  @override
  State<EditCompanyComments> createState() => _EditCompanyCommentsState();
}

class _EditCompanyCommentsState extends State<EditCompanyComments> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _EditCompanyCommentsKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController data = TextEditingController();
    TextEditingController clientName = TextEditingController();


  bool isActive = true;
  bool checkSMS = true;
  bool checkEmail = true;
  String isActiveValue = "";
  String checkSMSValue = "";
  String checkEmailValue = "";
  String userId = "";
  String? selectedClientId1;

  @override
  void dispose() {
  
    clientName.dispose();
    title.dispose();
    data.dispose();
    

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = widget.id; // Store widget.userId in a local variable
    getUser();
  }

  void clearField() {
    clientName.clear();
   title.clear();
    data.clear();
    
  }

  List<CompanyCommentEditDataModel> clientType = [];
  void getUser() async {
    print("id :- $userId");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.manageCompanyComment}',
      params: {
        'id': userId.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final dataa = genmodel.data;

      final companyData = CompanyCommentEditDataModel.fromJson(dataa);

      //clientName.text = companyData.company!.name.toString();
    title.text = companyData.data!.title.toString();
    data.text = companyData.data!.data.toString();
    
      selectedClientId1 = companyData.data!.clientId.toString();
      clientType.add(companyData); // Add the companyData to clientType list

      setState(() {});
    }
  }

  void clientEdit() async {
    try {
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.editCompanyComment}',
        params: {
         
          "id": userId.toString(),
          "company": selectedClientId1.toString(),
          "title": title.text.toString(),
          "data": data.text.toString(),
        
        },
      );
      if (genmodel != null) {
        Fluttertoast.showToast(
          msg: genmodel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (genmodel.status == true) {
          setState(() {});
        }
      }
    } catch (e) {
      // Handle the exception
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Company > Comments > Edit",
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
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _EditCompanyComments(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _header() {
    return Row(
      children: [
        Text(
          "Edit Company Comments",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _EditCompanyComments() {
    return Form(
      key: _EditCompanyCommentsKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: selectedClientId1,
            decoration: const InputDecoration(
              labelText: 'Client',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedClientId1 = newValue;
                clientName.text = selectedClientId1 ?? '';
              });
            },
            items: clientType.expand<DropdownMenuItem<String>>(
                (CompanyCommentEditDataModel dataModel) {
              return dataModel.company
                      ?.map<DropdownMenuItem<String>>((Company company) {
                    return DropdownMenuItem<String>(
                      value: company.id ?? '',
                      child: Text('${company.text}'),
                    );
                  }).toList() ??
                  [];
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a client';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
         TextFormField(
            controller: title,
            decoration: const InputDecoration(
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter title';
              }
              return null;
            },
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: data,
            decoration: const InputDecoration(
              labelText: 'Data',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter data';
              }
              return null;
            },
         ),
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              minimumSize: Size.fromHeight(60),
              backgroundColor: Colors.blue, // Set the background color
             
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Set the border radius
              ),
              shadowColor: Colors.black, // Set the shadow color
            ),
            onPressed: () {
              if (_EditCompanyCommentsKey.currentState!.validate()) {
                clientEdit();
              }
            },
            child: Text(
              "Update",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.2,
          ),
        ],
      ),
    );
  }
}

// Table heading

