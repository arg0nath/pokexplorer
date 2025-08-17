import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class PokeSearchBar extends StatefulWidget {
  const PokeSearchBar({super.key, required this.onSearch});

  final Function(String? value) onSearch;

  @override
  State<PokeSearchBar> createState() => _PokeSearchBarState();
}

class _PokeSearchBarState extends State<PokeSearchBar> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        style: context.theme.inputDecorationTheme.labelStyle,
        decoration: const InputDecoration().copyWith(
            hintText: 'Search',
            suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (textEditingController.value.text.isNotEmpty) {
                    FocusScope.of(context).unfocus();
                    return widget.onSearch(textEditingController.value.text);
                  }
                }),
            prefixIcon: textEditingController.value.text.isEmpty
                ? null
                : GestureDetector(
                    onTap: () {
                      textEditingController.clear();
                      return widget.onSearch(AppConst.emptyString);
                    },
                    child: const Icon(Icons.clear_rounded))),
        onChanged: (String value) {
          if (value.isEmpty) {
            return widget.onSearch(AppConst.emptyString);
          }
        },
        onSaved: (String? newValue) => widget.onSearch(newValue),
        onTapOutside: (PointerDownEvent val) => FocusScope.of(context).unfocus(),
        onFieldSubmitted: (String val) {
          if (val.isNotEmpty) {
            return widget.onSearch(val);
          } else {
            null;
          }
        });
  }
}
