// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookListModel {

 int get totalElements; List<BookModel> get content; int get size; int get page; int get totalPages;
/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookListModelCopyWith<BookListModel> get copyWith => _$BookListModelCopyWithImpl<BookListModel>(this as BookListModel, _$identity);

  /// Serializes this BookListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookListModel&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.size, size) || other.size == size)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalElements,const DeepCollectionEquality().hash(content),size,page,totalPages);

@override
String toString() {
  return 'BookListModel(totalElements: $totalElements, content: $content, size: $size, page: $page, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $BookListModelCopyWith<$Res>  {
  factory $BookListModelCopyWith(BookListModel value, $Res Function(BookListModel) _then) = _$BookListModelCopyWithImpl;
@useResult
$Res call({
 int totalElements, List<BookModel> content, int size, int page, int totalPages
});




}
/// @nodoc
class _$BookListModelCopyWithImpl<$Res>
    implements $BookListModelCopyWith<$Res> {
  _$BookListModelCopyWithImpl(this._self, this._then);

  final BookListModel _self;
  final $Res Function(BookListModel) _then;

/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalElements = null,Object? content = null,Object? size = null,Object? page = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<BookModel>,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookListModel].
extension BookListModelPatterns on BookListModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookListModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookListModel value)  $default,){
final _that = this;
switch (_that) {
case _BookListModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookListModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookListModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalElements,  List<BookModel> content,  int size,  int page,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookListModel() when $default != null:
return $default(_that.totalElements,_that.content,_that.size,_that.page,_that.totalPages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalElements,  List<BookModel> content,  int size,  int page,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _BookListModel():
return $default(_that.totalElements,_that.content,_that.size,_that.page,_that.totalPages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalElements,  List<BookModel> content,  int size,  int page,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _BookListModel() when $default != null:
return $default(_that.totalElements,_that.content,_that.size,_that.page,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookListModel implements BookListModel {
  const _BookListModel({required this.totalElements, required final  List<BookModel> content, required this.size, required this.page, required this.totalPages}): _content = content;
  factory _BookListModel.fromJson(Map<String, dynamic> json) => _$BookListModelFromJson(json);

@override final  int totalElements;
 final  List<BookModel> _content;
@override List<BookModel> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override final  int size;
@override final  int page;
@override final  int totalPages;

/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookListModelCopyWith<_BookListModel> get copyWith => __$BookListModelCopyWithImpl<_BookListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookListModel&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.size, size) || other.size == size)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalElements,const DeepCollectionEquality().hash(_content),size,page,totalPages);

@override
String toString() {
  return 'BookListModel(totalElements: $totalElements, content: $content, size: $size, page: $page, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$BookListModelCopyWith<$Res> implements $BookListModelCopyWith<$Res> {
  factory _$BookListModelCopyWith(_BookListModel value, $Res Function(_BookListModel) _then) = __$BookListModelCopyWithImpl;
@override @useResult
$Res call({
 int totalElements, List<BookModel> content, int size, int page, int totalPages
});




}
/// @nodoc
class __$BookListModelCopyWithImpl<$Res>
    implements _$BookListModelCopyWith<$Res> {
  __$BookListModelCopyWithImpl(this._self, this._then);

  final _BookListModel _self;
  final $Res Function(_BookListModel) _then;

/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalElements = null,Object? content = null,Object? size = null,Object? page = null,Object? totalPages = null,}) {
  return _then(_BookListModel(
totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<BookModel>,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BookModel {

 int get id; String get title; String get author; String get realYears; String get year; String get country; String get language; int get pages; String get wikipediaLink; String get imageUrl;
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookModelCopyWith<BookModel> get copyWith => _$BookModelCopyWithImpl<BookModel>(this as BookModel, _$identity);

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.realYears, realYears) || other.realYears == realYears)&&(identical(other.year, year) || other.year == year)&&(identical(other.country, country) || other.country == country)&&(identical(other.language, language) || other.language == language)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.wikipediaLink, wikipediaLink) || other.wikipediaLink == wikipediaLink)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,realYears,year,country,language,pages,wikipediaLink,imageUrl);

@override
String toString() {
  return 'BookModel(id: $id, title: $title, author: $author, realYears: $realYears, year: $year, country: $country, language: $language, pages: $pages, wikipediaLink: $wikipediaLink, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $BookModelCopyWith<$Res>  {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) _then) = _$BookModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String author, String realYears, String year, String country, String language, int pages, String wikipediaLink, String imageUrl
});




}
/// @nodoc
class _$BookModelCopyWithImpl<$Res>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._self, this._then);

  final BookModel _self;
  final $Res Function(BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? author = null,Object? realYears = null,Object? year = null,Object? country = null,Object? language = null,Object? pages = null,Object? wikipediaLink = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,realYears: null == realYears ? _self.realYears : realYears // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,wikipediaLink: null == wikipediaLink ? _self.wikipediaLink : wikipediaLink // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookModel].
extension BookModelPatterns on BookModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookModel value)  $default,){
final _that = this;
switch (_that) {
case _BookModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String author,  String realYears,  String year,  String country,  String language,  int pages,  String wikipediaLink,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.realYears,_that.year,_that.country,_that.language,_that.pages,_that.wikipediaLink,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String author,  String realYears,  String year,  String country,  String language,  int pages,  String wikipediaLink,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _BookModel():
return $default(_that.id,_that.title,_that.author,_that.realYears,_that.year,_that.country,_that.language,_that.pages,_that.wikipediaLink,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String author,  String realYears,  String year,  String country,  String language,  int pages,  String wikipediaLink,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.realYears,_that.year,_that.country,_that.language,_that.pages,_that.wikipediaLink,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookModel implements BookModel {
  const _BookModel({required this.id, required this.title, required this.author, required this.realYears, required this.year, required this.country, required this.language, required this.pages, required this.wikipediaLink, required this.imageUrl});
  factory _BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

@override final  int id;
@override final  String title;
@override final  String author;
@override final  String realYears;
@override final  String year;
@override final  String country;
@override final  String language;
@override final  int pages;
@override final  String wikipediaLink;
@override final  String imageUrl;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookModelCopyWith<_BookModel> get copyWith => __$BookModelCopyWithImpl<_BookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.realYears, realYears) || other.realYears == realYears)&&(identical(other.year, year) || other.year == year)&&(identical(other.country, country) || other.country == country)&&(identical(other.language, language) || other.language == language)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.wikipediaLink, wikipediaLink) || other.wikipediaLink == wikipediaLink)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,realYears,year,country,language,pages,wikipediaLink,imageUrl);

@override
String toString() {
  return 'BookModel(id: $id, title: $title, author: $author, realYears: $realYears, year: $year, country: $country, language: $language, pages: $pages, wikipediaLink: $wikipediaLink, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$BookModelCopyWith(_BookModel value, $Res Function(_BookModel) _then) = __$BookModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String author, String realYears, String year, String country, String language, int pages, String wikipediaLink, String imageUrl
});




}
/// @nodoc
class __$BookModelCopyWithImpl<$Res>
    implements _$BookModelCopyWith<$Res> {
  __$BookModelCopyWithImpl(this._self, this._then);

  final _BookModel _self;
  final $Res Function(_BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? author = null,Object? realYears = null,Object? year = null,Object? country = null,Object? language = null,Object? pages = null,Object? wikipediaLink = null,Object? imageUrl = null,}) {
  return _then(_BookModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,realYears: null == realYears ? _self.realYears : realYears // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,wikipediaLink: null == wikipediaLink ? _self.wikipediaLink : wikipediaLink // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
