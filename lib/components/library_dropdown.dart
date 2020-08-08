import 'package:flutter/material.dart';
import '../models/library.dart';


class LibraryDropdown extends StatelessWidget {
  LibraryDropdown({
    this.selectedLibrary,
    this.onChanged,
    this.finalLibraries,
    this.viewAction,
    this.includeDelete = false,
    this.deleteAction
  });

  final Library selectedLibrary;
  final Function onChanged;
  final List<Library> finalLibraries;
  final Function viewAction;
  final bool includeDelete;
  final Function deleteAction;

  Widget actionButtons() {
    if (includeDelete) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: viewAction,
            child: Text('View')),
          RaisedButton(
            onPressed: deleteAction,
            child: Text('Delete'))
        ]
      );
    } 

    return RaisedButton(child: Text('View'), onPressed: viewAction);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField<Library>(
          decoration: InputDecoration(labelText: 'Select a Library'),
          value: selectedLibrary,
          onChanged: onChanged,
          items: finalLibraries
              .map((item) => DropdownMenuItem<Library>(
                    child: Text(item.libraryName),
                    value: item,
                  ))
              .toList()
        ),
        actionButtons(),
      ],
    );
  }
}