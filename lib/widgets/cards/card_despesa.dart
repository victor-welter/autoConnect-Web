import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/despesa/despesa_model.dart';
import '../../utils/functions_utils.dart';
import '../../utils/string_format_utils.dart';
import '../cs_icon.dart';
import '../cs_icon_button.dart';
import '../cs_inline_info.dart';

class CardDespesa extends StatelessWidget {
  const CardDespesa({
    required this.despesa,
    required this.onUpdate,
    required this.onDelete,
    this.marginBottom = 0,
    super.key,
  });

  final DespesaModel despesa;
  final Function(DespesaModel) onUpdate;
  final Function(DespesaModel) onDelete;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15).copyWith(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primaryContainer,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Nome do aplicativo
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  valorNull(despesa.tipoDespesa?.descricao),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 5),
                CsInlineInfo(
                  icon: const CsIcon(icon: Icons.calendar_month_rounded),
                  label: valorNull(formatDateBR(despesa.data)),
                ),
                CsInlineInfo(
                  icon: const CsIcon(icon: Icons.attach_money_rounded),
                  label: valorNull(monetario(despesa.precoTotal)),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botão de editar
              CsIconButton.light(
                icon: CsIcon(
                  size: 30,
                  icon: Icons.edit,
                  color: Colors.yellow[700],
                ),
                onPressed: () => onUpdate(despesa),
                tooltip: 'Atualizar',
              ),

              // Botão de deletar
              CsIconButton.light(
                icon: const CsIcon(
                  size: 30,
                  icon: Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () => onDelete(despesa),
                tooltip: 'Deletar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
