class Book {
  String image;
  int pages;
  String author; 
  int isbn13;
  int isbn10;
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

   
  int get isbn_10 {
    return isbn10;
  }

  int get isbn_13 {
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
