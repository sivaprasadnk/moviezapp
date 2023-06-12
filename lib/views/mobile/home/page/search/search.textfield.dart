import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  FocusNode focusNode = FocusNode();

  String query = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return Form(
        key: _formKey,
        child: Container(
          width: context.width * 0.3,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            focusNode: focusNode,
            onSaved: (newValue) {
              query = newValue!.trim();
              provider.clearSearchList();
              setState(() {});
            },
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () {
                  sendQuery();
                },
                child: const Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  sendQuery() {
    _formKey.currentState!.save();
    context.unfocus();
    if (query.isNotEmpty) {
      context.moviesProvider.updateQuery(query);
      context.moviesProvider.searchMovie(query, !context.isMobileApp);
      context.moviesProvider.searchTvShow(query);
    }
  }
}
