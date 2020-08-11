import 'package:flutter/material.dart';
import '../models/bookLibrary.dart';
import '../models/book.dart';
import '../screens/single_book/single_book_screen.dart';
import '../styles.dart';

class BookGrid extends StatelessWidget {
  final Axis scrollDirection;
  final int bookCount;
  final int crossAxisCount;
  final String title;
  final Widget titleWidget;
  final List<BookLibrary> bookLibrary;
  final String sortParam;

  BookGrid(
      {this.bookLibrary,
      this.crossAxisCount = 5,
      this.titleWidget,
      this.title,
      this.sortParam,
      @required this.bookCount,
      @required this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleWidget ?? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: Styles.header2DarkGreenStyle
          ),
        ),
        Expanded(child: cardGrid(context, bookLibrary)),
      ],
    );
  }

  Widget cardGrid(BuildContext context, List<BookLibrary> bookLibrary) {
    return GridView.builder(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        itemCount: bookCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemBuilder: (context, index) {
          return bookCard(context, bookLibrary[index]);
        });
  }

  Widget bookCard(BuildContext context, BookLibrary bookLibrary) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
        .pushNamed(SingleBookScreen.routeName, arguments: bookLibrary);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: bookLibrary.loanable ? Colors.white : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: (bookLibrary.book.bookImg.length > 1 ? 
                    Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(bookLibrary.book.bookImg),
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width * 0.5,
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Container(
                        color: Styles.darkGreen,
                        child: Icon(Icons.import_contacts, 
                          color: Styles.offWhite, 
                          size: MediaQuery.of(context).size.width * 0.2),
                      ),
                    )),
                ),
                Visibility(
                  visible: (sortParam != null && sortParam != 'Title' && sortParam != 'Author'), 
                  child: sortParams(context, bookLibrary.book)
                )
                ],
              ),
              bookInfo(bookLibrary),
            ],
          ),
        ),
      ),
    );
  }

  Widget sortParams(BuildContext context, Book book) {
    var sortValue = getValueFromSortParam(book);
    return Positioned(
      child: Align(
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.lightGreen,
              boxShadow: [BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0
              )]
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('$sortValue',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Styles.offWhite)),
            )
          ),
        )
      )
    );
  }

  Widget bookInfo(BookLibrary bookLibrary) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bookLibrary.book.bookTitle, 
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bookTileTitle,
                ),
                Text(bookLibrary.book.author, 
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bookTileAuthor,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Center(
            child: bookLibrary.checkedout ? 
            Container(
              // height: 50,
              child: Align(alignment: FractionalOffset.bottomCenter,
                child: Text('OUT', style: Styles.smallerRedButtonLabel)),
            )
            : Container()
          ),
        ),
      ],
    );
  }

  dynamic getValueFromSortParam(Book book) {
    dynamic value;
    switch (sortParam) {
      case 'Dewey Decimal':
        value = book.dewey ?? '-';
        break;
      case 'Pages':
        value = (book.pages == null || book.pages == 0) ? '-' : book.pages;
        break;
      case 'Title':
        value = book.title ?? '-';
        break;
      case 'Language':
        value = book.lang ?? '-';
        break;
      default:
        value = book.author ?? '-';
    }

    return value;
  }
}
