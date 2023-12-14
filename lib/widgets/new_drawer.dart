import 'package:flutter/material.dart';

import 'package:doal/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewDrawer extends StatelessWidget {
  const NewDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF555294),
              Color(0xFF3E3A6D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage("assets/images/my profile photo.png"),
                  ),
                  Text(
                    "Aman's Doal",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 10.0,
                endIndent: 10.0,
                color: Color(0xff29274F),
              ),
              Text(
                "Workspaces",
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1, color: Colors.white)),
                  elevation: MaterialStateProperty.all(0.0),
                  fixedSize: MaterialStateProperty.all(Size(260, 40)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.attachment_outlined),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1, color: Colors.white)),
                  elevation: MaterialStateProperty.all(0.0),
                  fixedSize: MaterialStateProperty.all(Size(260, 40)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.attachment_outlined),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Study",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1, color: Colors.white)),
                  elevation: MaterialStateProperty.all(0.0),
                  fixedSize: MaterialStateProperty.all(Size(260, 40)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.attachment_outlined),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "College",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1, color: Colors.white)),
                  elevation: MaterialStateProperty.all(0.0),
                  fixedSize: MaterialStateProperty.all(Size(260, 40)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Add workspace",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250.0,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 10.0,
                endIndent: 10.0,
                color: Color(0xff29274F),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => SignUpPage(
                                    email: '',
                                  )),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        )
                      ],
                    )),
              )
            ],
          )),
        ),
      ),
    );
    ;
  }
}
