import 'package:flutter/material.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewDrawer extends StatelessWidget {
  const NewDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String displayName = user?.displayName ?? '';
    String? photoURL = user?.photoURL;
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
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
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(displayName),
              accountEmail: null, // You can use user.email here if needed
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    photoURL != null ? NetworkImage(photoURL) : null,
                child: photoURL == null ? Icon(Icons.person) : null,
              ),
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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignUpPage(
                                  email: '',
                                )),
                        (route) => false);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
