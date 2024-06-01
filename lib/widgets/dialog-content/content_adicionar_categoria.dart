import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/categoria/categoria_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarCategoria extends StatefulWidget {
  const ContentAdicionarCategoria({
    this.categoria,
    super.key,
  });

  final CategoriaModel? categoria;

  @override
  State<ContentAdicionarCategoria> createState() => _ContentAdicionarCategoriaState();
}

class _ContentAdicionarCategoriaState extends State<ContentAdicionarCategoria> {
  late CategoriaModel categoria;

  ///[Controllers]
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    categoria = widget.categoria ?? CategoriaModel();

    if (widget.categoria != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(categoria);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de descrção da categoria
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição da categoria',
              hintText: 'Informe a descrição da categoria',
              controller: descricaoController,
              onChanged: (descricao) {
                categoria.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição da categoria'),
              maxLength: 30,
            ),

            const SizedBox(height: 20),
            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.categoria == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
