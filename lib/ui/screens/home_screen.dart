import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/core/extensions/theme_extension.dart';
import 'package:jaksmok_fe/data/models/book_list_model.dart';
import 'package:jaksmok_fe/logic/auth/auth_cubit.dart';
import 'package:jaksmok_fe/logic/book/book_cubit.dart';
import 'package:jaksmok_fe/logic/book/book_state.dart';
import 'package:jaksmok_fe/ui/screens/book_detail_screen.dart';
import 'package:logger/logger.dart';
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
    context.read<BookCubit>().fetchBooksList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<BookCubit>().fetchBooksList();
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
      backgroundColor: context.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: context.surfaceContainerLow,
        centerTitle: true,
        title: const Text('HOME'),
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
          child: BlocBuilder<BookCubit, BookState>(
            builder: (context, state) {
              if (state is BookError) {
                Logger().e(state.fullError);
                context.showSnackBar(state.error, true);
                return const Center(child: Text('Error: No data'));
              }

              if (state is BooksListSuccess) {
                return _buildListView(state.books, state.hasMore);
              }
              return _buildInitialLoad();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Book> contents, bool hasMore) {
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
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'By: ${book.author}',
                style: TextStyle(fontWeight: FontWeight.w300),
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
      itemCount: 8,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildBookSkeleton(),
    );
  }
}
