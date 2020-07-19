import 'package:flutter/material.dart';
import '../components/base_appbar.dart';
import '../components/base_drawer.dart';

class DefaultTemplate extends StatelessWidget {
  final Widget content;
  final Widget floatingAction;
  final FloatingActionButtonLocation floatingActionLocation;

  DefaultTemplate({
    Key key, 
    this.content, 
    this.floatingAction,
    this.floatingActionLocation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: BaseDrawer(),
      floatingActionButton: floatingAction,
      floatingActionButtonLocation: floatingActionLocation,
      appBar: BaseAppBar(appBar: AppBar()),
      body: SafeArea(
        child: Center(
          child: content
        ),
      )
    );
  }
}