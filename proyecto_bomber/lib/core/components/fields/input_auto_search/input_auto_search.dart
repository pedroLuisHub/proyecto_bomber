import 'package:flutter/material.dart';

import 'debouncer.dart';

class InputAutoSearch extends StatefulWidget {
  final Function? search;
  final String? hintText;

  const InputAutoSearch({super.key, @required this.search, this.hintText});

  @override
  InputAutoSearchState createState() => InputAutoSearchState();
}

class InputAutoSearchState extends State<InputAutoSearch> {
  final _conditionEC = TextEditingController();

  Debouncer onSearchDebouncer = Debouncer();

  @override
  void dispose() {
    _conditionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        _conditionEC.text = value;
        onSearchDebouncer.debounce(() => widget.search!(value));
      },
      autofocus: false,
      // style: context.bodyLarge.copyWith(
      //   fontWeight: FontWeight.bold,
      //   fontSize: 16,
      //   color: context.canvasColor,
      // ),
      decoration: InputDecoration(
        // fillColor: context.primaryColor,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(Icons.search, size: 21),
          onPressed: () => _search(),
        ),
      ),
      //   hintStyle: context.bodyMedium.copyWith(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 16,
      //     color: context.canvasColor,
      //   ),
      //   border: InputBorder.none,
      //   errorBorder: InputBorder.none,
      //   enabledBorder: InputBorder.none,
      //   focusedBorder: InputBorder.none,
      // ),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => _search(),
    );
  }

  void _search() async {
    onSearchDebouncer.cancel();
    await widget.search!(_conditionEC.text);
  }
}
