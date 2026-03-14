import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';

part 'book_state.freezed.dart';

@freezed
class BookState with _$BookState {
  const factory BookState.initial() = _Initial;
  const factory BookState.loading() = _Loading;
  const factory BookState.success(
    List<BookEntity> bookList, {
    @Default(false) bool hasMore,
  }) = _ListSuccess;
  const factory BookState.error(String message) = _Error;
}
