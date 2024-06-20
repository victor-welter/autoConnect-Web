import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/tipo-problema/tipo_problema_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarTipoProblema extends StatefulWidget {
  const ContentAdicionarTipoProblema({
    this.tipoProblema,
    super.key,
  });

  final TipoProblemaModel? tipoProblema;

  @override
  State<ContentAdicionarTipoProblema> createState() => _ContentAdicionarTipoProblemaState();
}

class _ContentAdicionarTipoProblemaState extends State<ContentAdicionarTipoProblema> {
  late TipoProblemaModel tipoProblema;

  ///[Controllers]
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    tipoProblema = widget.tipoProblema ?? TipoProblemaModel();

    if (widget.tipoProblema != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(tipoProblema);
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
            // Campo de descrção da tipo despesa
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição da Tipo Despesa',
              hintText: 'Informe a descrição da Tipo Despesa',
              controller: descricaoController,
              onChanged: (descricao) {
                tipoProblema.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição da Tipo Despesa'),
              maxLength: 30,
            ),

            const SizedBox(height: 20),
            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.tipoProblema == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
