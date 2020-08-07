import 'package:flutter/material.dart';
import '../../models/bookLibrary.dart';
import '../../templates/default_template.dart';
import 'checkout_form.dart';

class RegularBookScreen extends StatefulWidget {
  final BookLibrary bookLibrary;
  RegularBookScreen(this.bookLibrary);

  @override
  _RegularBookScreenState createState() => _RegularBookScreenState();
}

class _RegularBookScreenState extends State<RegularBookScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(image: NetworkImage(widget.bookLibrary.book.bookImg)),
            Text('Title: ${widget.bookLibrary.book.title}'),
            Text('Author: ${widget.bookLibrary.book.author}'),
            SwitchListTile(
              title: Text('Loanable'),
              value: widget.bookLibrary.loanable,
              onChanged: (value) {
                setState(() {
                   print('_loanable');
                  widget.bookLibrary.loanable = !widget.bookLibrary.loanable;
                });
              }
            ),
            RaisedButton(
              child: Text('Checkout'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CheckoutForm()
                  )
                );
              }
            ),
            RaisedButton(
              onPressed: () => 
                Navigator.of(context).pop(context),
              child: Text('Done')
            )
          ]
        ),
      ),
    );
  }
}