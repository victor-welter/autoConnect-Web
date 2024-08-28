import '../../interfaces/icategorias.dart';
import '../../models/categoria/categoria_model.dart';
import '../../repository/categorias/categorias_repository.dart';
import '../../services/supabase_service.dart';
import '../../utils/request_utils.dart';

class CategoriasController implements ICategorias {
  @override
  Future<List<CategoriaModel>> buscarCategorias(String where) async {
    // Busca todas as Categorias
    final response = await SupabaseService().client.from('categoria').select('*').order('descricao', ascending: true);

    return response.map((e) => CategoriaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(CategoriaModel categoria) async {
    try {
      final response = await CategoriaRepository.registrar(categoria);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarCategoria(CategoriaModel categoria) async {
    try {
      final response = await CategoriaRepository.deletarCategoria(categoria);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
