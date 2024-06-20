import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../controllers/despesas/despesas_controller.dart';
import '../../services/dialog_service.dart';
import '../../utils/string_format_utils.dart';
import '../../widgets/cs_actions_button.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_sliver_app_bar.dart';
import '../../widgets/dialog-content/content_filtro_despesa.dart';
import 'dashboard_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final stateView = DashboardState();

  double? _maxYBarChart = 0;
  double? _maxY = 0;
  double? _minY = 0;

  @override
  void initState() {
    super.initState();

    _fetchTotalDespesas();
    _fetchDespesa();
  }

  void _verificaAxixY() {
    for (int i = 0; i < stateView.despesas.length; i++) {
      if (i == 0) {
        _maxY = stateView.despesas[i].precoTotal;
        _minY = stateView.despesas[i].precoTotal;
      }

      if (stateView.despesas[i].precoTotal! > _maxY!) {
        _maxY = stateView.despesas[i].precoTotal;
      } else if (stateView.despesas[i].precoTotal! < _minY!) {
        _minY = stateView.despesas[i].precoTotal;
      }
    }
  }

  void _verificaMaxYBarChart() {
    _maxYBarChart = max(stateView.totalAbastecimento, stateView.totalTrocaPneu);

    double op1 = max(stateView.totalServico, stateView.totalManutencao);
    double op2 = max(stateView.totalTrocaOleo, op1);

    _maxYBarChart = max(_maxYBarChart!, op2) + 50;
  }

  void _fetchDespesa() async {
    if (stateView.loading) return;

    try {
      stateView.setLoading(value: true);

      final despesas = await DespesasController().buscarDespesas();

      if (despesas.isEmpty) {
        stateView.setFinishLoading(value: true);
      } else {
        stateView.addAllDespesas(despesas);
      }

      _verificaAxixY();

      stateView.incPage();
    } catch (_) {
      stateView.setHasError(value: true);
    } finally {
      stateView.setLoading(value: false);
    }
  }

  void _fetchTotalDespesas() async {
    try {
      final totalDespesas = await DespesasController().buscaTotalDespesas();
      final mediaDespesas = await DespesasController().buscaMediaDespesas();

      final totalAbastecimento = await DespesasController().buscaTotalDespesaPorTipo(2);
      final totalTrocaPneu = await DespesasController().buscaTotalDespesaPorTipo(3);
      final totalTrocaOleo = await DespesasController().buscaTotalDespesaPorTipo(6);
      final totalServico = await DespesasController().buscaTotalDespesaPorTipo(4);
      final totalManutencao = await DespesasController().buscaTotalDespesaPorTipo(5);

      stateView.setTotalDespesas(value: totalDespesas);
      stateView.setMediaDespesas(value: mediaDespesas);

      stateView.setTotalAbastecimento(value: totalAbastecimento);
      stateView.setTotalTrocaPneu(value: totalTrocaPneu);
      stateView.setTotalTrocaOleo(value: totalTrocaOleo);
      stateView.setTotalServico(value: totalServico);
      stateView.setTotalManutencao(value: totalManutencao);

      _verificaMaxYBarChart();
    } catch (_) {}
  }

  void _openFiltros() async {
    FocusScope.of(context).unfocus();

    await openDialogWithContent(
      title: 'FILTROS DE DESPESAS',
      content: ContentFiltroDespesa(
        onSearch: () {
          if (!stateView.loading) {
            stateView.resetPage();

            _fetchDespesa();
            _fetchTotalDespesas();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // _verificaAxixY();
    _verificaMaxYBarChart();

    return Scaffold(
      body: CsSliverAppBar(
        title: 'Dashboard',
        actionsBottom: [
          // Botão de pesquisa
          CsActionsButton(
            color: Colors.blue[800],
            icon: const CsIcon(
              icon: Icons.search_rounded,
              color: Colors.white,
            ),
            label: 'PESQUISAR',
            onPressed: _openFiltros,
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: theme.cardColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Observer(
                      builder: (_) {
                        if (stateView.loading) {
                          return const CsCircularProgressIndicador.dark(withMessage: true);
                        }

                        return LineChart(
                          LineChartData(
                            minX: DateTime.now().month.toDouble(),
                            maxX: (DateTime.now().month.toDouble() + stateView.despesas.length.toDouble()) - 1,
                            minY: (_minY ?? 0) - 20 < 0 ? 0 : (_minY ?? 0) - 20,
                            maxY: _maxY,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                axisNameSize: 30,
                                axisNameWidget: const Text(
                                  'Meses',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textScaleFactor: 1,
                                ),
                                sideTitles: SideTitles(
                                  getTitlesWidget: (value, __) {
                                    return Text(
                                      '${value.toInt()}',
                                      textScaleFactor: 1,
                                    );
                                  },
                                  showTitles: true,
                                  interval: 1,
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                axisNameSize: 30,
                                axisNameWidget: Text(
                                  'Quantidade de Despesas',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textScaleFactor: 1,
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  getTitlesWidget: (value, __) {
                                    return Text(
                                      '${value.toInt()}',
                                      textScaleFactor: 1,
                                    );
                                  },
                                  interval: _maxY! / 7,
                                  showTitles: true,
                                  reservedSize: 30,
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                show: true,
                                color: const Color(0xFF03A85A),
                                barWidth: 3,
                                spots: stateView.despesas.map((e) {
                                  int indexOf = stateView.despesas.indexOf(e) + DateTime.now().month;

                                  return FlSpot(
                                    indexOf.toDouble(),
                                    e.precoTotal!,
                                  );
                                }).toList(),
                              ),
                            ],
                            lineTouchData: const LineTouchData(
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(tooltipBgColor: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: theme.cardColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    'Total de Despesas',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Observer(
                                        builder: (_) {
                                          return Text(
                                            monetario(stateView.totalDespesas, 'R\$')!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: theme.colorScheme.onSecondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Card(
                            color: theme.cardColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    'Média de Despesas',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Card(
                                    color: theme.colorScheme.secondary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Observer(
                                        builder: (_) {
                                          return Text(
                                            monetario(stateView.mediaDespesas, 'R\$')!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: theme.colorScheme.onSecondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Card(
                        color: theme.cardColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Observer(
                            builder: (_) {
                              return BarChart(
                                BarChartData(
                                  minY: 0,
                                  maxY: _maxYBarChart,
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.white,
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      axisNameSize: 30,
                                      axisNameWidget: const Text(
                                        'Imóveis',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textScaleFactor: 1,
                                      ),
                                      sideTitles: SideTitles(
                                        getTitlesWidget: (value, __) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return const Text('Imóvel A', textScaleFactor: 1);
                                            case 1:
                                              return const Text('Imóvel B', textScaleFactor: 1);
                                            case 2:
                                              return const Text('Imóvel C', textScaleFactor: 1);
                                            case 3:
                                              return const Text('Imóvel D', textScaleFactor: 1);
                                            case 4:
                                              return const Text('Imóvel E', textScaleFactor: 1);
                                            default:
                                              return const Text('', textScaleFactor: 1);
                                          }
                                        },
                                        showTitles: true,
                                        interval: 1,
                                      ),
                                    ),
                                    leftTitles: const AxisTitles(
                                      axisNameSize: 30,
                                      axisNameWidget: Text(
                                        'Total em Despesas',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textScaleFactor: 1,
                                      ),
                                    ),
                                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        getTitlesWidget: (value, __) {
                                          return Text(
                                            '${value.toInt()}',
                                            textScaleFactor: 1,
                                          );
                                        },
                                        interval: _maxYBarChart! / 10, // Ajuste o valor de intervalo conforme necessário
                                        showTitles: true,
                                        reservedSize: 40, // Aumente o tamanho reservado para as legendas
                                      ),
                                    ),
                                  ),
                                  barGroups: [
                                    BarChartGroupData(x: 0, barRods: [
                                      BarChartRodData(
                                        toY: stateView.totalAbastecimento,
                                        color: const Color(0xFF03A85A),
                                      )
                                    ]),
                                    BarChartGroupData(x: 1, barRods: [
                                      BarChartRodData(
                                        toY: stateView.totalTrocaPneu,
                                        color: Colors.blue,
                                      )
                                    ]),
                                    BarChartGroupData(x: 2, barRods: [
                                      BarChartRodData(
                                        toY: stateView.totalManutencao,
                                        color: Colors.brown,
                                      )
                                    ]),
                                    BarChartGroupData(x: 3, barRods: [
                                      BarChartRodData(
                                        toY: stateView.totalTrocaOleo,
                                        color: Colors.orange,
                                      )
                                    ]),
                                    BarChartGroupData(x: 4, barRods: [
                                      BarChartRodData(
                                        toY: stateView.totalManutencao,
                                        color: Colors.purple,
                                      )
                                    ]),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
