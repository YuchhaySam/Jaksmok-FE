import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';
import 'package:jaksmok_fe/features/book/domain/repositories/book_repository.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_list/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  final int _size = 10;
  int _currentPage = 0;
  List<BookEntity> books = [];

  BookCubit(this.bookRepository) : super(const BookState.initial());

  Future<void> getBooksList() async {
    if (books.isEmpty) {
      emit(BookState.loading());
    }

    final result = await bookRepository.getBooks(_size, _currentPage);
    result.fold(
      (failure) {
        emit(BookState.error(failure.message!));
      },
      (success) {
        books.addAll(success.books);
        _currentPage++;
        emit(
          BookState.success(
            List.from(books),
            hasMore: success.totalPages > _currentPage,
          ),
        );
      },
    );
  }

  Future<void> refreshBooks() async {
    _currentPage = 0;
    books = [];
    await getBooksList();
  }
}
