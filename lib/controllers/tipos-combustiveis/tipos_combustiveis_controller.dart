import '../../interfaces/itipos_combustiveis.dart';
import '../../models/tipo-combustivel/tipo_combustivel_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class TiposCombustiveisController implements ITiposCombustiveis {
  @override
  Future<List<TipoCombustivelModel>> buscarTiposCombustiveis(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('tipo_combustivel').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => TipoCombustivelModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(TipoCombustivelModel tiposCombustivel) async {
    try {
      // Inserção de dados na tabela 'TIPO_COMBUSTIVEL'
      await SupabaseService().client.from('tipo_combustivel').insert({
        'descricao': tiposCombustivel.descricao,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarTipoCombustivel(TipoCombustivelModel tiposCombustivel) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('tipo_combustivel').delete().eq('id_tipo_combustivel', tiposCombustivel.idTipoCombustivel!);
    } catch (_) {
      rethrow;
    }
  }
}
