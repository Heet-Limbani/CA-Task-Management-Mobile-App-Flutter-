import 'package:flutter/material.dart';
import '../DashBoard/sidebarAdmin.dart';

class profile1 extends StatefulWidget {
  @override
  _profile1State createState() => _profile1State();
}

class _profile1State extends State<profile1> {
  bool isObscurePassword = true;
  bool receiveSms = false;
  bool receiveEmail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu > Profile",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/heet.png",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              buildTextField("User Name", "Admin", false),
              buildTextField("E-mail", "heetlimbani999@gmail.com", false),
              buildTextField("Contact Number", "+91 9427967456", false),
              buildTextField("First Name", "Heet", false),
              buildTextField("Last Name", "Limbani", false),
              buildTextField("Password", "********", true),
              buildTextField("About Me", "Flutter developer", false),
              SizedBox(
                height: 10,
              ),
              buildCheckboxTile("Enable Email Notification", receiveSms,
                  (value) {
                setState(() {
                  receiveSms = value;
                });
              }),
              buildCheckboxTile("Enable SMS Notification", receiveEmail,
                  (value) {
                setState(() {
                  receiveEmail = value;
                });
              }),
              SizedBox(
                height: 30,
              ),
              buildTextField("Session Time", "2500", false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Update Settings",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      drawer:  SideBarAdmin(),
      extendBody: true,
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
            labelStyle: TextStyle(fontSize: 16, ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }

  buildCheckboxTile(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: Checkbox(
        value: value,
        onChanged: (newValue) {
          onChanged(newValue ?? false);
        },
      ),
    );
  }
}
