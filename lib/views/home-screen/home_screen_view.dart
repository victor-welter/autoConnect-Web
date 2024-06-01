import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/assets/assets_path.dart';
import '../../configs/constants.dart';
import '../../configs/enums.dart';
import '../../configs/routes/local_routes.dart';
import '../../extensions/context_ext.dart';
import '../../services/dialog_service.dart';
import '../../utils/string_format_utils.dart';
import '../../widgets/cards/card_despesa.dart';
import '../../widgets/cs_actions_button.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_header.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';
import '../../widgets/cs_sliver_app_bar.dart';
import '../../widgets/cs_text_button.dart';
import '../../widgets/dialog-content/content_adicionar_despesa.dart';
import '../../widgets/menu/cs_menu.dart';
import '../../widgets/nenhuma_informacao.dart';
import 'home_screen_state.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final stateView = HomeScreenState();

  void _onCreate() async {
    try {
      final newDespesa = await openDialogWithContent(
        title: 'ADICIONAR DESPESA',
        content: const ContentAdicionarDespesa(),
      );

      if (newDespesa != null) {
        // await AppsController().saveApp(newAplicativo);

        stateView.addDespesa(newDespesa);

        showSnackbar(description: 'Despesa adicionado', seconds: 2);
      }
    } catch (_) {
      showSnackbar(description: 'Erro ao adicionar o despesa', seconds: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: const CsMenu(),
      body: CsSliverAppBar(
        title: 'Seja bem-vindo ao ${App.NAME}',
        leading: CsIconButton.dark(
          icon: const CsIcon(
            icon: Icons.menu_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
              scaffoldKey.currentState?.openEndDrawer();
            } else {
              scaffoldKey.currentState?.openDrawer();
            }
          },
        ),
        actionsBottom: [
          CsActionsButton(
            color: Colors.green[800],
            icon: const CsIcon(
              icon: Icons.add_circle_outline_rounded,
              color: Colors.white,
            ),
            label: 'ADICIONAR',
            onPressed: _onCreate,
          )
        ],
        actions: [
          // Botão de voltar ao início
          CsTextButton(
            label: 'MEUS VEÍCULOS',
            fontSize: 18,
            color: Colors.white,
            onTap: () {
              final args = {
                'title': 'Selecionar Veículo',
                'textEmpty': 'Nenhum veículo encontrado',
                'dataType': SelectDataType.veiculo,
              };

              context.go(LocalRoutes.SELECIONA_REGISTRO, extra: args);
            },
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // lista todas as despesas
                    Expanded(
                      child: Card(
                        color: theme.cardColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const CsHeader.third(
                                title: 'Despesas',
                                icon: Icons.remove_circle_outline_rounded,
                              ),
                              Expanded(
                                child: Observer(
                                  builder: (_) {
                                    if (stateView.loading) {
                                      return const CsCircularProgressIndicador.dark(withMessage: true);
                                    }

                                    if (stateView.hasError) {
                                      return NenhumaInformacao(
                                        height: context.height * 0.25,
                                        width: context.width * 0.25,
                                        message: 'Aconteceu um erro inesperado. Por favor, tente novamente ou entre em contato com a equipe responsável.',
                                        imagePath: AssetsPath.ERROR_DATA,
                                        actions: [
                                          CsElevatedButton(
                                            height: 35,
                                            width: context.width * 0.6,
                                            label: 'Tentar novamente',
                                            onPressed: () {}, //TODO Buscar despesas
                                          ),
                                        ],
                                      );
                                    }

                                    if (stateView.despesas.isEmpty && !stateView.loading) {
                                      return NenhumaInformacao(
                                        height: context.height * 0.25,
                                        width: context.width * 0.25,
                                        imagePath: AssetsPath.NO_DATA,
                                        message: 'Nenhuma despesa cadastrada',
                                      );
                                    }

                                    return Scrollbar(
                                      radius: const Radius.circular(50),
                                      child: ListView.builder(
                                        itemCount: stateView.despesas.length,
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemBuilder: (_, index) {
                                          final despesa = stateView.despesas[index];

                                          return CardDespesa(
                                            despesa: despesa,
                                            onSelect: (_) {},
                                            onUpdate: (_) {},
                                            onDelete: (_) {},
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Count de despesas
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              color: theme.cardColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  CsIcon(
                                    icon: Icons.local_gas_station_rounded,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Abastecimento',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        monetario(stateView.totalAbastecimento, 'R\$')!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: theme.colorScheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Card(
                              color: theme.cardColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  CsIcon(
                                    icon: Icons.local_car_wash_rounded,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Troca de Pneu',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        monetario(stateView.totalTrocaPneu, 'R\$')!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: theme.colorScheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Card(
                              color: theme.cardColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  CsIcon(
                                    icon: Icons.oil_barrel_rounded,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Troca de Óleo',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        monetario(stateView.totalTrocaOleo, 'R\$')!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: theme.colorScheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Card(
                              color: theme.cardColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  CsIcon(
                                    icon: Icons.settings_rounded,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Serviços',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        monetario(stateView.totalServico, 'R\$')!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: theme.colorScheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Card(
                              color: theme.cardColor,
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  CsIcon(
                                    icon: Icons.build_rounded,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Manutenção Geral',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        monetario(stateView.totalManutencao, 'R\$')!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: theme.colorScheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
