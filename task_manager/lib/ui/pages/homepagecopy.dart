import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/Theme/app_theme.dart';
import 'package:task_manager/ui/pages/sidebar.dart';
import 'package:task_manager/ui/core/res/color.dart';
import 'package:task_manager/ui/core/routes/routes.dart';
import 'package:task_manager/ui/widgets/circle_gradient_icon.dart';
import 'package:task_manager/ui/widgets/task_group.dart';

class HomeScreenCopy extends StatefulWidget {
  const HomeScreenCopy({Key? key}) : super(key: key);

  @override
  State<HomeScreenCopy> createState() => _HomeScreenCopyState();
}

class _HomeScreenCopyState extends State<HomeScreenCopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              onTap: () {
                Navigator.pushNamed(context, Routes.todaysTask);
              },
              icon: Icons.calendar_month,
              color: Colors.purple,
              iconSize: 24,
              size: 40,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      drawer: const SideBar(),
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
                const SizedBox(
                  height: 10,
                ),
                _taskHeader(),
                const SizedBox(
                  height: 15,
                ),
                buildGrid(),
                const SizedBox(
                  height: 25,
                ),
                _onGoingHeader(),
                const SizedBox(
                  height: 10,
                ),
                const OnGoingTask(),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 25,
                ),
                _logHeader(),
                const SizedBox(
                  height: 10,
                ),
                _log(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   // left: 100.w / 2 - (70 / 2),
        //   right: 30,
        //   child: CircleGradientIcon(
        //     color: Colors.pink,
        //     onTap: () {},
        //     size: 60,
        //     iconSize: 30,
        //     icon: Icons.add,
        //   ),
        // )
      ],
    );
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Task List",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "Dashboard",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.blue[400],
            ))
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: const [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1.1,
          child: TaskGroupContainer(
            color: Colors.purple,
            icon: Icons.today_rounded,
            taskCount: 5,
            taskGroup: "Today's Task",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: TaskGroupContainer(
            color: Colors.blue,
            icon: Icons.pending_actions,
            taskCount: 5,
            taskGroup: "Pending Task",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.orange,
            isSmall: true,
            icon: Icons.attach_money,
            taskCount: 10,
            taskGroup: "Tax Payable",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.2,
          child: TaskGroupContainer(
            color: Colors.red,
            icon: Icons.watch_later_outlined,
            taskCount: 5,
            taskGroup: "Overdue Task",
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
            color: Colors.pink,
            icon: Icons.keyboard,
            taskCount: 9,
            taskGroup: "On Board Task",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.05,
          child: TaskGroupContainer(
            color: Colors.blue,
            isSmall: true,
            icon: Icons.punch_clock,
            taskCount: 2,
            taskGroup: "UnAssign Work",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.orange,
            isSmall: true,
            icon: Icons.money_off_outlined,
            taskCount: 2,
            taskGroup: "UnPaid Tax",
          ),
        ),
      ],
    );
  }

  Row _logHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Add Client Log",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        // InkWell(
        //   onTap: () {},
        //   child: Text(
        //     "See all",
        //     style: TextStyle(
        //       color: AppColors.primaryColor,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // )
      ],
    );
  }

  Column _log() {
    final GlobalKey<FormState> _formKey = GlobalKey();
    String client = "";
    String message = "";
    String description = "";
    var measure;

    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Client',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                onFieldSubmitted: (value) {
                  setState(() {
                    client = value;
                    // firstNameList.add(firstName);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    client = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'First Name must contain at least 3 characters';
                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                    return 'First Name cannot contain special characters';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  setState(() {
                    message = value;
                    // bodyTempList.add(bodyTemp);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InputDatePickerFormField(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now()),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60)),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    //_submit();
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnGoingTask extends StatelessWidget {
  const OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Development Of Task Management System",
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "09:30 AM - 06:30PM",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Complete - 10%",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.rocket_rounded,
            size: 60,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
