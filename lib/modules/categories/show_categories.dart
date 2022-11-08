import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/modules/categories/table_category.dart';

import 'make_pdf_categories.dart';

class ShowCategories extends StatelessWidget {
  const ShowCategories({super.key});

  _buildAppBar() {
    return AppBar(
      title: Text("Categories"),
      centerTitle: true,
      actions: [
        //open printer page
        IconButton(
          onPressed: () {
            Get.to(MakePdfCategories(), transition: Transition.zoom);
          },
          icon: const Icon(Icons.print_rounded),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        // _buildSearchBar(),
        SizedBox(height: 25.h),
        Expanded(child: TableCategory()),
      ],
    );
  }
}
