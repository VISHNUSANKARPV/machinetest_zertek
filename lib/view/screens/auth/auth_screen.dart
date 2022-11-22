import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/view/screens/auth/enter_number_screen.dart';
import 'package:zartek_machine/view/screens/home/home_screen.dart';
import 'package:zartek_machine/view_model/auth_view_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/firebase.png",
                width: 350.w,
              ),
              SizedBox(
                height: 90.h,
              ),
              InkWell(
                onTap: () {
                  value.signWithGoogle().whenComplete(() {
                    if (value.userCredential != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    }
                  });
                },
                child: SizedBox(
                  height: 65.h,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          Image.asset("assets/google (1).png"),
                          SizedBox(
                            width: 50.w,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>const NumberEnterScreen()));
                },
                child: SizedBox(
                  height: 65.h,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 30.sp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 65.w,
                          ),
                          Text(
                            "Phone",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
