import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/constants.dart';
import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import '../../extensions/context_ext.dart';
import '../../models/despesa/despesa_model.dart';
import '../../models/local/local_model.dart';
import '../../models/tipo-combustivel/tipo_combustivel_model.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../models/tipo-problema/tipo_problema_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../services/dialog_service.dart';
import '../../utils/functions_utils.dart';
import '../../utils/string_format_utils.dart';
import '../cs_elevated_button.dart';
import '../cs_radio_list_tile.dart';
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
  final tipoDespesaController = TextEditingController();
  final dataController = TextEditingController();
  final veiculoController = TextEditingController();
  final odometroController = TextEditingController();
  final localController = TextEditingController();
  final tipoCombustivelController = TextEditingController();
  final tipoProblemaController = TextEditingController();
  final descricaoController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    despesa = widget.despesa ?? DespesaModel();

    if (widget.despesa != null) {}
  }

  Future<void> _getData() async {
    FocusScope.of(context).unfocus();

    DateTime? data = await getDate(
      firstDate: DateTime.now().add(const Duration(days: -365 * 120)),
      lastDate: DateTime.now(),
    );

    if (data != null) {
      despesa.data = data;
      dataController.text = formatDateBR(data)!;
    }
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
            // Campo de tipo de despesa
            CsTextFormField.secondary(
              onTap: () async {
                final args = {
                  'title': 'Selecionar Tipo de Despesa',
                  'textEmpty': 'Nenhum tipo de despesa encontrado',
                  'dataType': SelectDataType.tipoDespesa,
                };

                final tipoDespesa = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                if (tipoDespesa is TipoDespesaModel) {
                  despesa.tipoDespesa = tipoDespesa;
                  tipoDespesaController.text = tipoDespesa.descricao!;
                }
              },
              obrigatorio: true,
              label: 'Tipo de despesa',
              hintText: 'Selecione o tipo de despesa',
              controller: tipoDespesaController,
              validator: (value) => validator(value, 'Selecione o tipo de despesa'),
              enabled: false,
            ),

            // Campo de manutenção
            Observer(
              builder: (_) {
                return Visibility(
                  visible: despesa.tipoDespesa?.idTipoDespesa == 5,
                  child: Container(
                    width: context.width * 0.4,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Manutenção Preventiva
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return CsRadioListTile<int>(
                                title: 'Manutenção Preventiva',
                                value: CadOptions.MANUTENCAO_PREVENTIVA,
                                groupValue: despesa.manutencaoPreventiva,
                                onChanged: (value) {
                                  despesa.manutencaoPreventiva = value;
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Manutenção Corretiva
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return CsRadioListTile<int>(
                                title: 'Manutenção Corretiva',
                                value: CadOptions.MANUTENCAO_CORRETIVA,
                                groupValue: despesa.manutencaoPreventiva,
                                onChanged: (value) {
                                  despesa.manutencaoPreventiva = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Campo de tipo de problema
            Observer(
              builder: (_) {
                return Visibility(
                  visible: despesa.tipoDespesa?.idTipoDespesa == 5,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: CsTextFormField.secondary(
                      onTap: () async {
                        final args = {
                          'title': 'Selecionar Tipo de Problema',
                          'textEmpty': 'Nenhum Tipo de Problema encontrado',
                          'dataType': SelectDataType.tipoProblema,
                        };

                        final tipoProblema = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                        if (tipoProblema is TipoProblemaModel) {
                          despesa.tipoProblema = tipoProblema;
                          tipoProblemaController.text = tipoProblema.descricao!;
                        }
                      },
                      obrigatorio: true,
                      label: 'Tipo de problema',
                      hintText: 'Selecione o tipo de problema',
                      controller: tipoProblemaController,
                      validator: (value) => validator(value, 'Selecione o tipo de problema'),
                      enabled: false,
                    ),
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
                  despesa.veiculo = veiculo;
                  veiculoController.text = veiculo.modelo!.descricao!;

                  // Atualiza o odometro
                  despesa.odometro = veiculo.odometro;
                  odometroController.text = veiculo.odometro.toString();
                }
              },
              obrigatorio: true,
              label: 'Veículo',
              hintText: 'Selecione o veículo',
              controller: veiculoController,
              validator: (value) => validator(value, 'Selecione o veículo'),
              enabled: false,
            ),

            const SizedBox(height: 10),

            // Campo de data da despesa
            CsTextFormField.secondary(
              onTap: _getData,
              obrigatorio: true,
              label: 'Data da despesa',
              hintText: 'Selecione a data da despesa',
              controller: dataController,
              validator: (value) => validator(value, 'Selecione a data da despesa'),
              enabled: false,
            ),

            const SizedBox(height: 10),

            // Campo de odometro
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Odômetro',
              hintText: 'Informe o odômetro',
              controller: odometroController,
              onChanged: (descricao) {
                despesa.odometro = double.tryParse(descricao) ?? 0;
              },
              validator: (value) => validator(value, 'Informe o odômetro'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            // Campo de descrição
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Descrição',
              hintText: 'Informe a descrição',
              controller: descricaoController,
              onChanged: (descricao) {
                despesa.descricao = descricao;
              },
              validator: (value) => validator(value, 'Informe a descrição'),
            ),

            const SizedBox(height: 10),

            // Campo de preço unitário
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Preço unitário',
              hintText: 'Informe o preço unitário',
              onChanged: (preco) {
                despesa.precoUnitario = double.tryParse(preco) ?? 0;
                despesa.precoTotal = (despesa.precoUnitario ?? 0) * (despesa.quantidade ?? 0);
              },
              validator: (value) => validator(value, 'Informe o preço unitário'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            // Campo de quantidade
            CsTextFormField.secondary(
              obrigatorio: true,
              label: 'Quantidade',
              hintText: 'Informe a quantidade',
              onChanged: (quantidade) {
                despesa.quantidade = double.tryParse(quantidade) ?? 0;
                despesa.precoTotal = (despesa.precoUnitario ?? 0) * (despesa.quantidade ?? 0);
              },
              validator: (value) => validator(value, 'Informe a quantidade'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            // Campo de preço total
            Observer(
              builder: (_) {
                return CsTextFormField.secondary(
                  label: 'Preço total',
                  hintText: 'Informe o preço total',
                  controller: TextEditingController(text: monetario(despesa.precoTotal)),
                  enabled: false,
                );
              },
            ),

            // Campo de tipo de combustível
            Observer(
              builder: (_) {
                return Visibility(
                  visible: despesa.tipoDespesa?.idTipoDespesa == 2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: CsTextFormField.secondary(
                      onTap: () async {
                        final args = {
                          'title': 'Selecionar Tipo de Combustível',
                          'textEmpty': 'Nenhum tipo de combustível encontrado',
                          'dataType': SelectDataType.tipoCombustivel,
                        };

                        final tipoCombustivel = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                        if (tipoCombustivel is TipoCombustivelModel) {
                          despesa.tipoCombustivel = tipoCombustivel;
                          tipoCombustivelController.text = tipoCombustivel.descricao!;
                        }
                      },
                      obrigatorio: true,
                      label: 'Tipo de combustível',
                      hintText: 'Selecione o tipo de combustível',
                      controller: tipoCombustivelController,
                      validator: (value) => validator(value, 'Selecione o tipo de combustível'),
                      enabled: false,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Campo de local
            CsTextFormField.secondary(
              onTap: () async {
                final args = {
                  'title': 'Selecionar Local',
                  'textEmpty': 'Nenhum local encontrado',
                  'dataType': SelectDataType.locais,
                };

                final local = await context.push(LocalRoutes.SELECIONA_REGISTRO, extra: args);

                if (local is LocalModel) {
                  despesa.local = local;
                  localController.text = local.nome!;
                }
              },
              obrigatorio: true,
              label: 'Local',
              hintText: 'Selecione o local',
              controller: localController,
              validator: (value) => validator(value, 'Selecione o local'),
              enabled: false,
            ),

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
