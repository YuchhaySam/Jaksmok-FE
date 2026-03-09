import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/data/repositories/book_repository.dart';
import 'package:jaksmok_fe/logic/book/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  final int _size = 10;
  int _currentPage = 0;

  BookCubit(this.bookRepository) : super(BookInit());

  Future<void> fetchBooksList() async {
    emit(BookLoading());

    try {
      final books = await bookRepository.getBooks(_size, _currentPage);
      emit(
        BooksListSuccess(
          books: books.content,
          hasMore: books.totalPages > _currentPage,
        ),
      );
    } catch (error) {
      emit(BookError(error: 'Could not load books.', fullError: error));
    }
  }

  Future<void> refreshBooks() async {
    _currentPage = 0;
    await fetchBooksList();
  }

  Future<void> fetchBook(int id) async {
    emit(BookLoading());

    try {
      final book = await bookRepository.getBookById(id);
      emit(BookSuccess(book: book));
    } catch (error) {
      emit(BookError(error: 'Could not load book.', fullError: error));
    }
  }
}
