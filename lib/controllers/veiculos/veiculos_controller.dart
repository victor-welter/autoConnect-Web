import '../../interfaces/iveiculos.dart';
import '../../models/sessao/sessao_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../services/service_locator.dart';
import '../../services/supabase_service.dart';
import '../../utils/functions_utils.dart';

class VeiculosController implements IVeiculos {
  @override
  Future<List<VeiculoModel>> buscarVeiculos(String where) async {
    // Inicializa a query básica
    var queryBuilder = SupabaseService().client.from('veiculo').select('*, modelo!inner(descricao), marca!inner(descricao)').eq('id_usuario', getIt<SessaoModel>().idUsuario);

    // Adiciona a condição where no campo de descrição do modelo se ela não estiver vazia
    if (isNullOrEmpty(where)) {
      queryBuilder = queryBuilder.ilike('modelo.descricao', '%$where%');
    }

    // Executa a query e obtém os resultados
    final response = await queryBuilder;

    return response.map((e) => VeiculoModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(VeiculoModel veiculo) async {
    try {
      // Inserção de dados na tabela 'VEICULO'
      await SupabaseService().client.from('veiculo').insert({
        'ano': veiculo.ano,
        'placa': veiculo.placa,
        'id_usuario': getIt<SessaoModel>().idUsuario,
        'id_marca': veiculo.marca!.idMarca,
        'id_modelo': veiculo.modelo!.idModelo,
        'odometro': veiculo.odometro,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarVeiculo(VeiculoModel veiculo) async {
    try {
      // Executa a query de deleção
      await SupabaseService().client.from('veiculo').delete().eq('id_veiculo', veiculo.idVeiculo!);
    } catch (_) {
      rethrow;
    }
  }
}
