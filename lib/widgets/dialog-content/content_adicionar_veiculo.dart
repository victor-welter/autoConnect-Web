import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import '../../extensions/context_ext.dart';
import '../../models/marca/marca_model.dart';
import '../../models/modelo/modelo_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentAdicionarVeiculo extends StatefulWidget {
  const ContentAdicionarVeiculo({
    this.veiculo,
    super.key,
  });

  final VeiculoModel? veiculo;

  @override
  State<ContentAdicionarVeiculo> createState() => _ContentAdicionarVeiculoState();
}

class _ContentAdicionarVeiculoState extends State<ContentAdicionarVeiculo> {
  late VeiculoModel veiculo;

  ///[Controllers]
  final anoController = TextEditingController();
  final placaController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    veiculo = widget.veiculo ?? VeiculoModel();

    if (widget.veiculo != null) {}
  }

  void _onSaveOrUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      context.pop(veiculo);
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
            // Campo de ano do veículo
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Ano do veículo',
              hintText: 'Informe o ano do veículo',
              controller: anoController,
              onChanged: (ano) {
                veiculo.ano = ano;
              },
              validator: (value) => validator(value, 'Informe o ano do veículo'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              maxLength: 4,
            ),

            const SizedBox(height: 10),

            // Campo de descrção da modelo
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Placa do veículo',
              hintText: 'Informe a placa do veículo',
              controller: placaController,
              onChanged: (placa) {
                veiculo.placa = placa;
              },
              validator: (value) => validator(value, 'Informe a placa do veículo'),
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
                  veiculo.marca = marca;
                  marcaController.text = marca.descricao!;
                }
              },
              obrigatorio: true,
              label: 'Marca do modelo',
              hintText: 'Selecione a marca do modelo',
              controller: marcaController,
              validator: (value) => validator(value, 'Selecione a marca do modelo'),
            ),

            CsTextFormField.secondary(
              onTap: () async {
                final args = {
                  'title': 'Selecionar Modelo',
                  'textEmpty': 'Nenhum modelo encontrado',
                  'dataType': SelectDataType.modelo,
                };

                final modelo = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                if (modelo is ModeloModel) {
                  veiculo.modelo = modelo;
                  marcaController.text = modelo.descricao!;
                }
              },
              obrigatorio: true,
              label: 'Modelo do veículo',
              hintText: 'Selecione o modelo do veículo',
              controller: marcaController,
              validator: (value) => validator(value, 'Selecione o modelo do veículo'),
            ),

            const SizedBox(height: 20),

            CsElevatedButton(
              width: context.width * 0.5,
              label: widget.veiculo == null ? 'ADICIONAR' : 'ATUALIZAR',
              onPressed: _onSaveOrUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
