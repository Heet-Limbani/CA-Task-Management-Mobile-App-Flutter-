import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/API/model/countDataModel.dart';
import 'package:task_manager/API/model/holidayDataModel.dart';
import 'package:task_manager/ui/Client/Sidebar/sidebarClient.dart';
import 'package:task_manager/ui/widgets/circle_gradient_icon.dart';
import 'package:task_manager/ui/widgets/task_group.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/API/model/clientLogDataModel.dart';
import '../../../API/model/genModel.dart';
import 'package:task_manager/API/model/birthDayDataModel.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({Key? key}) : super(key: key);

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  List<Client> clients = [];
  late double deviceWidth ;
  late double deviceHeight ;

  @override
  void initState() {
    super.initState();

    

    clientDashboard();
    birthDayTable();
    holidayTable();
    clientTable();
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              onTap: () {},
              icon: Icons.calendar_month,
              color: Colors.purple,
              iconSize: 24,
              size: 40,
            ),
          )
        ],
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SideBarClient(),
      extendBody: true,
      body: _buildBody(),
    );
  }
  
  

  CountData? dataCount;
  void clientDashboard() async {
   

    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
     
    );
    if (genmodel != null) {
      //print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataCount = CountData.fromJson(data);
        //print('data  ${dataCount?.count?.pendingCount}');

        setState(() {});
      }
    }
  }

  BirthDayList? dataBirthdayList;
  void birthDayTable() async {
   

    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.adminDashBoard}',
    
    );
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataBirthdayList = BirthDayList.fromJson(data);
        if (dataBirthdayList?.birthday != null) {
          // for (Birthday birthday in dataBirthdayList!.birthday!) {
          //   print('BirthDay ID: ${birthday.id}');
          // }
        }
        setState(() {});
      }
    }
  }

  HolidayList? dataHolidayList;
  void holidayTable() async {
   

    genModel? genmodel = await Urls.postApiCall(
       method: '${Urls.adminDashBoard}',
     
    );
    if (genmodel != null) {
      // print('Status: ${genmodel.message}');
      if (genmodel.status == true) {
        //print('Data: ${genmodel?.data}');

        final data = genmodel.data;
        dataHolidayList = HolidayList.fromJson(data);
        // if (dataHolidayList?.holiday != null) {
        //   for (Holiday holiday in dataHolidayList!.holiday!) {
        //     print('Holiday ID: ${holiday.title}');
        //   }
        // }
        setState(() {});
      }
    }
  }

  void clientTable() async {
   

    genModel? genmodel = await Urls.postApiCall(
      method: '${Urls.clientLog}',
     
    );

    if (genmodel != null && genmodel.status == true) {
      final data = genmodel.data;

      if (data != null && data is List) {
        clients = data.map((item) => Client.fromJson(item)).toList();
        // for (Client client in clients) {
        //   print('Client ID: ${client.id}');
        //   print('Client Name: ${client.client}');
        //   print('Message: ${client.message}');
        //   // Print other client properties as needed
        // }
        setState(() {
          // Update the UI state if necessary
        });
      }
    }
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
                //_admin(),

                _client(),

                //_employee(),
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
            children: const [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1.1,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.keyboard,
                  taskCount: 5,
                  taskGroup: "On Going Task",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.green,
                  isSmall: true,
                  icon: Icons.live_help_rounded,
                  taskCount: 2,
                  taskGroup: "Query Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.orange,
                  icon: Icons.pending_actions,
                  taskCount: 5,
                  taskGroup: "Inoice Raised",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1.2,
                child: TaskGroupContainer(
                  color: Colors.blue,
                  icon: Icons.attach_money,
                  taskCount: 10,
                  taskGroup: "Amount",
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: TaskGroupContainer(
                  color: Colors.purple,
                  icon: Icons.download,
                  taskCount: 5,
                  isSmall: true,
                  taskGroup: "Download",
                ),
              ),
            ])
      ],
    );
  }

 
}
