import 'dart:ffi';

import 'package:cloud_functions/cloud_functions.dart';
import '../models/library.dart';

Future<List<dynamic>> callGetLibraries() async {
  final HttpsCallable getLibrariesFunction =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getLibraries');

  final HttpsCallableResult result =
      await getLibrariesFunction.call(<String, dynamic>{'user': 1});

 final libraryResults = result.data.map((record) {
    return Library(record['name'],
                  record['id']);
  }).toList();
  return libraryResults;
}
