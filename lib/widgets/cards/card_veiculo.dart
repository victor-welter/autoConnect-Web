import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/veiculo/veiculo_model.dart';
import '../../utils/string_format_utils.dart';
import '../cs_icon.dart';
import '../cs_icon_button.dart';
import '../cs_inline_info.dart';

class CardVeiculo extends StatelessWidget {
  const CardVeiculo({
    required this.veiculo,
    required this.onSelect,
    required this.onUpdate,
    required this.onDelete,
    this.marginBottom = 0,
    super.key,
  });

  final VeiculoModel veiculo;
  final void Function(VeiculoModel) onSelect;
  final Function(VeiculoModel) onUpdate;
  final Function(VeiculoModel) onDelete;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 10,
      color: theme.colorScheme.secondary,
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20, bottom: marginBottom),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => onSelect(veiculo),
          borderRadius: BorderRadius.circular(15),
          splashColor: theme.colorScheme.primary,
          focusColor: theme.colorScheme.primary,
          hoverColor: theme.colorScheme.primary,
          highlightColor: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Nome do descrição
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        '${valorNull(veiculo.modelo?.descricao)} - ${veiculo.ano}',
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primaryContainer,
                          fontSize: 30,
                        ),
                      ),
                      AutoSizeText(
                        valorNull(veiculo.marca?.descricao),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primaryContainer,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CsInlineInfo(
                        icon: const CsIcon(icon: Icons.local_car_wash_rounded),
                        label: 'Odômetro',
                        info: valorNull(veiculo.odometro.toString()),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Botão de editar
                CsIconButton.light(
                  icon: CsIcon(
                    size: 40,
                    icon: Icons.edit,
                    color: Colors.yellow[700],
                  ),
                  onPressed: () => onUpdate(veiculo),
                  tooltip: 'Atualizar',
                ),

                const SizedBox(width: 10),

                // Botão de deletar
                CsIconButton.light(
                  icon: const CsIcon(
                    size: 40,
                    icon: Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () => onDelete(veiculo),
                  tooltip: 'Deletar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
