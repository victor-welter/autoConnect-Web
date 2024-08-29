import '../../interfaces/imodelos.dart';
import '../../models/modelo/modelo_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class ModelosController implements IModelos {
  @override
  Future<List<ModeloModel>> buscarModelos(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('modelo').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => ModeloModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(ModeloModel modelo) async {
    try {
      // Inserção de dados na tabela 'MODELO'
      await SupabaseService().client.from('modelo').insert({
        'descricao': modelo.descricao,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarModelo(ModeloModel modelo) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('modelo').delete().eq('id_modelo', modelo.idModelo!);
    } catch (_) {
      rethrow;
    }
  }
}
