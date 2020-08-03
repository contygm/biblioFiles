class Book {
  String image;
  int pages;
  String author;
  String isbn13;
  String isbn10;
  String dewey;
  int id;
  String title;
  String lang;

  Book.empty();

  Book(this.image, this.pages, this.author, this.isbn13, this.isbn10,
      this.dewey, this.id, this.title, this.lang);

  Map<String, dynamic> toJson() => {
        'image': image,
        'pages': pages,
        'author': author,
        'isbn13': isbn13,
        'isbn10': isbn10,
        'dewey': dewey,
        'title': title,
        'lang': lang
      };

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

  set bookImg(String newValue) {
    image = newValue;
  }

  String get isbn_10 {
    return isbn10 != null ? isbn10 : '';
  }

  set isbn_10(String newValue) {
    isbn10 = newValue;
  }

  String get isbn_13 {
    return isbn13 != null ? isbn13 : '';
  }

  set isbn_13(String newValue) {
    isbn13 = newValue;
  }

  String get deweyd {
    return dewey != null ? dewey : '';
  }

  set deweyd(String newValue) {
    dewey = newValue;
  }

  String get bookTitle {
    return title != null ? title : '';
  }

  set bookTitle(String value) {
    title = value;
  }

  String get bookAuthor {
    return author != null ? author : '';
  }

  set bookAuthor(String newValue) {
    author = newValue;
  }

  int get pageCount {
    return pages != null ? pages : '';
  }

  set pageCount(int newValue) {
    pages = newValue;
  }

  String get bookLang {
    return lang != null ? lang : '';
  }

  set bookLang(String newValue) {
    lang = newValue;
  }
}
