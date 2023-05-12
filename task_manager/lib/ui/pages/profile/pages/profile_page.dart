import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/pages/profile/pages/edit_description.dart';
import 'package:task_manager/ui/pages/profile/pages/edit_email.dart';
import 'package:task_manager/ui/pages/profile/pages/edit_image.dart';
import 'package:task_manager/ui/pages/profile/pages/edit_name.dart';
import 'package:task_manager/ui/pages/profile/pages/edit_phone.dart';
import '../../../widgets/circle_gradient_icon.dart';
import '../../sidebar.dart';
import '../user/user.dart';
import '../widgets/display_image_widget.dart';
import '../user/user_data.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      
      body: Column(
        children: [
          AppBar(
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
      Row(
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
      ),
      const SizedBox(
        height: 40,
      ),
          // const Center(
          //     child: Padding(
          //         padding: EdgeInsets.only(bottom: 20),
          //         child: Text(
          //           'Edit Profile',
          //           style: TextStyle(
          //             fontSize: 30,
          //             fontWeight: FontWeight.w700,
          //             color: Color.fromRGBO(64, 105, 225, 1),
          //           ),
          //         )),
                  
          //         ),
                   
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(user.name, 'UserName', EditNameFormPage()),
           buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          buildUserInfoDisplay(user.phone, 'Contact', EditPhoneFormPage()),
         
          Expanded(
            child: buildAbout(user),
            flex: 4,
          )
        ],
      ),
      drawer: const SideBar(),
      extendBody: true,
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
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
            'About Me',
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
