import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plant_shoap_app/controller/controller.dart';
import 'package:plant_shoap_app/utils/color_category.dart';
import 'package:plant_shoap_app/utils/constant.dart';
import 'package:plant_shoap_app/utils/constantWidget.dart';
import 'package:plant_shoap_app/view/sign_up/verification_success_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationScareenController verificationScareenController =
      Get.put(VerificationScareenController());
  final otpkey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  String? otp;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgColor,
          body: SafeArea(
              child: Column(
            children: [
              Container(
                color: bgColor,
                child: getAppBar(
                  "",
                  function: () {
                    Get.back();
                  },
                ),
              ),
              getVerSpace(40.h),
              getCustomFont("Verification", 28.sp, regularBlack, 1,fontWeight: FontWeight.w700),
              getVerSpace(30.h),
              getOTPfield(otpkey),
              getVerSpace(50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: getCustomButton(
                  "Verify",
                  () {
                    if (otpkey.currentState!.validate()) {
                      Get.to(VerificationSuccessScreen());
                    }
                  },
                ),
              ),
              getVerSpace(40.h),
              getRichtext("Didn’t recieve code? ", "Resend")
            ],
          )),
        ),
      ),
    );
  }
}
