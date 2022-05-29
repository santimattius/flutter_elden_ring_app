import 'package:flutter/material.dart';

import '../../features/home/nav_drawer.dart';

abstract class BaseListPage extends StatelessWidget {
  final String currentPage;

  const BaseListPage({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title()),
        ),
        body: body(context),
        drawer: NavDrawer(
          selected: currentPage,
        ),
      ),
    );
  }

  String title();

  Widget body(BuildContext context);
}
