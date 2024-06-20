import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../configs/assets/assets_path.dart';
import '../../configs/enums.dart';
import '../../controllers/categorias/categorias_controller.dart';
import '../../controllers/locais/locais_controller.dart';
import '../../controllers/marcas/marcas_controller.dart';
import '../../controllers/modelos/modelos_controller.dart';
import '../../controllers/notificacoes/notificacoes_controller.dart';
import '../../controllers/tipos-combustiveis/tipos_combustiveis_controller.dart';
import '../../controllers/tipos-despesas/tipos_despesas_controller.dart';
import '../../controllers/tipos-problemas/tipos_problemas_controller.dart';
import '../../controllers/veiculos/veiculos_controller.dart';
import '../../models/categoria/categoria_model.dart';
import '../../models/local/local_model.dart';
import '../../models/marca/marca_model.dart';
import '../../models/modelo/modelo_model.dart';
import '../../models/notificacao/notificacao_model.dart';
import '../../models/tipo-combustivel/tipo_combustivel_model.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../models/tipo-problema/tipo_problema_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../services/dialog_service.dart';
import '../../widgets/cards/card_categoria.dart';
import '../../widgets/cards/card_local.dart';
import '../../widgets/cards/card_marca.dart';
import '../../widgets/cards/card_modelo.dart';
import '../../widgets/cards/card_notificacao.dart';
import '../../widgets/cards/card_tipo_combustivel.dart';
import '../../widgets/cards/card_tipo_despesa.dart';
import '../../widgets/cards/card_tipo_problema.dart';
import '../../widgets/cards/card_veiculo.dart';
import '../../widgets/cs_actions_button.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_search_field.dart';
import '../../widgets/cs_sliver_app_bar.dart';
import '../../widgets/dialog-content/content_adicionar_categoria.dart';
import '../../widgets/dialog-content/content_adicionar_marca.dart';
import '../../widgets/dialog-content/content_adicionar_modelo.dart';
import '../../widgets/dialog-content/content_adicionar_tipo_combustivel.dart';
import '../../widgets/dialog-content/content_adicionar_tipo_problema.dart';
import '../../widgets/dialog-content/content_adicionar_veiculo.dart';
import '../../widgets/nenhuma_informacao.dart';
import 'selecionar_registro_state.dart';

class SelecionaRegistroView extends StatefulWidget {
  const SelecionaRegistroView({
    required this.title,
    required this.textEmpty,
    required this.dataType,
    this.hasFilter = true,
    this.hasAdd = true,
    this.extra,
    super.key,
  });

  final String title;
  final String textEmpty;
  final SelectDataType dataType;
  final bool hasFilter;
  final bool hasAdd;
  final dynamic extra;

  @override
  State<SelecionaRegistroView> createState() => _SelecionaRegistroViewState();
}

class _SelecionaRegistroViewState extends State<SelecionaRegistroView> {
  final stateView = SelecionarRegistroState();

  final scrollController = ScrollController();
  final whereFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  void dispose() {
    stateView.resetWhere();

    scrollController.dispose();
    whereFocusNode.dispose();

    super.dispose();
  }

  void _fetch() async {
    if (stateView.loading) return;

    try {
      stateView.setLoading(value: true);

      final registros = switch (widget.dataType) {
        SelectDataType.categoria => await CategoriasController().buscarCategorias(stateView.where ?? ''),
        SelectDataType.locais => await LocaisController().buscarLocais(stateView.where ?? ''),
        SelectDataType.marca => await MarcasController().buscarMarcas(stateView.where ?? ''),
        SelectDataType.modelo => await ModelosController().buscarModelos(stateView.where ?? ''),
        SelectDataType.veiculo => await VeiculosController().buscarVeiculos(stateView.where ?? ''),
        SelectDataType.tipoCombustivel => await TiposCombustiveisController().buscarTiposCombustiveis(stateView.where ?? ''),
        SelectDataType.tipoDespesa => await TiposDespesasController().buscarTiposDespesas(stateView.where ?? ''),
        SelectDataType.tipoProblema => await TiposProblemasController().buscarTiposProblemas(stateView.where ?? ''),
        SelectDataType.notificacao => await NotificacoesController().buscarNotificacoes(),
      };

      if (registros.isEmpty) {
        stateView.setFinishLoading(value: true);
      } else {
        stateView.addRegistros(registros);
      }

      stateView.incPage();
    } catch (_) {
      stateView.setHasError(value: true);
    } finally {
      stateView.setLoading(value: false);
    }
  }

  void _onSearch(String? where) {
    stateView.setWhere(where: where);

    if (!stateView.loading) {
      _onRefresh();
    }
  }

  ///Quando o usuário decide informar o bairro/logradouro manualmente
  void _onAddRegister() async {
    try {
      final newRegistro = switch (widget.dataType) {
        SelectDataType.categoria => await openDialogWithContent(title: 'Adicionar Categoria', content: const ContentAdicionarCategoria()),
        SelectDataType.marca => await openDialogWithContent(title: 'Adicionar Marca', content: const ContentAdicionarMarca()),
        SelectDataType.modelo => await openDialogWithContent(title: 'Adicionar Modelo', content: const ContentAdicionarModelo()),
        SelectDataType.veiculo => await openDialogWithContent(title: 'Adicionar Veículo', content: const ContentAdicionarVeiculo()),
        SelectDataType.tipoCombustivel => await openDialogWithContent(title: 'Adicionar Tipo Combustível', content: const ContentAdicionarTipoCombustivel()),
        SelectDataType.tipoProblema => await openDialogWithContent(title: 'Adicionar Tipo Problema', content: const ContentAdicionarTipoProblema()),
        _ => null,
      };

      if (newRegistro != null) {
        switch (widget.dataType) {
          case SelectDataType.categoria:
            await CategoriasController().registrar(newRegistro);
            break;
          case SelectDataType.locais:
            await LocaisController().registrar(newRegistro);
            break;
          case SelectDataType.marca:
            await MarcasController().registrar(newRegistro);
            break;
          case SelectDataType.modelo:
            await ModelosController().registrar(newRegistro);
            break;
          case SelectDataType.veiculo:
            await VeiculosController().registrar(newRegistro);
            break;
          case SelectDataType.tipoCombustivel:
            await TiposCombustiveisController().registrar(newRegistro);
            break;
          case SelectDataType.tipoDespesa:
            await TiposDespesasController().registrar(newRegistro);
            break;
          case SelectDataType.tipoProblema:
            await TiposProblemasController().registrar(newRegistro);
            break;
          default:
            throw Exception();
        }

        stateView.addRegistro(newRegistro);

        showSnackbar(description: 'Registro salvo com sucesso!', seconds: 2);
      }
    } catch (_) {
      showSnackbar(description: 'Erro ao salvar registro!', seconds: 2);
    }
  }

  void _onSelect(dynamic item) {
    context.pop(item);
  }

  void _onDelete(dynamic item) async {
    try {
      switch (widget.dataType) {
        case SelectDataType.categoria:
          await CategoriasController().deletarCategoria(item);
          break;
        case SelectDataType.locais:
          await LocaisController().deletarLocal(item);
          break;
        case SelectDataType.marca:
          await MarcasController().deletarMarca(item);
          break;
        case SelectDataType.modelo:
          await ModelosController().deletarModelo(item);
          break;
        case SelectDataType.veiculo:
          await VeiculosController().deletarVeiculo(item);
          break;
        case SelectDataType.tipoCombustivel:
          await TiposCombustiveisController().deletarTipoCombustivel(item);
          break;
        case SelectDataType.tipoDespesa:
          await TiposDespesasController().deletarTipoDespesa(item);
          break;
        case SelectDataType.tipoProblema:
          await TiposProblemasController().deletarTipoProblema(item);
          break;
        default:
          throw Exception();
      }

      stateView.removeRegistro(item);

      showSnackbar(description: 'Registro deletado com sucesso!', seconds: 2);
    } catch (_) {
      showSnackbar(description: 'Erro ao deletar registro!', seconds: 2);
    }
  }

  void _onUpdate(dynamic item) async {
    try {
      // TODO Implementar update

      showSnackbar(description: 'Registro atualizado com sucesso!', seconds: 2);
    } catch (_) {
      showSnackbar(description: 'Erro ao atualizar registro!', seconds: 2);
    }
  }

  void _onRefresh() async {
    stateView.onFilter();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CsSliverAppBar(
        title: widget.title,
        actionsBottom: [
          // Campo de pesquisa
          Visibility(
            visible: widget.hasFilter,
            child: Observer(
              builder: (_) {
                return CsSearchField(
                  where: stateView.where,
                  onSearch: _onSearch,
                  focus: whereFocusNode,
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          // Botão de adicionar
          Visibility(
            visible: widget.hasAdd,
            child: CsActionsButton(
              color: Colors.green[800],
              icon: const CsIcon(
                icon: Icons.add_circle_outline_rounded,
                color: Colors.white,
              ),
              label: 'ADICIONAR',
              onPressed: _onAddRegister,
            ),
          )
        ],
        body: Observer(
          builder: (_) {
            if (stateView.loading) {
              return const CsCircularProgressIndicador.dark(withMessage: true);
            }

            if (stateView.hasError) {
              return NenhumaInformacao(
                message: 'Aconteceu um erro inesperado. Por favor, tente novamente ou entre em contato com a equipe responsável.',
                imagePath: AssetsPath.ERROR_DATA,
                actions: [
                  CsElevatedButton(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.8,
                    label: 'Tentar novamente',
                    onPressed: _fetch,
                  ),
                ],
              );
            }

            if (stateView.registros.isEmpty && !stateView.loading) {
              return NenhumaInformacao(
                imagePath: AssetsPath.NO_DATA,
                message: widget.textEmpty,
              );
            }

            return Scrollbar(
              radius: const Radius.circular(50),
              child: ListView.builder(
                itemCount: stateView.registros.length + (stateView.loading ? 1 : 0),
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                controller: scrollController,
                itemBuilder: (_, index) {
                  if (index < stateView.registros.length) {
                    final item = stateView.registros[index];
                    double marginBottom = index == stateView.registros.length - 1 ? 80 : 0;

                    if (item is CategoriaModel) return CardCategoria(categoria: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is LocalModel) return CardLocal(local: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is MarcaModel) return CardMarca(marca: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is ModeloModel) return CardModelo(modelo: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is VeiculoModel) return CardVeiculo(veiculo: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is TipoCombustivelModel) return CardTipoCombustivel(tipoCombustivel: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is TipoDespesaModel) return CardTipoDespesa(tipoDespesa: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is TipoProblemaModel) return CardTipoProblema(tipoProblema: item, onSelect: _onSelect, onDelete: _onDelete, onUpdate: _onUpdate, marginBottom: marginBottom);
                    if (item is NotificacaoModel) return CardNotificacao(notificacao: item, marginBottom: marginBottom);

                    return const SizedBox();
                  }

                  return const CsCircularProgressIndicador.dark(
                    margin: EdgeInsets.all(5),
                    size: 20,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
