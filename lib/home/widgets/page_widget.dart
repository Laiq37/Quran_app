import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  int? checkIndex;
  final List<Widget> tabsPage;
  PageWidget({this.checkIndex, required this.tabsPage, super.key});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
            children: tabsPage
          );
  }
}
