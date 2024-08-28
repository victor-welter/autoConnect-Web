import '../../interfaces/ilocais.dart';
import '../../models/local/local_model.dart';
import '../../repository/locais/locais_repository.dart';
import '../../services/supabase_service.dart';
import '../../utils/request_utils.dart';

class LocaisController implements ILocais {
  @override
  Future<List<LocalModel>> buscarLocais(String where) async {
    // Busca todos os locais
    final response = await SupabaseService().client.from('local').select('*').order('descricao', ascending: true);

    return response.map((e) => LocalModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(LocalModel local) async {
    try {
      final response = await LocalRepository.registrar(local);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarLocal(LocalModel local) async {
    try {
      final response = await LocalRepository.deletarLocal(local);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
