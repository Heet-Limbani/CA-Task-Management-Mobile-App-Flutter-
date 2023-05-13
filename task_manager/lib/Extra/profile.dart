import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/pages/Profile/Pages/edit_description.dart';
import 'package:task_manager/ui/pages/Profile/Pages/edit_email.dart';
import 'package:task_manager/ui/pages/Profile/Pages/edit_image.dart';
import 'package:task_manager/ui/pages/Profile/Pages/edit_name.dart';
import 'package:task_manager/ui/pages/Profile/Pages/edit_phone.dart';
import 'package:task_manager/ui/pages/Profile/user/user.dart';
import 'package:task_manager/ui/pages/Profile/widgets/display_image_widget.dart';
import 'package:task_manager/ui/pages/DashBoard/sidebar.dart';

import '../ui/widgets/circle_gradient_icon.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
              icon: Icons.person,
              color: Colors.purple,
              iconSize: 24,
              size: 40,
            ),
          )
        ],
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
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
                  height: 20,
                ),
                _settingHeader(),
                const SizedBox(
                  height: 35,
                ),
                _infoHeader(),
                const SizedBox(
                  height: 35,
                ),
                // _image(),
                // const SizedBox(
                //   height: 35,
                // ),
                _form(),
                // buildGrid(),
                // const SizedBox(
                //   height: 50,
                // ),
                // _onGoingHeader(),
                // const SizedBox(
                //   height: 10,
                // ),
                // const OnGoingTask(),
                // const SizedBox(
                //   height: 40,
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
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

  Row _settingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 1,
        ),
        const Icon(
          Icons.settings,
          size: 40,
        ),
        SelectableText(
          "Settings",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
          // ignore: deprecated_member_use
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        TextButton(
          child: const Text(
            "Change Password",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          onPressed: () {},
          // icon: Icon(
          //   Icons.settings,
          //   color: Colors.blue[400],
          //   size: 50,
          // ))
        )
      ],
    );
  }

  Row _infoHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          width: 1,
        ),
        // const Icon(
        //   Icons.settings,
        //   size: 40,
        // ),
        SelectableText(
          "Your Informaton",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
          // ignore: deprecated_member_use
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        // TextButton(
        //   child: const Text(
        //     "Change Password",
        //     style: TextStyle(
        //       color: Colors.blue,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 14,
        //     ),
        //   ),
        //   onPressed: () {},
        //   // icon: Icon(
        //   //   Icons.settings,
        //   //   color: Colors.blue[400],
        //   //   size: 50,
        //   // ))
        // )
      ],
    );
  }

  // Row _image() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         height: 115,
  //         width: 115,
  //         child: Stack(
  //           fit: StackFit.expand,
  //           children: [
  //             const CircleAvatar(
  //               backgroundImage: AssetImage("assets/images/heet.png"),
  //             ),
  //             Positioned(
  //               right: -1,
  //               bottom: 0,
  //               child: SizedBox(
  //                 height: 46,
  //                 width: 46,
  //                 child: FloatingActionButton(
  //                   onPressed: () {},
  //                   backgroundColor: Color.fromARGB(255, 23, 49, 128),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(50),
  //                     side: const BorderSide(color: Colors.white),
  //                   ),
  //                   child: const Icon(Icons.edit),
  //                   // child: SvgPicture.asset(
  //                   //   "assets/images/heet.png",
  //                   //   height: 20,
  //                   //   width: 20,
  //                   // ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  Row _form() {
    var user;
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children:  [
      Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          Expanded(
            child: buildAbout(user),
            flex: 4,
          )
      ],
    );
  }
   Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}



