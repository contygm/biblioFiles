import 'package:flutter/material.dart';
import '../models/library.dart';
import '../styles.dart';

class LibraryDropdown extends StatelessWidget {
  LibraryDropdown({
      this.selectedLibrary,
      this.onChanged,
      this.finalLibraries,
      this.viewAction,
      this.includeDelete = false,
      this.isGreen = false,
      this.includeView = true,
      this.includeTitle = true,
      this.padding,
      this.deleteAction,
      this.formKey,
      this.deleteColor,
      this.viewColor,
    });

  final Library selectedLibrary;
  final Function onChanged;
  final List<Library> finalLibraries;
  final Function viewAction;
  final bool includeDelete;
  final bool includeView;
  final bool includeTitle;
  final bool isGreen;
  final double padding;
  final Function deleteAction;
  final Color viewColor;
  final Color deleteColor;
  
  final formKey;

  Widget viewButton(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.white,
      minWidth: (MediaQuery.of(context).size.width * 0.25),
      height: (MediaQuery.of(context).size.width * 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: RaisedButton(
        elevation: 3,
        onPressed: viewAction,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.visibility, color: viewColor),
            ),
            Text('View', style: (viewColor == Styles.green) ? 
              Styles.smallGreenButtonLabel : Styles.smallDarkGreenButtonLabel),
          ],
        )
      ),
    );
  }

  Widget actionButtons(BuildContext context) {
    if (includeDelete) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          viewButton(context),
          ButtonTheme(
            buttonColor: Colors.white,
            minWidth: (MediaQuery.of(context).size.width * 0.25),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
              onPressed: deleteAction,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.delete, color: deleteColor),
                  ),
                  Text('Delete', style: (viewColor == Styles.green) ? 
                    Styles.smallGreenButtonLabel : Styles.smallDarkGreenButtonLabel),
                ],
              )
            )
          )
          
        ]
      );
    } 

    if(includeView) {
      return viewButton(context);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    Color color = isGreen ? Styles.green : Styles.darkGrey;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: includeTitle,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Select a library: ', style: Styles.header2Style),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding ?? 20.0),
            child: DropdownButtonFormField<Library>(
              validator: (value) => value == null ? 
                'Please select a libary to view.' : null,
              iconEnabledColor: color,
              decoration: InputDecoration(
                labelText: 'Select a Library',
                labelStyle: TextStyle(color: color),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: color
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: color
                    )
                  )
              ),
              value: selectedLibrary,
              onChanged: onChanged,
              items: finalLibraries
                .map((item) => DropdownMenuItem<Library>(
                      child: Text(item.libraryName),
                      value: item,
                    ))
                .toList()
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: actionButtons(context),
          ),
        ],
      ),
    );
  }
}
