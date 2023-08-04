import 'package:flutter/material.dart';
import 'package:task_manager/API/Admin%20DataModel/companyDataModel2.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/ui/Admin/Company/companyFile.dart';
import 'package:task_manager/ui/Admin/Company/companyLog.dart';
import 'package:task_manager/ui/Admin/Company/companyPermission.dart';
import 'package:task_manager/ui/Admin/Company/companyTicket.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ViewCompany extends StatefulWidget {
  final String id;
  const ViewCompany({required this.id, Key? key}) : super(key: key);

  @override
  State<ViewCompany> createState() => _ViewCompanyState();
}

late double deviceWidth;
late double deviceHeight;

TextEditingController companyNameController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController gstNumberController = TextEditingController();

String id = "";

String? selectedClientId1;

class _ViewCompanyState extends State<ViewCompany> {
  bool isObscurePassword = true;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    getUser();
  }

  List<CompanyDataModel2> clientType = [];
  void getUser() async {
    print("id :- $id");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.editCompany}',
      params: {
        'id': id.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final companyData = CompanyDataModel2.fromJson(data);

      //clientName.text = companyData.company!.name.toString();
      companyNameController.text = companyData.company!.name.toString();
      clientNameController.text =
          companyData.company!.proprietorName.toString();
      gstNumberController.text = companyData.company!.gstno.toString();
      mobileNumberController.text = companyData.company!.mobile.toString();
      emailController.text = companyData.company!.email.toString();

      selectedClientId1 = companyData.company!.clientId.toString();
      clientType.add(companyData); // Add the companyData to clientType list

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard > Pending Tasks > View Pending Task",
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
                  height: deviceHeight * 0.05,
                ),
                _header1(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _detail1(),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _header(),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                _table(),
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _header1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Company Details",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        const Spacer(),
      ],
    );
  }

  Column _detail1() {
    return Column(
      children: [
        buildTextField1("Company Name", companyNameController.text, false),
        buildTextField1("Client Name", clientNameController.text, false),
        buildTextField1("Mobile", mobileNumberController.text, false),
        buildTextField1("Email", emailController.text, false),
        buildTextField1("GST No.", gstNumberController.text, false),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Details",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        const Spacer(),
      ],
    );
  }

  Row _table() {
    return Row(
      children: [
        SizedBox(
          width: deviceWidth * 0.02,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyLog(id: id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Log',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add more buttons for additional tables
        SizedBox(
          width: deviceWidth * 0.02,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyTicket(id: id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Ticket',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.02,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyPermission(id: id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'Permission',
            style: TextStyle(color: Colors.black),
          ),
        ),
         SizedBox(
          width: deviceWidth * 0.02,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyFile(id: id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
          child: Text(
            'File',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField1(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )),
      ),
    );
  }
}
