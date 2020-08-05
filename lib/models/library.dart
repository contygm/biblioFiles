class Library {
  String name;
  int id;

  Library(this.name, this.id);

  factory Library.fromJson(Map<dynamic, dynamic> record) {
    return Library(record['name'], record['id']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  String get libraryName {
    return name;
  }

  int get libraryId {
    return id;
  }
}
