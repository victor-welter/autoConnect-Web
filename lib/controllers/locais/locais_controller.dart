import '../../interfaces/ilocais.dart';
import '../../models/local/local_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class LocaisController implements ILocais {
  @override
  Future<List<LocalModel>> buscarLocais(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('local').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => LocalModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(LocalModel local) async {
    try {
      // Inserção de dados na tabela 'LOCAL'
      await SupabaseService().client.from('local').insert({
        'nome': local.nome,
        'endereco': local.endereco,
        'id_categoria': local.categoria!.idCategoria,
        // 'latitude': local.latitude,
        // 'longitude': local.longitude,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarLocal(LocalModel local) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('local').delete().eq('id_local', local.idLocal!);
    } catch (_) {
      rethrow;
    }
  }
}
