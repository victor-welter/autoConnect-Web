import '../models/notificacao/notificacao_model.dart';

abstract class INotificacoes {
  Future<List<NotificacaoModel>> buscarNotificacoes();
}
