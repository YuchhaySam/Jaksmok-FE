import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jaksmok_fe/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/extensions/theme_extension.dart';
import 'package:jaksmok_fe/models/book_list_model.dart';
import 'package:jaksmok_fe/services/api_service.dart';
import 'package:jaksmok_fe/widgets/error_state.dart';

class BookDetailScreen extends StatefulWidget {
  final int id;
  const BookDetailScreen({super.key, required this.id});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Future<Book> _book;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  void _loadBook() {
    _book = ApiService.getBookById(widget.id);
  }

  Future<void> _refreshData() async {
    setState(() {
      _loadBook();
    });
    try {
      await _book;
    } catch (error) {
      if (mounted) context.showSnackBar('Failed to load book', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.surfaceContainerLow,
        centerTitle: true,
        title: Text('BOOK DETAIL'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: _book,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            developer.log(snapshot.error.toString());
            return ErrorState(
              error: 'Something went wrong',
              onPressed: _refreshData,
            );
          }

          if (snapshot.data == null) {
            return ErrorState(error: 'Book not found', onPressed: _refreshData);
          }

          final book = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.longestSide * 0.4,
                  decoration: BoxDecoration(
                    color: context.surfaceContainerLow,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: context.surfaceContainerLow,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Hero(
                            tag: 'book-${book!.id}',
                            child: CachedNetworkImage(
                              imageUrl: book.imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Icon(
                                  Icons.book_online_rounded,
                                  color: context.primary,
                                  size: 150,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          book.author,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          book.year,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: context.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context.surfaceContainerLow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfo('Country', book.country),
                            _buildInfo('Language', book.language),
                            _buildInfo('Pages', book.pages.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfo(String titleText, String value) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: context.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: context.primary,
            ),
          ),
        ],
      ),
    );
  }
}
