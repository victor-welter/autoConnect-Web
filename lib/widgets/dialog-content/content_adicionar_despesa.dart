import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_ext.dart';
import '../../models/despesa/despesa_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarDespesa extends StatefulWidget {
  const ContentAdicionarDespesa({
    this.despesa,
    super.key,
  });

  final DespesaModel? despesa;

  @override
  State<ContentAdicionarDespesa> createState() => _ContentAdicionarDespesaState();
}

class _ContentAdicionarDespesaState extends State<ContentAdicionarDespesa> {
  late DespesaModel despesa;

  ///[Controllers]
  final dataController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    despesa = widget.despesa ?? DespesaModel();

    if (widget.despesa != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(despesa);
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
            // Campo de data da despesa
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Data da despesa',
              hintText: 'Selecione a data da despesa',
              controller: dataController,
              onChanged: (descricao) {
                // aplicativo.nome = descricao;
              },
              validator: (value) => validator(value, 'Selecione a data da despesa'),
              maxLength: 30,
            ),

            const SizedBox(height: 10),

            // Campo de odometro
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Odômetro',
              hintText: 'Informe o odômetro',
              onChanged: (descricao) {
                // aplicativo.nome = descricao;
              },
              validator: (value) => validator(value, 'Informe o odômetro'),
              maxLength: 30,
            ),

            const SizedBox(height: 10),

            // Campo de preço unitário
            // Campo de quantidade
            // Campo de preço total
            // Campo de veículo
            // Campo de local
            // Campo de tipo de despesa
            // Campo de tipo de combustível

            const SizedBox(height: 20),

            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.despesa == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
