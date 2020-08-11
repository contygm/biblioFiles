import 'package:flutter/material.dart';
import '../../components/book_grid.dart';
import '../../components/filter_sort_bar.dart';
import '../../db/databaseops.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import 'libraries_screen.dart';

int libraryId;
String libraryname;

class LibraryBooksScreen extends StatelessWidget {
  Widget addBookBtn(BuildContext context) {
    return Container(
        height: 75.0,
        width: 75.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Styles.yellow,
              child: Icon(Icons.add, size: 30.0, color: Styles.offWhite),
              tooltip: 'Add a Book',
              onPressed: () => Navigator.of(context).pushNamed( 'addBook' ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    LibraryArgs librarydeets = ModalRoute.of(context).settings.arguments;
    libraryId = librarydeets.id;
    libraryname = librarydeets.name;
    return DefaultTemplate(
      content: LoadBooksLibrary(),
      floatingAction: addBookBtn(context),
      floatingActionLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class LoadBooksLibrary extends StatefulWidget {
  @override
  _LoadBooksLibraryState createState() => _LoadBooksLibraryState();
}

class _LoadBooksLibraryState extends State<LoadBooksLibrary> {
  @override
  void initState() {
    super.initState();
    getBooksinLibrary();
  }

  bool booksSearched = false;
  bool _isAscending = true;
  String sortParam = 'Author';
  List<dynamic> allBooks = [];
  List<dynamic> organizedBooks = [];
  void getBooksinLibrary() async {
    var books = await callGetLibraryBooks(libraryId);
    setState(() {
      booksSearched = true;
      allBooks = books;
      organizedBooks = books;
    });
  }

  Widget build(BuildContext context) {
    if (booksSearched == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      if (organizedBooks.isNotEmpty) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: BookGrid(
              bookLibrary: organizedBooks,
              crossAxisCount: 2,
              titleWidget: filterBar(context),
              bookCount: organizedBooks.length,
              scrollDirection: Axis.vertical
            ),
        );
      } else {
        //otherwise allow user to add book
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$libraryname is empty!', style: Styles.header2Style),
            ],
          )
        );
      }
    }
  }

  Widget filterBar(BuildContext context) {
    return FilterSortBar(
      filterChoices: [
        'All',
        'Unloanable',
        'Loanable',
        'Checked Out',
        'Checked In'
      ],
      filterOnSelected: (value) {
        setState(() {
          switch (value) {
            case 'Unloanable':
              organizedBooks = allBooks.where((b) => !b.loanable).toList();
              break;
            case 'Loanable':
              organizedBooks = allBooks.where((b) => b.loanable).toList();
              break;
            case 'Checked Out':
              organizedBooks = 
                allBooks.where((b) => b.checkedout).toList();
              break;
            case 'Checked In':
              organizedBooks = 
                allBooks.where((b) => !b.checkedout).toList();
              break;
            default:
              organizedBooks = allBooks;
          }
        });
      },
      sortDoubleTap: () {
        setState(() {
          _isAscending = !_isAscending;
          organizedBooks = organizedBooks.reversed.toList();
        });
      },
      sortOnSelected: (value) {
        setState(() {
          switch (value) {
            case 'Dewey Decimal':
              organizedBooks
                .sort((a, b) => a.book.dewey != null ? 
                  a.book.dewey.compareTo(b.book.dewey) : 
                  (b.book.dewey != null ? 1 : 0));
              break;
            case 'Pages':
              organizedBooks
                .sort((a, b) => a.book.pages != null ? 
                  a.book.pages.compareTo(b.book.pages) : 
                  (b.book.pages != null ? 1 : 0));
              break;
            case 'Title':
              organizedBooks
                .sort((a, b) => a.book.title != null ? 
                  a.book.title.compareTo(b.book.title) : 
                  (b.book.title != null ? 1 : 0));
              break;
            case 'Language':
              organizedBooks
                .sort((a, b) => a.book.lang != null ? 
                  a.book.bookLang.compareTo(b.book.bookLang) : 
                  (b.book.bookLang != null ? 1 : 0));
              break;
            default:
              organizedBooks
                .sort((a, b) => a.book.author != null ? 
                  a.book.author.compareTo(b.book.author) : 
                  (b.book.author != null ? 1 : 0));
          }
          sortParam = value;
          _isAscending = true;
        });
      },
      isAscending: _isAscending,
      libraryName: libraryname,
    );
  }
}
