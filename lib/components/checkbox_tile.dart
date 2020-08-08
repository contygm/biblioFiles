import 'package:flutter/material.dart';

class CheckboxTile extends StatelessWidget {
  
  CheckboxTile({
    this.title,
    this.author,
    this.value,
    this.onChanged,
    this.detailText
  });

  final String title;
  final String author;
  final bool value;
  final Function onChanged;
  final Widget detailText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, overflow: TextOverflow.ellipsis),
                  Text(author),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Center(
                child: detailText
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}