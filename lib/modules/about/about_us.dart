import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
            ),
            SizedBox(
              height: 35.0.h,
            ),
            buildServiceItem(context, "", "name", "content", 1),
            buildServiceItem(context, "", "name", "content", 2),
            buildServiceItem(context, "", "name", "content", 3),
          ],
        ),
      ),
    );
  }

  Widget buildServiceItem(
    context,
    String image,
    String serviceName,
    String serviceContent,
    int index,
  ) =>
      Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: AppColors.primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceName,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              serviceContent,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
}
