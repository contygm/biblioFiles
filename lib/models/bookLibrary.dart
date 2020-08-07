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

  BookLibrary(
      {this.book,
      this.notes,
      this.private,
      this.loanable,
      this.rating,
      this.currentlyreading,
      this.checkedout,
      this.unpacked,
      this.id});

  Map<String, dynamic> toJson() => {
        'user_note': notes,
        'private_book': private,
        'id': id,
        'loanable': loanable,
        'rating': rating,
        'reading': currentlyreading,
        'loaned': checkedout,
        'unpacked': unpacked
      };

  BookLibrary.fromJson(Map<dynamic, dynamic> record) {
    notes = record['user_note'];
    private = record['private_book'];
    loanable = record['loanable'];
    rating = record['rating'];
    currentlyreading = record['reading'];
    checkedout = record['loaned'];
    unpacked = record['unpacked'];
    id = record['id'];
    book = record['book'] != null ? Book.fromJson(record['book']) : null;
  }

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
