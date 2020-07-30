import '../models/book.dart';

class BookLibrary {
  int id;
  String notes;
  bool private;
  bool loanable;
  bool currentlyreading;
  bool checkedout;
  bool unpacked;
  int rating;
  Book book;

  BookLibrary(this.book, this.notes, this.private, this.loanable,
      this.rating, this.currentlyreading, this.checkedout, this.unpacked, this.id
      );


  int get lbid {
    return id;
  }

  String get userNotes {
    return notes;
  }

  bool get secretBook {
    return private;
  }

  bool get loanOption {
    return loanable;
  }

  bool get curReading {
    return currentlyreading;
  }

  bool get isBorrowed {
    return checkedout;
  }

  bool get unpackedBook {
    return unpacked;
  }

  int get starRating {
    return rating;
  }
}
