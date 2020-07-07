# BiblioFiles
Keep track of your books in flutter

## Testing

To run the tests locally: 
```dart
# lint
flutter analyze

# unit tests
flutter test

# integration test
flutter drive --target=test_driver/app.dart
```

For the integration tests, be sure to start a similator of your choice. 

Documentation and Code Exmaples for all test types: https://flutter.dev/docs/cookbook/testing

For linting, we are using the Effective Style: https://dart.dev/guides/language/effective-dart/documentation

## Automated Testing

- Set up Guide: https://levelup.gitconnected.com/ci-cd-for-flutter-apps-3a56e3fc6d8e
- Github Actions: https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions

The code for the automated PR testing is located in .github/workflows. The repo uses Github Actions to automate the testing of PRs. 

Test will run automatically on PRs. Tests include lint, unit and integration tests. Tests must pass in order for PRs to be merged.