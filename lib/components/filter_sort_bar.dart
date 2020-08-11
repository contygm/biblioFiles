import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles.dart';

class FilterSortBar extends StatelessWidget {
  
  FilterSortBar({
    this.filterChoices,
    this.filterOnSelected,
    this.sortDoubleTap,
    this.sortOnSelected,
    this.isAscending,
    this.libraryName
  });

  final List<String> filterChoices;
  final Function filterOnSelected;
  final Function sortDoubleTap;
  final Function sortOnSelected;
  final bool isAscending;
  final String libraryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Row(children: [
        Text(libraryName, style: Styles.header2DarkGreenStyle),
        Spacer(flex: 1),
        ButtonBar(children: [filterButton(), sortButton()])
      ]),
    );
  }

  Widget filterButton() {
    return PopupMenuButton(
      icon: FaIcon(FontAwesomeIcons.filter, color: Styles.darkGreen),
      onSelected: filterOnSelected,
      itemBuilder: (context) {
        return filterChoices.map<PopupMenuItem<String>>((value) {
          return PopupMenuItem(
            child: Text(value),
            value: value,
          );
        }).toList();
      }
    );
  }

  Widget sortButton() {
    var choices = <String>[
      'Author',
      'Dewey Decimal',
      'Pages',
      'Title',
      'Language'
    ];

    return GestureDetector(
      onDoubleTap: sortDoubleTap,
      child: PopupMenuButton(
        icon: isAscending
            ? FaIcon(FontAwesomeIcons.sortAlphaDown, color: Styles.darkGreen,)
            : FaIcon(FontAwesomeIcons.sortAlphaUp, color: Styles.darkGreen,),
        onSelected: sortOnSelected,
        itemBuilder: (context) {
          return choices.map<PopupMenuItem<String>>((value) {
            return PopupMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList();
        }
      ),
    );
  }
}