import 'package:flutter/material.dart';
import '../styles.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    Key key, 
    this.title, 
    this.icon, 
    this.routeName,
    this.themeColor
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String routeName;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed( routeName ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.3,
          child: Card(
            color: themeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: themeColor, width: 5.0)
            ),
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: Styles.homeTileStyle
                ),
                Icon(
                  icon, 
                  size: 40, 
                  color: Styles.offWhite
                ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}