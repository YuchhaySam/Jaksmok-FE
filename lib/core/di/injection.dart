import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jaksmok_fe/core/network/dio_client.dart';
import 'package:jaksmok_fe/core/network/session/session_manager.dart';
import 'package:jaksmok_fe/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jaksmok_fe/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:jaksmok_fe/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jaksmok_fe/features/auth/domain/repositories/auth_repository.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:jaksmok_fe/features/book/data/datasources/book_remote_datasource.dart';
import 'package:jaksmok_fe/features/book/data/datasources/book_remote_datasource_impl.dart';
import 'package:jaksmok_fe/features/book/data/repositories/book_repository_impl.dart';
import 'package:jaksmok_fe/features/book/domain/repositories/book_repository.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_detail/book_detail_cubit.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_list/book_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => SessionManager());
  getIt.registerLazySingleton(
    () => DioClient(getIt<FlutterSecureStorage>(), getIt<SessionManager>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<BookRemoteDatasource>(
    () => BookRemoteDatasourceImpl(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDatasource>(),
      getIt<FlutterSecureStorage>(),
    ),
  );
  getIt.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(getIt<BookRemoteDatasource>()),
  );

  getIt.registerFactory(
    () => AuthCubit(getIt<AuthRepository>(), getIt<SessionManager>()),
  );

  getIt.registerFactory(() => BookCubit(getIt<BookRepository>()));

  getIt.registerFactory(() => BookDetailCubit(getIt<BookRepository>()));
}
