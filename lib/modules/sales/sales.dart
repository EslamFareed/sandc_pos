import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  _buildAppBar() {
    return AppBar(
      title: Text("Sales"),
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.print_rounded))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildSearchBar() {
    return Container(
      width: Get.width,
      height: 50.h,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (txt) => print(txt),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  border: InputBorder.none,
                  // suffixIcon: const Icon(
                  //   Icons.search,
                  //   color: Colors.grey,
                  // ),
                  hintText: "Search Product",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  _buildBody() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSearchBar(),
          ],
        ),
      ),
    );
  }
}
