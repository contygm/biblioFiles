class Book {
  int id;
  int isbn10;
  int isbn13;
  String dewey;
  String title;
  String author;
  int pages;
  String language;
  String image;
  String notes;
  bool private;
  bool loanable;
  bool currentlyreading;
  bool checkedout;
  bool unpacked;
  int rating;

  Book(
      this.id,
      this.isbn10,
      this.isbn13,
      this.dewey,
      this.title,
      this.author,
      this.pages,
      this.language,
      this.image,
      this.notes,
      this.private,
      this.loanable,
      this.currentlyreading,
      this.checkedout,
      this.unpacked,
      this.rating);

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

  String get userNotes {
    return notes; 
  }

  bool get secretBook {
    return private; 
  }

  bool get loanOption  {
    return loanable; 
  }

  bool get curReading  {
    return currentlyreading; 
  }

   bool get isBorrowed  {
    return checkedout; 
  }

    bool get unpackedBook  {
    return unpacked; 
  }

  int get starRating {
    return rating; 
  }




}
