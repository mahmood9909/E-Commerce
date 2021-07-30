import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/widgets/dumb_widgts/app_bar/cutsom_app_bar.dart';
import 'package:ecommerce/widgets/dumb_widgts/cutome_input_field.dart';
import 'package:ecommerce/widgets/smart_widgts/products_list.dart';
import 'package:ecommerce/widgets/smart_widgts/search_details.dart';
import 'package:flutter/material.dart';

import '../error_widget.dart';
import '../loading_widget.dart';

class SearchTab extends StatefulWidget {
  SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          hasBackArrow: false,
          title: "Search",
          hasCartContainer: true,
          hasBackground: false,
        ),
        SearchDetails()
      ],
    );
  }
}
