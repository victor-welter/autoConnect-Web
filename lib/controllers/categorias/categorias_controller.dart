import '../../interfaces/icategorias.dart';
import '../../models/categoria/categoria_model.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class CategoriasController implements ICategorias {
  @override
  Future<List<CategoriaModel>> buscarCategorias(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('categoria').select('*');

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (!isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => CategoriaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(CategoriaModel categoria) async {
    try {
      // Inserção de dados na tabela 'CATEGORIA'
      await SupabaseService().client.from('categoria').insert({
        'descricao': categoria.descricao,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarCategoria(CategoriaModel categoria) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('categoria').delete().eq('id_categoria', categoria.idCategoria!);
    } catch (_) {
      rethrow;
    }
  }
}
