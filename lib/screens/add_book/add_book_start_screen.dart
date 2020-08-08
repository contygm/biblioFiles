import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../db/databaseops.dart';
import '../../templates/default_template.dart';
import '../libraries/add_library_screen.dart';
import 'barcode_entry_screen.dart';
import 'isbn_entry_screen.dart';
import 'manual_book_entry_screen.dart';

class AddBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: AddBook());
  }
}

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: libraryCount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data > 0) {
            return Row(
              children: [
                Column(
                  children: [
                    Text('How do you want to add your Book?'),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarcodeEntryScreen()),
                          );
                        },
                        child: const Text('Scan Barcode'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IsbnEntryScreen()),
                          );
                        },
                        child: const Text('ISBN #'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManualBookEntryScreen(),
                            ),
                          );
                        },
                        child: const Text('Write Info'),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            return Column(
              children: [
                Text('You do not have any Libraries to add to.'),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddLibraryScreen(),
                      ),
                    );
                  },
                  child: const Text('Add Library'),
                ),
              ],
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<int> libraryCount() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    // get libraries from database
    var libraryObjects = await callGetLibraries(uid);

    // return count
    return libraryObjects.length;
  }
}
