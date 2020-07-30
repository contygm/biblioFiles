class Book {
  String image;
  int pages;
  String author;
  String isbn13;
  String isbn10;
  String dewey;
  int id;
  String title;
  String language;

  Book(
      this.image,
      this.pages,
      this.author,
      this.isbn13,
      this.isbn10,
      this.dewey,
      this.id,
      this.title,
      this.language);

factory Book.fromJson(Map<dynamic, dynamic> record) {
    return Book(
    record['image'],
    record['pages'],
    record['author'],
    record['isbn13'],
    record['isbn10'],
    record['dewey'],
    record['id'],
    record['title'],
    record['lang']);
}


  String get isbn_10 {
    return isbn10;
  }

  String get isbn_13 {
    return isbn13;
  }

  String get deweyd {
    return dewey;
  }

  String get bookTitle {
    return title;
  }

  String get bookAuthor {
    return author;
  }

  int get pageCount {
    return pages;
  }

  String get bookLang {
    return language;
  }
}
