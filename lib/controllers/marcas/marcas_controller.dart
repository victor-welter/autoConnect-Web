import '../../interfaces/imarcas.dart';
import '../../models/marca/marca_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class MarcasController implements IMarcas {
  @override
  Future<List<MarcaModel>> buscarMarcas(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('marca').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => MarcaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(MarcaModel marca) async {
    try {
      // Inserção de dados na tabela 'MARCA'
      await SupabaseService().client.from('marca').insert({
        'descricao': marca.descricao,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarMarca(MarcaModel marca) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('marca').delete().eq('id_marca', marca.idMarca!);
    } catch (_) {
      rethrow;
    }
  }
}
