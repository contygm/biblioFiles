import 'package:flutter/material.dart';
import '../../components/book_tile.dart';
import '../../components/filter_sort_bar.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../screens/single_book/single_book_screen.dart';
import '../../templates/default_template.dart';

Library library;

class CheckoutBookListScreen extends StatelessWidget {
  static final String routeName = 'checkboxBookList';
  @override
  Widget build(BuildContext context) {
    library = ModalRoute.of(context).settings.arguments;
    return Container(child: LoadBooksTileListScreen());
  }
}

class LoadBooksTileListScreen extends StatefulWidget {
  @override
  _LoadBooksTileListScreenState createState() =>
      _LoadBooksTileListScreenState();
}

class _LoadBooksTileListScreenState extends State<LoadBooksTileListScreen> {
  // keep track of sort order
  bool _isAscending = true;
  // keep track of sort param, default = Author
  String sortParam = 'Author';

  @override
  void initState() {
    super.initState();
    getBooksinLibrary();
  }

  bool booksSearched = false;
  List<dynamic> allBooks = [];
  List<dynamic> organizedBooks = [];
  void getBooksinLibrary() async {
    var books = await callGetLibraryBooks(library.id);
    setState(() {
      booksSearched = true;
      allBooks = books;
      organizedBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (booksSearched == false) {
      return DefaultTemplate(
        content: Container(child: CircularProgressIndicator())
      );
    } else {
      return DefaultTemplate(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
            children: [
              FilterSortBar(
                filterChoices: [
                  'All',
                  'Packed',
                  'Unpacked',
                  'Checked Out',
                  'Checked In'
                ],
                filterOnSelected: (value) {
                  setState(() {
                    switch (value) {
                      case 'Packed':
                        organizedBooks = 
                          allBooks.where((b) => !b.unpacked).toList();
                        break;
                      case 'Unpacked':
                        organizedBooks = 
                          allBooks.where((b) => b.unpacked).toList();
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
                libraryName: library.libraryName,
              ),
              Expanded(child: bookTileList())
            ],
          )),
        ),
      );
    }
  }

  Widget bookTileList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: organizedBooks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onDoubleTap: () => Navigator.of(context)
            .pushNamed(SingleBookScreen.routeName, 
            arguments: organizedBooks[index]),
          child: BookTile(
            sortParam: sortParam,
            bookLib: organizedBooks[index],
            library: library,
            hasCheckbox: true,
            onChanged: (value) async {
              setState(() {
                organizedBooks[index].unpacked = !organizedBooks[index].unpacked;
              });
             await updateLibraryBook(organizedBooks[index]);
            }
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider());
  }
}