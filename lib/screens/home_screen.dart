import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jaksmok_fe/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/extensions/theme_extension.dart';
import 'package:jaksmok_fe/models/book_list_model.dart';
import 'package:jaksmok_fe/screens/book_detail_screen.dart';
import 'package:jaksmok_fe/services/api_service.dart';
import 'package:jaksmok_fe/widgets/error_state.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final int _size = 10;
  List<Book> _books = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _fetchPage();
      }
    });
  }

  Future<void> _fetchPage() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final bookList = await ApiService.getBooks(_size, _currentPage);
      setState(() {
        _books.addAll(bookList.content);
        _currentPage++;
        _hasMore = _currentPage < bookList.totalPages;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Could not load books. Tap to retry";
      });
      if (mounted) context.showSnackBar('Failed to load books', true);
    }
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
            onPressed: () async => await ApiService.logout(),
            icon: Icon(Icons.logout, color: context.primary),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _books = [];
            _currentPage = 0;
            _hasMore = true;
            _errorMessage = null;
          });
          await _fetchPage();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _isLoading && _books.isEmpty
              ? _buildInitialLoad()
              : _buildListView(_books),
        ),
      ),
    );
  }

  Widget _buildListView(List<Book> contents) {
    return ListView.builder(
      itemCount: contents.length + 1,
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (_errorMessage != null) {
          developer.log(_errorMessage!);
          return ErrorState(error: _errorMessage!, onPressed: _fetchPage);
        }

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
        if (_hasMore) {
          return _buildBookSkeleton();
        }

        return const SizedBox.shrink();
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
