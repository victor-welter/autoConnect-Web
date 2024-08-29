import '../../interfaces/itipos_despesas.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class TiposDespesasController implements ITiposDespesas {
  @override
  Future<List<TipoDespesaModel>> buscarTiposDespesas(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('tipo_despesa').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => TipoDespesaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(TipoDespesaModel tipoDespesa) async {
    try {
      // Inserção de dados na tabela 'TIPO_DESPESA'
      await SupabaseService().client.from('tipo_despesa').insert({
        'descricao': tipoDespesa.descricao,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarTipoDespesa(TipoDespesaModel tipoDespesa) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('tipo_despesa').delete().eq('id_tipo_despesa', tipoDespesa.idTipoDespesa!);
    } catch (_) {
      rethrow;
    }
  }
}
