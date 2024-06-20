class NotificacaoModel {
  NotificacaoModel();

  NotificacaoModel.fromMap(Map<String, dynamic> data) {
    idNotificacao = data['id_notificacao'];
    titulo = data['titulo'];
    descricao = data['descricao'];
  }

  int? idNotificacao;
  String? titulo;
  String? descricao;
}
