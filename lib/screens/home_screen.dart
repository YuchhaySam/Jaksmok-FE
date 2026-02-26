import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jaksmok_fe/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/extensions/theme_extension.dart';
import 'package:jaksmok_fe/models/book_list_model.dart';
import 'package:jaksmok_fe/screens/book_detail_screen.dart';
import 'package:jaksmok_fe/services/api_service.dart';
import 'package:jaksmok_fe/widgets/error_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<BookList> _bookListFuture;
  final _controller = ScrollController();
  final int _size = 10;
  int _page = 1;

  @override
  void initState() {
    _loadBooks();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        setState(() {
          _page++;
        });
        _loadBooks();
      }
    });
    super.initState();
  }

  void _loadBooks() {
    _bookListFuture = ApiService.getBooks(_size, _page);
  }

  Future<void> _refreshList() async {
    setState(() {
      _loadBooks();
    });
    try {
      await _bookListFuture;
    } catch (e) {
      if (mounted) context.showSnackBar('Update failed', true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
            onPressed: () async => await ApiService.logout(),
            icon: Icon(Icons.logout, color: context.primary),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return RefreshIndicator(
      onRefresh: () => _refreshList(),
      child: FutureBuilder(
        future: _bookListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error.toString();
            developer.log(error);
            return ErrorState(error: error, onPressed: () => _refreshList());
          }

          final data = snapshot.data;
          final contents = data?.content ?? [];

          if (contents.isEmpty) {
            return const Center(child: Text('No books found'));
          }

          return ListView.builder(
            itemCount: contents.length + 1,
            controller: _controller,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < contents.length) {
                final book = contents[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 25,
                  ),
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
                      child: CachedNetworkImage(
                        imageUrl: book.imageUrl,
                        width: 40,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: context.surfaceContainerLow,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
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
              } else {
                return Padding(
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 30),
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
