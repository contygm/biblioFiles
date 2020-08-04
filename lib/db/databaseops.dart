import 'package:biblioFiles/models/bookLibrary.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/library.dart';
import '../models/book.dart';

//library functions, return library listed based on user id
Future<List<Library>> callGetLibraries(String userId) async {
  final HttpsCallable getLibrariesFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getLibraries');

  final HttpsCallableResult result =
      await getLibrariesFunction.call(<String, dynamic>{'user': userId});

  var libraryResults = result.data
      .map((record) {
        return Library(record['name'], record['id']);
      })
      .toList()
      .cast<Library>();

  return libraryResults;
}

//create library based on form value and current user id
void callCreateLibrary(String value, String userId) async {
  // get function instance
  final HttpsCallable createLibraryFunction =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'createLibrary',
  );

  await createLibraryFunction.call(
    <String, dynamic>{'name': value, 'user': userId},
  );
}

//delete library with library id
void callDeleteLibrary(int libraryId) async {
  // get function instance
  final HttpsCallable deleteLibraryFunction =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'deleteLibrary',
  );

  final HttpsCallableResult result = await deleteLibraryFunction.call(
    <String, dynamic>{'id': libraryId},
  );
}

//library functions, return books from library listed based on library id
Future<List<dynamic>> callGetLibraryBooks(int libraryId) async {
  final HttpsCallable getLibraryBooksFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getLibraryBooks');

  final HttpsCallableResult result = await getLibraryBooksFunction
      .call(<dynamic, dynamic>{'library': libraryId});

  var booklib = result.data as List;
  List<BookLibrary> bookResults =
      booklib.map((i) => BookLibrary.fromJson(i)).toList();

  return bookResults;
}

Future<Book> findBookByIsbn(String isbn) async {
  final findBookByIsbnFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'findBookByIsbn');
  final result =
      await findBookByIsbnFunction.call(<dynamic, dynamic>{'isbn': isbn});

  // if not found return null
  if (result.data == null) {
    return null;
  } else {
    // if found, map to book object
    return Book.fromJson(result.data);
  }
}

Future<Book> callCreateBook(Book book) async {
  final createBookFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'createBook');

  final result = await createBookFunction.call(book.toJson());

  return Book.fromJson(result.data);
}

void addBookToLibrary(Book book, String libraryName, String userId) async {
  final createBookLibraryFunction = CloudFunctions.instance
      .getHttpsCallable(functionName: 'addBookToLibrary');

  await createBookLibraryFunction
      .call({'bookId': book.id, 'libraryName': libraryName, 'userId': userId});
}

Future<Library> findLibraryRecord(String libName, String userId) async {
  final findLibraryRecord = CloudFunctions.instance
      .getHttpsCallable(functionName: 'findLibraryRecord');

  final result =
      await findLibraryRecord.call({'libraryName': libName, 'userId': userId});

  return Library.fromJson(result.data);
}

//library functions, return books from library that are checked out 
Future<List<dynamic>> callGetCheckedOutBooks(String uid) async {
  final HttpsCallable getCOBooksFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getCOLibraryBooks');

  final HttpsCallableResult result = await getCOBooksFunction
      .call(<dynamic, dynamic>{'user': uid});

  var booklib = result.data as List;
  List<BookLibrary> bookResults =
      booklib.map((i) => BookLibrary.fromJson(i)).toList();

  return bookResults;
}

//library functions, return books from library that are currently being read out 
Future<List<dynamic>> callGetReadingBooks(String uid) async {
  final HttpsCallable getCOBooksFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getCRLibraryBooks');

  final HttpsCallableResult result = await getCOBooksFunction
      .call(<dynamic, dynamic>{'user': uid});

  var booklib = result.data as List;
  List<BookLibrary> bookResults =
      booklib.map((i) => BookLibrary.fromJson(i)).toList();

  return bookResults;
}
