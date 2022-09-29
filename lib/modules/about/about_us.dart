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
        title: Text(""),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.jpg",
            ),
            SizedBox(
              height: 35.0.h,
            ),
            buildServiceItem(context, "", "", "", 1)
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
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(
              20.0,
            ),
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
                Row(
                  children: [],
                ),
              ],
            ),
          ),
        ],
      );
}
