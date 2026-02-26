class BookList {
  final int size;
  final int totalElements;
  final int page;
  final int totalPages;
  final List<Book> content;

  BookList({
    required this.size,
    required this.totalElements,
    required this.page,
    required this.totalPages,
    required this.content,
  });

  factory BookList.fromJson(Map<String, dynamic> json) {
    return BookList(
      size: json['size'],
      totalElements: json['totalElements'],
      page: json['page'],
      totalPages: json['totalPages'],
      content: (json['content'] as List)
          .map((item) => Book.fromJson(item))
          .toList(),
    );
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final String realYears;
  final String year;
  final String country;
  final String language;
  final int pages;
  final String wikipediaLink;
  final String imageUrl;

  Book({
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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      realYears: json['realYears'],
      year: json['year'],
      country: json['country'],
      language: json['language'],
      pages: json['pages'],
      wikipediaLink: json['wikipediaLink'],
      imageUrl: json['imageUrl'],
    );
  }
}
