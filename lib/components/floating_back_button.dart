import 'package:flutter/material.dart';

class FloatingBackButton extends StatelessWidget {
  final BuildContext pageContext;

  FloatingBackButton(this.pageContext);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(pageContext).pop(),
      child: Icon(Icons.arrow_back),
    );
  }
}