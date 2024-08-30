import '../../interfaces/idespesas.dart';
import '../../models/despesa/despesa_model.dart';
import '../../models/filtro-despesa/filtro_despesa_model.dart';
import '../../services/service_locator.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class DespesasController implements IDespesas {
  @override
  Future<List<DespesaModel>> buscarDespesas() async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('despesa').select('*, tipo_despesa!inner(descricao)');

    // Aplica o filtro por veículo, se fornecido
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().veiculo?.idVeiculo)) {
      queryBuilder = queryBuilder.eq('id_veiculo', getIt<FiltroDespesaModel>().veiculo!.idVeiculo!);
    }

    // Aplica o filtro por data inicial, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataInicial)) {
      queryBuilder = queryBuilder.gte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial)!);
    }

    // Aplica o filtro por data final, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataFinal)) {
      queryBuilder = queryBuilder.lte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal)!);
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => DespesaModel.fromMap(e)).toList();
  }

  @override
  Future<double> buscaMediaDespesas() async {
    // Inicializa a query básica para selecionar os valores de `preco_total`
    var queryBuilder = SupabaseService().client.from('despesa').select('preco_total');

    // Aplica o filtro por veículo, se fornecido
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().veiculo?.idVeiculo)) {
      queryBuilder = queryBuilder.eq('id_veiculo', getIt<FiltroDespesaModel>().veiculo!.idVeiculo!);
    }

    // Aplica o filtro por data inicial, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataInicial)) {
      queryBuilder = queryBuilder.gte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial)!);
    }

    // Aplica o filtro por data final, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataFinal)) {
      queryBuilder = queryBuilder.lte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal)!);
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    // Soma os valores de preco_total e conta o número de registros
    final total = response.fold<double>(
      0.0,
      (sum, despesa) => sum + (despesa['preco_total'] as num).toDouble(),
    );

    final count = response.length;

    // Calcula a média
    final media = count > 0 ? total / count : 0.0;

    return media;
  }

  @override
  Future<double> buscaTotalDespesas() async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('despesa').select('preco_total');

    // Aplica o filtro por veículo, se fornecido
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().veiculo?.idVeiculo)) {
      queryBuilder = queryBuilder.eq('id_veiculo', getIt<FiltroDespesaModel>().veiculo!.idVeiculo!);
    }

    // Aplica o filtro por data inicial, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataInicial)) {
      queryBuilder = queryBuilder.gte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial)!);
    }

    // Aplica o filtro por data final, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataFinal)) {
      queryBuilder = queryBuilder.lte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal)!);
    }

    // Executa a query e soma os valores de preco_total manualmente
    final response = await queryBuilder;
    return response.fold<double>(0.0, (sum, despesa) => sum + (despesa['preco_total'] as num).toDouble());
  }

  @override
  Future<double> buscaTotalDespesaPorTipo(int idTipoDespesa) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('despesa').select('preco_total').eq('id_tipo_despesa', idTipoDespesa);

    // Aplica o filtro por veículo, se fornecido
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().veiculo?.idVeiculo)) {
      queryBuilder = queryBuilder.eq('id_veiculo', getIt<FiltroDespesaModel>().veiculo!.idVeiculo!);
    }

    // Aplica o filtro por data inicial, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataInicial)) {
      queryBuilder = queryBuilder.gte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial)!);
    }

    // Aplica o filtro por data final, se fornecida
    if (!isNullOrEmpty(getIt<FiltroDespesaModel>().dataFinal)) {
      queryBuilder = queryBuilder.lte('data', uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal)!);
    }

    // Executa a query e soma os valores de preco_total manualmente
    final response = await queryBuilder;
    return response.fold<double>(0.0, (sum, despesa) => sum + (despesa['preco_total'] as num).toDouble());
  }

  @override
  Future<void> registrar(DespesaModel despesa) async {
    try {
      // Inserção de dados na tabela 'DESPESA'
      await SupabaseService().client.from('despesa').insert({
        "data": uploadDateFormat(despesa.data),
        "odometro": despesa.odometro,
        "preco_unitario": despesa.precoUnitario,
        "quantidade": despesa.quantidade,
        "preco_total": despesa.precoTotal,
        "descricao": despesa.descricao,
        "manutencao_preventiva": despesa.manutencaoPreventiva,
        "id_veiculo": despesa.veiculo?.idVeiculo,
        "id_local": despesa.local?.idLocal,
        "id_tipo_despesa": despesa.tipoDespesa?.idTipoDespesa,
        "id_tipo_combustivel": despesa.tipoCombustivel?.idTipoCombustivel,
        // "id_tipo_problema": despesa.tipoProblema?.idTipoProblema,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarDespesa(DespesaModel despesa) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('despesa').delete().eq('id_despesa', despesa.idDespesa!);
    } catch (_) {
      rethrow;
    }
  }
}
