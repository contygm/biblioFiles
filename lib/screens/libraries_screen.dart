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

  List<dynamic> finalLibraries = [];
  String userId = '19';
  void getLibraries() async {
    List<dynamic> libraries = await callGetLibraries(userId);
    setState(() {
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    if (finalLibraries.isNotEmpty) {
      return Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Create Library'),
              onPressed: () {
                Navigator.pushNamed(context, 'addLibrary');
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: finalLibraries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Library: ${finalLibraries[index].name}'),
                                  RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'libraryBooks',
                                            arguments: (int.parse(
                                                "${finalLibraries[index].libraryId}")));
                                      },
                                      child: Text('View')),
                                  RaisedButton(
                                      onPressed: () async {
                                        await callDeleteLibrary(int.parse(
                                            "${finalLibraries[index].libraryId}"));
                                        setState(() {});
                                      },
                                      child: Text('Delete'))
                                ])
                          ],
                        ),
                      );
                    })),
          ],
        ),
      );
    }
    //otherwise print empty screen
    return Container(
        child: Column(
      children: [
        RaisedButton(
            child: Text('Create Library'),
            onPressed: () {
              Navigator.pushNamed(context, 'addLibrary');
            })
      ],
    ));
  }
}
