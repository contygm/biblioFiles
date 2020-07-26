import 'dart:ffi';

import 'package:flutter/material.dart';
import '../templates/default_template.dart';
import '../db/databaseops.dart';
import '../models/library.dart';

class LibrariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new LoadLibrary());
  }
}

class LoadLibrary extends StatefulWidget {
  @override
  _LoadLibraryState createState() => _LoadLibraryState();
}

class _LoadLibraryState extends State<LoadLibrary> {
  @override
  void initState() {
    super.initState();
    getLibraries();
  }

  List<dynamic> finalLibraries;

  void getLibraries() async {
    List<dynamic> libraries = await callGetLibraries();
    setState(() {
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        child: (ListView.builder(
            itemCount: finalLibraries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(child: 
              Text('Library: ${finalLibraries[index].name}'));
            })));
  }
}
