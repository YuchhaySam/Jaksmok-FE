import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/features/book/domain/repositories/book_repository.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_detail/book_detail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  final BookRepository bookRepository;
  BookDetailCubit(this.bookRepository) : super(const BookDetailState.initial());

  Future<void> getBook(int id) async {
    emit(BookDetailState.loading());
    final result = await bookRepository.getBooksById(id);
    result.fold(
      (failure) {
        emit(BookDetailState.error(failure.message!));
      },
      (success) {
        emit(BookDetailState.success(success));
      },
    );
  }
}
