import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchWidget extends StatelessWidget {
  final IconData trailingIcon;
  final TextEditingController search;
   final Function(String)? onChanged;
  final String prefix;
  const SearchWidget({
    super.key,
    required this.trailingIcon,
    required this.prefix,
    required this.search, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: search,
        onChanged: onChanged,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            prefixIcon: const Icon(Ionicons.search),
            hintText: prefix,
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(trailingIcon)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
