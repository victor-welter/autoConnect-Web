import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import '../../extensions/context_ext.dart';
import '../../models/filtro-despesa/filtro_despesa_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../services/dialog_service.dart';
import '../../services/service_locator.dart';
import '../../utils/functions_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_text_form_field.dart';

class ContentFiltroDespesa extends StatefulWidget {
  const ContentFiltroDespesa({
    required this.onSearch,
    super.key,
  });

  final VoidCallback onSearch;

  @override
  State<ContentFiltroDespesa> createState() => _ContentFiltroDespesaState();
}

class _ContentFiltroDespesaState extends State<ContentFiltroDespesa> {
  final filtro = getIt<FiltroDespesaModel>();

  ///[Controllers]
  final veiculoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    veiculoController.text = filtro.veiculo?.modelo?.descricao ?? '';
  }

  void _selectDataInicial() async {
    FocusScope.of(context).unfocus();

    DateTime? data = await getDate(
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now(),
      initialDate: filtro.dataInicial,
    );

    if (data != null) {
      filtro.setDataInicial(data);
    }
  }

  void _selectDataFinal() async {
    FocusScope.of(context).unfocus();

    if (filtro.dataFinal?.isBefore(filtro.dataInicial!) ?? false) {
      filtro.setDataFinal(filtro.dataInicial);
    }

    DateTime? data = await getDate(
      firstDate: filtro.dataInicial ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: filtro.dataFinal,
    );

    if (data != null) {
      filtro.setDataFinal(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Campo de data inicial
          Observer(
            builder: (_) {
              return CsTextFormField.secondary(
                onTap: _selectDataInicial,
                label: 'Data Inicial',
                hintText: 'Selecione a data',
                controller: TextEditingController(text: formatDateBR(filtro.dataInicial)),
                enabled: false,
                suffixIcon: clearField(
                  value: filtro.dataInicial,
                  onClear: () {
                    filtro.setDataInicial(null);
                    widget.onSearch();
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // Campo de data final
          Observer(
            builder: (_) {
              return CsTextFormField.secondary(
                onTap: _selectDataFinal,
                label: 'Data Final',
                hintText: 'Selecione a data',
                controller: TextEditingController(text: formatDateBR(filtro.dataFinal)),
                enabled: false,
                suffixIcon: clearField(
                  value: filtro.dataFinal,
                  onClear: () {
                    filtro.setDataFinal(null);
                    widget.onSearch();
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // Campo de veículo
          CsTextFormField.secondary(
            onTap: () async {
              final args = {
                'title': 'Selecionar Veículo',
                'textEmpty': 'Nenhum veículo encontrado',
                'dataType': SelectDataType.veiculo,
              };

              final veiculo = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

              if (veiculo is VeiculoModel) {
                filtro.setVeiculo(veiculo);
                veiculoController.text = veiculo.modelo!.descricao!;
              }
            },
            obrigatorio: true,
            label: 'Veículo',
            hintText: 'Selecione o veículo',
            controller: veiculoController,
            enabled: false,
          ),

          const SizedBox(height: 20),

          // Button Pesquisar/Voltar
          CsElevatedButton(
            width: context.width * 0.5,
            label: 'Pesquisar',
            onPressed: () {
              widget.onSearch();
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
