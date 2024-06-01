import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/despesa/despesa_model.dart';
import '../cs_icon.dart';
import '../cs_icon_button.dart';

class CardDespesa extends StatelessWidget {
  const CardDespesa({
    required this.despesa,
    required this.onSelect,
    required this.onUpdate,
    required this.onDelete,
    this.marginBottom = 0,
    super.key,
  });

  final DespesaModel despesa;
  final void Function(DespesaModel) onSelect;
  final Function(DespesaModel) onUpdate;
  final Function(DespesaModel) onDelete;
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
          onTap: () => onSelect(despesa),
          borderRadius: BorderRadius.circular(15),
          splashColor: theme.colorScheme.primary,
          focusColor: theme.colorScheme.primary,
          hoverColor: theme.colorScheme.primary,
          highlightColor: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Nome do aplicativo
                Expanded(
                  child: AutoSizeText(
                    despesa.odometro!,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 30,
                    ),
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
                  onPressed: () => onUpdate(despesa),
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
                  onPressed: () => onDelete(despesa),
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
