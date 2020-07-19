import 'package:flutter/material.dart';
import '../components/base_appbar.dart';
import '../components/base_drawer.dart';

class DefaultTemplate extends StatelessWidget {
  final Widget content;
  DefaultTemplate({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: BaseDrawer(),
      appBar: BaseAppBar(appBar: AppBar()),
      body: SafeArea(
        child: Center(
          child: content
        ),
      )
    );
  }
}