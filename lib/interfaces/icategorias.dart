import '../models/categoria/categoria_model.dart';

abstract class ICategorias {
  Future<List<CategoriaModel>> buscarCategorias(String where);

  Future<void> registrar(CategoriaModel categoria);

  Future<void> deletarCategoria(CategoriaModel categoria);
}
