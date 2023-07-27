import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/genModel.dart';
import 'package:task_manager/API/model/logModel.dart';
import 'package:task_manager/ui/core/res/color.dart';
import '../sidebar/sidebarAdmin.dart';

class EditLogClient extends StatefulWidget {
  final String logId;
  const EditLogClient({required this.logId, Key? key}) : super(key: key);
  @override
  State<EditLogClient> createState() => _EditLogClientState();
}

final GlobalKey<FormState> _formKey = GlobalKey();
String logId = "";
late double deviceWidth;
late double deviceHeight;
TextEditingController messageController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();
String clientId = "";
String message = "";
String description = "";
String date = '';
DateTime? selectedDateTime = DateTime.now();

class _EditLogClientState extends State<EditLogClient> {
  @override
  void initState() {
    super.initState();
    logId = widget.logId;
    getUser();
  }

  void clear() {
    messageController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  List<Log> log = [];
  void getUser() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientViewLogDetailsEdit}',
      params: {
        'id': logId,
      },
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is Map<String, dynamic>) {
        print("logId2 :- $logId");
        log.add(Log.fromJson(data));
        messageController.text = log[0].message.toString();
        descriptionController.text = log[0].description.toString();

        dateController.text = DateFormat('yyyy-MM-dd').format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(log[0].onDate!) * 1000),
        );
        // birthDateController.text = clientType[0].birthdate.toString();

        // if (log.isEmpty) {
        //   // List is empty
        //   print("No client data available.");
        // } else {
        //   // List has values
        //   print("Client data available.");
        // }
        // for (Log clientdata1 in log) {
        //   print('UserName: ${clientdata1.client}');
        // }

        setState(() {});
      }
    }
  }

  void clientLogAdd() async {
    try {
      if (selectedDateTime == null) {
        selectedDateTime = DateTime.now();
      }
      genModel? genmodel = await Urls.postApiCall(
        method: '${Urls.clientViewLogDetailsEdit}',
        params: {
          'message': message,
          'id': logId,
          'description': description,
          'date': selectedDateTime.toString(),
          'save': "save"
        },
      );
      if (genmodel != null) {
        if (genmodel.status == true) {
          setState(() {
            clientId = '';
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Users > Client > View Client > Log > Edit Log",
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
                  height: deviceHeight * 0.01,
                ),
                _form(),
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

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Edit Log ",
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

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // DropdownButtonFormField<String>(
          //   value: selectedClientId1,
          //   decoration: const InputDecoration(
          //     labelText: 'Client',
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //       borderSide: BorderSide(color: Colors.grey, width: 0.0),
          //     ),
          //     border: OutlineInputBorder(),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedClientId1 = newValue;
          //       clientController.text = selectedClientId1 ?? '';
          //     });
          //   },
          //   items: clientType.map((GetUser user) {
          //     return DropdownMenuItem<String>(
          //       value: user.iD ?? '',
          //       child: Text(user.username ?? ''),
          //     );
          //   }).toList(),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please select a client';
          //     }
          //     return null;
          //   },
          // ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          TextFormField(
            controller: messageController,
            decoration: const InputDecoration(
                labelText: 'Message',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Last Name must contain at least 3 characters';
              } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Last Name cannot contain special characters';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                message = value;
                // lastNameList.add(lastName);
              });
            },
            onChanged: (value) {
              setState(() {
                message = value;
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
                labelText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Description must contain at least 3 characters';
              } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Description cannot contain special characters';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                description = value;
                // bodyTempList.add(bodyTemp);
              });
            },
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          TextFormField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Date',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDateTime ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                  );
                  date = DateFormat('yyyy-MM-dd').format(selectedDateTime!);
                  dateController.text = date;
                });
              }
            },
            onFieldSubmitted: (value) {
              setState(() {
                selectedDateTime = DateTime.tryParse(value);
              });
            },
            onChanged: (value) {
              setState(() {
                selectedDateTime = DateTime.tryParse(value);
              });
            },
          ),
          SizedBox(height: deviceHeight * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();

                clientLogAdd();

                Fluttertoast.showToast(
                  msg: "Client Log Added Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }

              clear();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
