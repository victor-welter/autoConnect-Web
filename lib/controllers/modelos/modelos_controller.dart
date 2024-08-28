import '../../interfaces/imodelos.dart';
import '../../models/modelo/modelo_model.dart';
import '../../repository/modelos/modelos_repository.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';
import '../../utils/request_utils.dart';

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
      final response = await ModeloRepository.registrar(modelo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarModelo(ModeloModel modelo) async {
    try {
      final response = await ModeloRepository.deletarModelo(modelo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
