import 'package:flutter/material.dart';

class FilterSortBar extends StatefulWidget {
  final String libraryName;
  FilterSortBar({Key key, this.libraryName}) : super(key: key);

  @override
  _FilterSortBarState createState() => _FilterSortBarState();
}

class _FilterSortBarState extends State<FilterSortBar> {
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Row(
        children: [
          Text(
            widget.libraryName, 
            style: TextStyle(fontSize: 25)
          ),
          Spacer(flex: 1),
          ButtonBar(
            children: [
            filterDropDown(),
            sortDropDown()
          ])
        ]
      ),
    );
  }

  Widget filterDropDown() {
    var choices = <String>[
      'All','Unloanable', 'Loanable', 'Checked Out', 'Checked In'
    ];

    return PopupMenuButton(
      icon: Icon(Icons.filter_list), 
      onSelected: print,
      itemBuilder: (context) {
        return choices.map<PopupMenuItem<String>>((value) {
            return PopupMenuItem (
              child: Text(value),
              value: value,
            );
          }
        ).toList();
      }
    );
  }

  Widget sortDropDown() {
    var choices = <String>[
      'Author', 'Dewey Decimal', 'Pages', 'Genre', 'Title', 'Language'
    ];
    
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isAscending = !_isAscending;
        });
      },
      child: PopupMenuButton(
        icon: _isAscending ? 
          Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward), 
        onSelected: print,
        itemBuilder: (context) {
          return choices.map<PopupMenuItem<String>>((value) {
              return PopupMenuItem (
                child: Text(value),
                value: value,
              );
            }
          ).toList();
        }
      ),
    );
  }
}