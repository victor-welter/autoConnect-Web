import 'package:flutter/material.dart';

import '../extensions/context_ext.dart';
import '../utils/functions_utils.dart';
import 'cs_actions_button.dart';
import 'cs_icon.dart';
import 'cs_icon_button.dart';
import 'cs_text_form_field.dart';

class CsSearchField extends StatefulWidget {
  const CsSearchField({
    required this.where,
    required this.onSearch,
    required this.focus,
    super.key,
  });

  final String? where;
  final void Function(String?) onSearch;
  final FocusNode? focus;

  @override
  State<CsSearchField> createState() => _CsSearchFieldState();
}

class _CsSearchFieldState extends State<CsSearchField> {
  ///[Controllers]
  final whereController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.where != null) {
      whereController.text = widget.where ?? '';
    }
  }

  @override
  void dispose() {
    whereController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: context.width * 0.35,
          child: CsTextFormField(
            hintText: 'Pesquisar',
            controller: whereController,
            focus: widget.focus,
            onEditingComplete: () => widget.onSearch(whereController.text),
            prefixIcon: CsIconButton.light(
              icon: const CsIcon(
                icon: Icons.search_rounded,
                color: Colors.white,
              ),
            ),
            suffixIcon: clearField(
              value: widget.where,
              color: Colors.white,
              onClear: () {
                whereController.clear();

                widget.onSearch(null);
              },
            ),
          ),
        ),
        const SizedBox(width: 15),
        CsActionsButton(
          color: Colors.blue[800],
          icon: const CsIcon(
            icon: Icons.search_rounded,
            color: Colors.white,
          ),
          label: 'PESQUISAR',
          onPressed: () => widget.onSearch(whereController.text),
        ),
      ],
    );
  }
}