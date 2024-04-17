import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<T>> buildListItems<T>(List<dynamic> items) {
  return items.map((e) => DropdownMenuItem<T>(value: e, child: AutoSizeText(e.toString()))).toList();
}

T? selectItemDropdown<T extends dynamic>(List<T> items, T? compare, {T? onError}) {
  try {
    return items.where((e) => e.pk == compare.pk).single;
  } catch (_) {
    if (onError != null) {
      return items.where((e) => e.pk == onError.pk).single;
    }

    return null;
  }
}
