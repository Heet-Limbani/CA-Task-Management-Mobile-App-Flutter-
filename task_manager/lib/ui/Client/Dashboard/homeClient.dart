import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/ui/Client/ClientInvoice/clientInvoice.dart';
import 'package:task_manager/ui/Client/Dashboard/onGoingJobs.dart';
import 'package:task_manager/ui/Client/Dashboard/queryRaised.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';
import 'package:task_manager/ui/Client/ClientCompany/clientCompany.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/AdminDataModel/clientLogDataModel.dart';
import 'package:task_manager/ui/widgets/task_group2.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({Key? key}) : super(key: key);

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  int onGoingTask = 0;
  int queryRaised = 0;
  int invoiceRaised = 0;
  int clientCompany = 0;
  List<Client> clients = [];
  late double deviceWidth;
  late double deviceHeight;

  @override
  void initState() {
    super.initState();
    getCount();
  }

  int amount = 0;
  void getCount() async {
    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientDashboard}',
    );
    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;
      if (data != null && data is Map<String, dynamic>) {
        onGoingTask = data['pending_count'] ?? 0;
        queryRaised = data['query_raised'] ?? 0;
        invoiceRaised = data['invoiceRaised'] ?? 0;
        int invoiceDataAmount = int.parse(data['invoice_data_amount'] ?? '0');
        int paymentDataAmount = int.parse(data['payment_data_amount'] ?? '0');
        amount = invoiceDataAmount - paymentDataAmount;
        clientCompany = amount;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: SideBarClient(),
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
                  height: deviceHeight * 0.02,
                ),
                _client(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String client = "";

  String message = "";

  String description = "";

  var measure;

  String Function(DateTime date) date = DateFormat('dd/MM/yyyy').format;

  Column _client() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Client Dashboard",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.05,
        ),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: InkWell(
                onTap: () {
                  if ((onGoingTask) != 0) {
                    Get.to(OnGoingTask());
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.work_history_outlined,
                  taskCount: onGoingTask,
                  taskGroup: "On Going Jobs",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: InkWell(
                onTap: () {
                  if ((queryRaised) != 0) {
                    Get.to(QueryRaised());
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.green,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: queryRaised,
                  taskGroup: "Query Raised",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: InkWell(
                onTap: () {
                  if ((invoiceRaised) != 0) {
                    Get.to(ClientInvoice());
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer(
                  color: Colors.orange,
                  icon: Icons.pending_actions,
                  taskCount: invoiceRaised,
                  taskGroup: "Inoice Raised",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.2,
              child: InkWell(
                onTap: () {
                  if ((clientCompany) != 0) {
                    Get.to(ClientCompany());
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: TaskGroupContainer2(
                  color: Colors.blue,
                  icon: Icons.attach_money,
                  taskCount: amount,
                  taskGroup: "Amount",
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
