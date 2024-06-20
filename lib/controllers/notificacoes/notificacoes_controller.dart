import '../../interfaces/inotificacoes.dart';
import '../../models/notificacao/notificacao_model.dart';
import '../../repository/notificacoes/notificacoes_repository.dart';
import '../../utils/request_utils.dart';

class NotificacoesController implements INotificacoes {
  @override
  Future<List<NotificacaoModel>> buscarNotificacoes() async {
    final response = await NotificacaoRepository.buscarNotificacoes();

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => NotificacaoModel.fromMap(e)).toList();
  }
}
