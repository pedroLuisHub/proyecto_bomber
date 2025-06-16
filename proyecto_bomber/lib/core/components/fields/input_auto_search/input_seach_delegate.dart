
import 'package:flutter/material.dart';

class InputSeachDelegate<T> extends StatelessWidget {
  final String label;
  final SearchDelegate<T> searchDelegate;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(T?)? onSelected;
  final void Function()? onLongPress;
  final bool enabled;

  const InputSeachDelegate({
    super.key,
    required this.label,
    required this.searchDelegate,
    required this.controller,
    this.validator,
    this.onSelected,
    this.enabled = true,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: () async {
        if (enabled) {
          final data = await showSearch(
            context: context,
            delegate: searchDelegate,
          );

          if (data != null) {
            onSelected!(data);
          }
        }
      },
      child: Stack(
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text(label)),
            validator: validator,
            enabled: false,
            controller: controller,
          ),
          Positioned(
            top: 4,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    if (enabled) {
                      if (onSelected != null) onSelected!(null);
                    }
                  },
                  icon: Icon(
                    Icons.close,
                    color: enabled ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
