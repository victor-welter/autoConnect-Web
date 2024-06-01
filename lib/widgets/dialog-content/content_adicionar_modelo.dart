import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import '../../extensions/context_ext.dart';
import '../../models/marca/marca_model.dart';
import '../../models/modelo/modelo_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarModelo extends StatefulWidget {
  const ContentAdicionarModelo({
    this.modelo,
    super.key,
  });

  final ModeloModel? modelo;

  @override
  State<ContentAdicionarModelo> createState() => _ContentAdicionarModeloState();
}

class _ContentAdicionarModeloState extends State<ContentAdicionarModelo> {
  late ModeloModel modelo;

  ///[Controllers]
  final descricaoController = TextEditingController();
  final marcaController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    modelo = widget.modelo ?? ModeloModel();

    if (widget.modelo != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(modelo);
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
            // Campo de descrção da modelo
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição do modelo',
              hintText: 'Informe a descrição do modelo',
              controller: descricaoController,
              onChanged: (descricao) {
                modelo.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição do modelo'),
            ),

            const SizedBox(height: 10),

            // Campo de seleção de marca
            CsTextFormField.secondary(
              onTap: () async {
                final args = {
                  'title': 'Selecionar Marca',
                  'textEmpty': 'Nenhuma marca encontrada',
                  'dataType': SelectDataType.marca,
                };

                final marca = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                if (marca is MarcaModel) {
                  modelo.marca = marca;
                  marcaController.text = marca.descricao!;
                }
              },
              obrigatorio: true,
              label: 'Marca do modelo',
              hintText: 'Selecione a marca do modelo',
              controller: marcaController,
              validator: (value) => validator(value, 'Selecione a marca do modelo'),
            ),

            const SizedBox(height: 20),

            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.modelo == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
