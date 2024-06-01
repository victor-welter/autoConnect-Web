import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/marca/marca_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarMarca extends StatefulWidget {
  const ContentAdicionarMarca({
    this.marca,
    super.key,
  });

  final MarcaModel? marca;

  @override
  State<ContentAdicionarMarca> createState() => _ContentAdicionarMarcaState();
}

class _ContentAdicionarMarcaState extends State<ContentAdicionarMarca> {
  late MarcaModel marca;

  ///[Controllers]
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    marca = widget.marca ?? MarcaModel();

    if (widget.marca != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(marca);
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
            // Campo de descrção da marca
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição da marca',
              hintText: 'Informe a descrição da marca',
              controller: descricaoController,
              onChanged: (descricao) {
                marca.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição da marca'),
            ),

            const SizedBox(height: 20),
            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.marca == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
