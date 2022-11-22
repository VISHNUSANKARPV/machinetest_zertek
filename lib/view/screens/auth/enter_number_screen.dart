import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/view_model/otp_provider.dart';



class NumberEnterScreen extends StatelessWidget {
  const NumberEnterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.r),
            child: Column(
              children: [
                 SizedBox(
                  height: 375.h,
                  width: 300.w,
                  child:
                      Image.asset("assets/login-registration-removebg-preview.png"),
                ),
                SizedBox(height: 20.h,),
                
                const Text(
                  "Registration",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.r),
                  child:  Text(
                    "Add your phone number. we'll send you a verification code \n so we know you're real",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Consumer<OtpController>(
                        builder: (_, otpProvider, __) => Column(
                          children: [
                            Form(
                              key: otpProvider.formkey,
                              child: TextFormField(
                                validator: (value) => otpProvider.formValidation(value),
                                keyboardType: TextInputType.phone,
                                controller:
                                    context.read<OtpController>().phoneController,
                                decoration: const InputDecoration(
                                    prefix: Text(
                                      '+91 ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    hintText: "Enter phone number here",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed:  () {
                                  otpProvider.verifyNumber(context);      
                                } ,
                                child: otpProvider.isLoading 
                                ? const Center(child: CircularProgressIndicator(color: Colors.amber,),)
                                :const Text(
                                  "Send",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
