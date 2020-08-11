import 'package:flutter/material.dart';
import '../components/base_drawer.dart';
import '../styles.dart';

// NOTE: Guide for how to make templates: 
// -> https://medium.com/@SandeepGurram/creating-templates-in-flutter-43568073193b
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
      appBar: AppBar(
        title: Text('BiblioFiles', 
          style: Styles.appHeaderStyle
        ),
        backgroundColor: Styles.offWhite,
        iconTheme: IconThemeData(color: Styles.darkGreen)
      ),
      body: SafeArea(
        child: Center(
          child: content
        ),
      )
    );
  }
}