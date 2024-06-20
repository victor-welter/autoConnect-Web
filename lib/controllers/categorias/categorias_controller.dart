import '../../interfaces/icategorias.dart';
import '../../models/categoria/categoria_model.dart';
import '../../repository/categorias/categorias_repository.dart';
import '../../utils/request_utils.dart';

class CategoriasController implements ICategorias {
  @override
  Future<List<CategoriaModel>> buscarCategorias(String where) async {
    final response = await CategoriaRepository.buscarCategorias(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => CategoriaModel.fromMap(e)).toList();
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
