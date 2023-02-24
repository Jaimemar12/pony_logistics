import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
          hintText: "Search for Statistics",
          helperStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            Icons.search,
            color: textColor.withOpacity(0.5),
          )),
    );
  }
}
