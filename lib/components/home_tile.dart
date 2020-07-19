import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    Key key, 
    this.title, 
    this.icon, 
    this.routeName
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed( routeName ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon, 
            size: 100, 
            color: Colors.green
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15 ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
          )
        ],
      ),
    );
  }
}