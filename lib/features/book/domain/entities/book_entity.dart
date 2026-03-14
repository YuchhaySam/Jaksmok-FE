class BookListEntity {
  int size;
  int totalBooks;
  List<BookEntity> books;
  int page;
  int totalPages;
  BookListEntity({
    required this.size,

    required this.totalBooks,

    required this.books,

    required this.page,

    required this.totalPages,
  });
}

class BookEntity {
  int id;
  String title;
  String author;
  String realYears;
  String year;
  String country;
  String language;
  int pages;
  String wikipediaLink;
  String imageUrl;

  BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.realYears,
    required this.year,
    required this.country,
    required this.language,
    required this.pages,
    required this.wikipediaLink,
    required this.imageUrl,
  });
}
