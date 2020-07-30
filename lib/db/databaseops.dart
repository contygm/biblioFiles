import 'package:biblioFiles/models/bookLibrary.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/library.dart';
import '../models/book.dart';

//library functions, return library listed based on user id
Future<List<dynamic>> callGetLibraries(int userId) async {
  final HttpsCallable getLibrariesFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getLibraries');

  final HttpsCallableResult result =
      await getLibrariesFunction.call(<String, dynamic>{'user': userId});

  final libraryResults = result.data.map((record) {
    return Library(record['name'], record['id']);
  }).toList();
  return libraryResults;
}

//create library based on form value and current user id
void callCreateLibrary(String value, int userId) async {
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
  print(result.data);

final tempbook = result.data.map((record) {
  return Book(
    record['book']['image'],
        int.parse(record['book']['pages']),
        record['book']['author'],
        int.parse(record['book']['isbn13']),
        int.parse(record['book']['isbn10']),
        record['book']['dewey'],
        int.parse(record['book']['id']),
        record['book']['title'],
        record['book']['lang'] );
}).toList(); 

//THIS NEEDS WORK - NOT PARSING CORRECTLY
  final bookResults = result.data.map((record) {
    return BookLibrary(
        tempbook,
        record['notes'],
        record['private_book'],
        record['loanable'],
        int.parse(record['rating']),
        record['reading'],
        record['loaned'],
        record['unpacked'],
        int.parse(record['id']));
  }).toList();

  return bookResults;
}
