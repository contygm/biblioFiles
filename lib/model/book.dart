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

  Book(this.image, this.pages, this.author, this.isbn13, this.isbn10,
      this.dewey, this.id, this.title, this.language);

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

  factory Book.fromApiJson(dynamic json) {
    // get book
    json = json['book'];

    // parse author
    var authors = json['authors'] != null ? List.from(json['authors']) : null;
    var author = authors.first;

    return Book(
        json['image'] as String,
        json['pages'] as int,
        author as String,
        json['isbn13'] as String,
        json['isbn'] as String,
        json['dewey_decimal'] as String,
        null,
        json['title'],
        json['language'] as String);
  }

  String get bookImg {
    return image != null ? image : '';
  }

  String get isbn_10 {
    return isbn10 != null ? isbn10 : '';
  }

  String get isbn_13 {
    return isbn13 != null ? isbn13 : '';
  }

  String get deweyd {
    return dewey != null ? dewey : '';
  }

  String get bookTitle {
    return title != null ? title : '';
  }

  String get bookAuthor {
    return author != null ? author : '';
  }

  int get pageCount {
    return pages != null ? pages : '';
  }

  String get bookLang {
    return language != null ? language : '';
  }
}
