import 'package:bomber/core/components/fields/input_auto_search/input_auto_search.dart';
import 'package:flutter/material.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String) onSearch;
  final String hintText;

  const SearchAppBarWidget(
      {super.key, required this.onSearch, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InputAutoSearch(
        search: onSearch,
        hintText: hintText,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
