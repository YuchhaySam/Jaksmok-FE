import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';

part 'book_detail_state.freezed.dart';

@freezed
class BookDetailState with _$BookDetailState {
  const factory BookDetailState.initial() = _Initial;
  const factory BookDetailState.loading() = _Loading;
  const factory BookDetailState.success(BookEntity book) = _Success;
  const factory BookDetailState.error(String message) = _Error;
}
