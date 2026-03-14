import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/core/localization/locale_keys.g.dart';
import 'package:jaksmok_fe/core/themes/theme_extension.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:jaksmok_fe/features/book/domain/entities/book_entity.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_list/book_cubit.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_list/book_state.dart';
import 'package:jaksmok_fe/features/book/presentation/screens/book_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BookCubit>().getBooksList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<BookCubit>().getBooksList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.home_title.tr()),
        actions: [
          IconButton(
            onPressed: () async => context.read<AuthCubit>().logout(),
            icon: Icon(Icons.logout, color: context.primary),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BookCubit>().refreshBooks();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BlocConsumer<BookCubit, BookState>(
            listener: (context, state) {
              state.maybeWhen(
                error: (message) {
                  context.showSnackBar(message, true);
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => _buildInitialLoad(),
                success: (bookList, hasMore) {
                  if (bookList.isEmpty) {
                    return Center(child: Text(LocaleKeys.home_empty_list.tr()));
                  }
                  return _buildListView(bookList, hasMore);
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<BookEntity> contents, bool hasMore) {
    return ListView.builder(
      itemCount: contents.length + (hasMore ? 1 : 0),
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < contents.length) {
          final book = contents[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            decoration: BoxDecoration(
              color: context.surfaceContainerHigh,
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 4),
                  color: context.onSurface.withValues(alpha: 0.15),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: context.onSurface.withValues(alpha: 0.2),
              ),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Hero(
                  tag: 'book-${book.id}',
                  child: CachedNetworkImage(
                    imageUrl: book.imageUrl,
                    width: 40,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: context.surfaceContainerLow,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: context.onPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.book_online_rounded,
                        color: context.primary,
                        size: 30,
                      );
                    },
                  ),
                ),
              ),
              title: Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleLarge,
              ),
              subtitle: Text(
                'By: ${book.author}',
                style: context.textTheme.titleMedium,
              ),

              onTap: () {
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailScreen(id: book.id),
                  ),
                );
              },
            ),
          );
        }
        return _buildBookSkeleton();
      },
    );
  }

  Widget _buildBookSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInitialLoad() {
    return ListView.builder(
      itemCount: (MediaQuery.of(context).size.height / 70).ceil(),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildBookSkeleton(),
    );
  }
}
