import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/tipo-combustivel/tipo_combustivel_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarTipoCombustivel extends StatefulWidget {
  const ContentAdicionarTipoCombustivel({
    this.tipoCombustivel,
    super.key,
  });

  final TipoCombustivelModel? tipoCombustivel;

  @override
  State<ContentAdicionarTipoCombustivel> createState() => _ContentAdicionarTipoCombustivelState();
}

class _ContentAdicionarTipoCombustivelState extends State<ContentAdicionarTipoCombustivel> {
  late TipoCombustivelModel tipoCombustivel;

  ///[Controllers]
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    tipoCombustivel = widget.tipoCombustivel ?? TipoCombustivelModel();

    if (widget.tipoCombustivel != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(tipoCombustivel);
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
            // Campo de descrção da tipo combustivel
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição da Tipo Combustível',
              hintText: 'Informe a descrição da Tipo Combustível',
              controller: descricaoController,
              onChanged: (descricao) {
                tipoCombustivel.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição da Tipo Combustível'),
              maxLength: 30,
            ),

            const SizedBox(height: 20),
            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.tipoCombustivel == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
