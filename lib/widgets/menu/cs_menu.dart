import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import 'cs_button_item_menu.dart';

class CsMenu extends StatefulWidget {
  const CsMenu({super.key});

  @override
  State<CsMenu> createState() => _CsMenuState();
}

class _CsMenuState extends State<CsMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      elevation: 3,
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            // Botão de tela inicial
            CsButtonItemMenu(
              title: 'Tela Inicial',
              icon: Icons.home_outlined,
              onTap: () => Scaffold.of(context).openEndDrawer(),
            ),

            // Botão de tela de categorias
            CsButtonItemMenu(
              title: 'Categorias',
              icon: Icons.home_outlined,
              onTap: () {
                final args = {
                  'title': 'Selecionar Categoria',
                  'textEmpty': 'Nenhuma categoria encontrada',
                  'dataType': SelectDataType.categoria,
                };

                context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
              },
            ),

            // Botão de tela de Marcas
            CsButtonItemMenu(
              title: 'Marcas',
              icon: Icons.home_outlined,
              onTap: () {
                final args = {
                  'title': 'Selecionar Marca',
                  'textEmpty': 'Nenhuma marca encontrada',
                  'dataType': SelectDataType.marca,
                };

                context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
              },
            ),

            // Botão de tela de Modelos
            CsButtonItemMenu(
              title: 'Modelos',
              icon: Icons.home_outlined,
              onTap: () {
                final args = {
                  'title': 'Selecionar Modelo',
                  'textEmpty': 'Nenhum modelo encontrado',
                  'dataType': SelectDataType.modelo,
                };

                context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
              },
            ),

            // Botão de tela de Tipos de Combustível
            CsButtonItemMenu(
              title: 'Tipos de Combustível',
              icon: Icons.home_outlined,
              onTap: () {
                final args = {
                  'title': 'Selecionar Tipo de Combustível',
                  'textEmpty': 'Nenhum tipo de combustível encontrado',
                  'dataType': SelectDataType.tipoCombustivel,
                };

                context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
              },
            ),

            // Botão de tela de Tipos de Despesas
            CsButtonItemMenu(
              title: 'Tipos de Despesas',
              icon: Icons.home_outlined,
              onTap: () {
                final args = {
                  'title': 'Selecionar Tipo de Despesa',
                  'textEmpty': 'Nenhum tipo de despesa encontrado',
                  'dataType': SelectDataType.tipoCombustivel,
                };

                context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
              },
            ),

            // Botão de tela de Veiculos
          ],
        ),
      ),
    );
  }
}
