import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarTipoDespesa extends StatefulWidget {
  const ContentAdicionarTipoDespesa({
    this.tipoDespesa,
    super.key,
  });

  final TipoDespesaModel? tipoDespesa;

  @override
  State<ContentAdicionarTipoDespesa> createState() => _ContentAdicionarTipoDespesaState();
}

class _ContentAdicionarTipoDespesaState extends State<ContentAdicionarTipoDespesa> {
  late TipoDespesaModel tipoDespesa;

  ///[Controllers]
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    tipoDespesa = widget.tipoDespesa ?? TipoDespesaModel();

    if (widget.tipoDespesa != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(tipoDespesa);
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
                tipoDespesa.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição da Tipo Despesa'),
              maxLength: 30,
            ),

            const SizedBox(height: 20),
            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.tipoDespesa == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
