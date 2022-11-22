import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/view/screens/auth/auth_screen.dart';
import 'package:zartek_machine/view_model/auth_view_model.dart';

class Drawers extends StatelessWidget {
  const Drawers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Consumer<AuthViewModel>(
            builder: (context, value, child) => DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r))), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.green),
                accountName: Text(
                  value.userCredential!.user?.displayName ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(
                  value.userCredential!.user?.email ?? '',
                ),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 165, 255, 137),
                    child: Image.network(value.userCredential!.user?.photoURL ??
                        '')), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
          ), //DrawerHeader
          Consumer<AuthViewModel>(
            builder: (context, value, child) => ListTile(
              onTap: () {
                value.signOut().then((logout) {
                  if (logout) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()),
                        (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Can\'nt logout right now .')));
                  }
                });
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log out"),
            ),
          )
        ],
      ),
    );
  }
}