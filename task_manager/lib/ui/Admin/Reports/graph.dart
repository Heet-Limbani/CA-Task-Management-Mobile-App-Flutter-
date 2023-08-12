import 'package:flutter/material.dart';
import 'package:task_manager/API/AdminDataModel/genModel.dart';
import 'package:task_manager/API/Urls.dart';
import 'package:task_manager/ui/Admin/sidebar/sidebarAdmin.dart';


class Graph extends StatefulWidget {
  final String userId;
  const Graph({required this.userId, super.key});
  @override
  State<Graph> createState() => _GraphState();
}

String userId = "";
int complete = 0;
int month = 0;
int total = 0;

class _GraphState extends State<Graph> {
  late double deviceWidth;
  late double deviceHeight;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    //getUser();
    getCount();
    // Initialize _source here
  }


  void getCount() async {
  genModel? genmodel = await Urls.postApiCall(
    method: '${Urls.graph}',
    params: {
      'id': userId,
    },
  );
  if (genmodel != null && genmodel.status == true) {
    final data = genmodel.data;
    print("data :- $data");

  }
}

  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Reports > Performance Report > Graph",
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
                  height: deviceHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Table heading
  Row _header() {
    return Row(
      children: [
        Text(
          "Graph",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
