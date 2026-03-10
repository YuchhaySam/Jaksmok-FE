import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/data/models/book_list_model.dart';
import 'package:jaksmok_fe/data/repositories/book_repository.dart';
import 'package:jaksmok_fe/logic/book/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  final int _size = 10;
  int _currentPage = 0;
  List<Book> books = [];
  bool hasMore = true;

  BookCubit(this.bookRepository) : super(BookInit());

  Future<void> fetchBooksList() async {
    emit(BookLoading());

    try {
      final fetchedBooks = await bookRepository.getBooks(_size, _currentPage);
      hasMore = fetchedBooks.totalPages > _currentPage;
      books.addAll(fetchedBooks.content);
      _currentPage++;
      emit(BooksListSuccess(books: books, hasMore: hasMore));
    } catch (error) {
      emit(BookError(error: 'Could not load books.'));
    }
  }

  Future<void> refreshBooks() async {
    _currentPage = 0;
    books = [];
    await fetchBooksList();
  }

  Future<void> fetchBook(int id) async {
    emit(BookLoading());

    try {
      final book = await bookRepository.getBookById(id);
      emit(BookSuccess(book: book));
    } catch (error) {
      emit(BookError(error: 'Could not load book.'));
    }
  }
}
