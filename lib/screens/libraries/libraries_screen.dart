import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';

class LibraryArgs {
  final int id;
  final String name;

  LibraryArgs(this.id, this.name);
}

class LibrariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: LoadLibrary());
  }
}

class LoadLibrary extends StatefulWidget {
  @override
  _LoadLibraryState createState() => _LoadLibraryState();
}

class _LoadLibraryState extends State<LoadLibrary> {
  Library selectedLibrary;
  @override
  void initState() {
    super.initState();
    getLibraries();
  }

  List<Library> finalLibraries = [];
  bool lookLibrary = false;
  void getLibraries() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    var libraries = await callGetLibraries(uid);
    setState(() {
      lookLibrary = true;
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    if (lookLibrary == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      if (finalLibraries.isNotEmpty) {
        final formKey = GlobalKey<FormState>();

        return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [              
              LibraryDropdown(
                formKey: formKey,
                selectedLibrary: selectedLibrary,
                finalLibraries: finalLibraries,
                onChanged: (value) {
                  setState(() {
                    selectedLibrary = value;
                  });
                },
                viewColor: Styles.green,
                viewAction: () async {
                  if (formKey.currentState.validate()) {
                    Navigator.pushNamed(context, 'libraryBooks',
                    arguments: LibraryArgs(
                      selectedLibrary.id, selectedLibrary.name));
                  }
                },
                includeDelete: true,
                deleteColor: Colors.red,
                deleteAction: () async {
                  if (formKey.currentState.validate()) {
                    await callDeleteLibrary(selectedLibrary.id);
                    Navigator.pushNamed(context, 'libraries');
                  }
                }
              ),
              orComponent(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Create a Library: ', style: Styles.header2Style),
              ),
              createButton(
                context, 
                onPressed: () {
                  Navigator.pushNamed(context, 'addLibrary');
                }
              ),
            ],
          ),
        );
      }
      //otherwise print empty screen
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Create a Library: ', style: Styles.header2Style),
            ),
            createButton(
              context, 
              onPressed: () {
                lookLibrary = false;
                Navigator.pushNamed(context, 'addLibrary');
              }
            ),
          ],
        )
      );
    }
  }

   Widget createButton(BuildContext context, {Function onPressed}) {
    return ButtonTheme(
      buttonColor: Styles.yellow,
      minWidth: (MediaQuery.of(context).size.width * 0.4),
      height: (MediaQuery.of(context).size.width * 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: RaisedButton(
        elevation: 5,
        child: Text('New Library', style: Styles.bigButtonLabel),
        onPressed: onPressed
      ),
    );
  }

  Widget orComponent() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1.0,
              color: Styles.darkGrey,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.local_library, color: Styles.mediumGrey,),
          ),
          Expanded(
            child: Container(
              height: 1.0,
              color: Styles.darkGrey,
            ),
          ),
        ],
      ),
    );
}
}