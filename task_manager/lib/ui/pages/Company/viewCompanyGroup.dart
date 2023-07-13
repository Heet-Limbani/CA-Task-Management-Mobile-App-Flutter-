import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/companyGroupEditDataModel.dart';
import 'package:task_manager/API/model/genModel.dart';
import '../DashBoard/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class ViewCompanyGroup extends StatefulWidget {
  final String id;
  const ViewCompanyGroup({required this.id, Key? key}) : super(key: key);

  @override
  State<ViewCompanyGroup> createState() => _ViewCompanyGroupState();
}

late double deviceWidth;
late double deviceHeight;

TextEditingController groupNameController = TextEditingController();
TextEditingController messageController = TextEditingController();
TextEditingController intervalController = TextEditingController();
TextEditingController startingDate = TextEditingController();

String id = "";

String? selectedClientId1;

class _ViewCompanyGroupState extends State<ViewCompanyGroup> {
  bool isObscurePassword = true;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    getUser();
  }

  List<CompanyGroupEditDataModel> clientType = [];
  CompanyGroupEditDataModel? selected;

  void getUser() async {
    print("id :- $id");
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.manageCompanyGroup}',
      params: {
        'id': id.toString(),
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      final companyData = CompanyGroupEditDataModel.fromJson(data);
      clientType.add(CompanyGroupEditDataModel.fromJson(data));
      selected = CompanyGroupEditDataModel.fromJson(data);
      

      //clientName.text = companyData.company!.name.toString();
      groupNameController.text = companyData.group!.name.toString();
      messageController.text = companyData.group!.message.toString();

      String intervalValue = '';
      if (clientType[0].group!.timeInterval.toString() == "0") {
        intervalValue = "Week";
      } else if (clientType[0].group!.timeInterval.toString() == "1") {
        intervalValue = "Half - Month";
      } else if (clientType[0].group!.timeInterval.toString() == "2") {
        intervalValue = "Month";
      } else if (clientType[0].group!.timeInterval.toString() == "3") {
        intervalValue = "Quarter";
      } else if (clientType[0].group!.timeInterval.toString() == "4") {
        intervalValue = "Half - Year";
      } else if (clientType[0].group!.timeInterval.toString() == "5") {
        intervalValue = "Year";
      }
      intervalController.text = intervalValue;

      startingDate.text = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(clientType[0].group!.startDate!) * 1000),
      );

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
          "Group Details",
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
        buildTextField1("Group Name", groupNameController.text, false),
        buildTextField1("Message", messageController.text, false),
        buildTextField1("Interval", intervalController.text, false),
        buildTextField1("Starting Date", startingDate.text, false),
      ],
    );
  }

  Row _header() {
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

 Column _table() {
  return Column(
    children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            DataTable(
              columns: const [
                DataColumn(label: Text('Sr. No.'), numeric: true),
                DataColumn(label: Text('Name')),
              ],
              rows: (selected?.selected ?? []).map((selectedd) {
                final index = selected?.selected?.indexOf(selectedd) ?? -1;
                final srNo = (index + 1).toString();
                final title = selectedd.name ?? '';

                return DataRow(cells: [
                  DataCell(Text(srNo)),
                  DataCell(Text(title)),
                ]);
              }).toList(),
              dataRowHeight: 32.0,
            ),
          ],
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
