import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/API/Admin%20DataModel/companyListDataModel.dart';
import 'package:task_manager/API/Admin%20DataModel/genModel.dart';
import 'package:task_manager/ui/Theme/app_theme.dart';
import '../sidebar/sidebarAdmin.dart';
import 'package:task_manager/API/Urls.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  late double deviceWidth;
  late double deviceHeight;

  Map? dataResponse;

  final GlobalKey<FormState> _AddInvoiceKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController particular = TextEditingController();
  TextEditingController amount = TextEditingController();
  List<String> particulars = [];
  List<double> amounts = [];

  double? totalAmount;

  String? selectedClientId1;
  String? selectedLocationId1;

  @override
  void dispose() {
    particular.dispose();
    amount.dispose();
    companyName.dispose();
    totalAmount = 0;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void clearField() {
    particular.clear();
    amount.clear();
    companyName.clear();
    totalAmount = 0;
    amounts.clear();
    particulars.clear();
  }

  void addRow() {
    setState(() {
      particulars.add(particular.text);

      // Safely parse the user input for the amount
      try {
        amounts.add(double.parse(amount.text));
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Invalid Amount',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      particular.clear();
      amount.clear();
    });
  }

  double getTotalAmount() {
    // Use the reduce method to calculate the total amount
    return amounts.reduce((total, amount) => total + amount);
  }

  Widget buildRow(int index) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: particulars[index],
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value) => particulars[index] = value,
            decoration: InputDecoration(
              labelText: 'Particular',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Particular';
              }
              if (value.length < 3) {
                return 'Particular must be at least 3 characters long';
              }
              return null;
            },
          ),
        ),
        SizedBox(width: deviceWidth * 0.01),
        Expanded(
          child: TextFormField(
            initialValue: amounts[index].toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (value) => amounts[index] = double.parse(value),
            decoration: InputDecoration(
              labelText: 'Amount',
              suffixIcon: Icon(Icons.money),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Amount';
              }
              if (value.length < 3) {
                return 'Amount must be at least 3 characters long';
              }
              return null;
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              particulars.removeAt(index);
              amounts.removeAt(index);
            });
          },
          icon: Icon(Icons.delete),
        ),
        SizedBox(height: deviceHeight * 0.02),
      ],
    );
  }

  List<CompanyListDataModel> clientType = [];
  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.companyList}',
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      final fileData = CompanyListDataModel.fromJson(data);
      clientType.add(fileData); // Add the companyData to clientType list
      setState(() {});
    }
  }

  void fileEdit() async {
    try {
      String test = amounts.toString();
      print("amounts $test");
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.addInvoice}',
        params: {
          "btnSave": "Save",
          "Client": selectedClientId1.toString(),
          "extra_amount[]": amounts,
          "extra_particular[]": particulars,
          "amount": totalAmount.toString(),
          "particular": "Custom Generated Invoice",
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
          "Menu > File Manager > Add File",
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
                _AddInvoice(),
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
          "Add File",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Form _AddInvoice() {
    return Form(
      key: _AddInvoiceKey,
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
                companyName.text = selectedClientId1 ?? '';
              });
            },
            items: clientType.expand<DropdownMenuItem<String>>(
                (CompanyListDataModel dataModel) {
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
            controller: particular,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Particular',
              suffixIcon: Icon(Icons.file_present),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: amount,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Amount',
              suffixIcon: Icon(Icons.money),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.grey),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppTheme.colors.lightBlue),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,

                  backgroundColor: Colors.white, // Set the background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Set the border radius
                  ),
                  shadowColor: Colors.black, // Set the shadow color
                ),
                onPressed: () {
                  if (particular.text.isNotEmpty && amount.text.isNotEmpty) {
                    addRow();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please fill all the fields',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Text("Add", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          SizedBox(height: deviceHeight * 0.02),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: particulars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildRow(index),
                  SizedBox(
                      height: deviceHeight * 0.02
                  ), // Set the spacing you desire between items
                ],
              );
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
              if (((_AddInvoiceKey.currentState!.validate()) &&
                  (particulars.isNotEmpty && amounts.isNotEmpty))) {
                totalAmount = getTotalAmount();
                fileEdit();
                clearField();
              } else {
                Fluttertoast.showToast(
                  msg: 'Please Add Particular And Amount',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: Text(
              "Add File",
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
