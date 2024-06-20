import '../../configs/routes/web_routes.dart';
import '../../models/sessao/sessao_model.dart';
import '../../services/http_service.dart';
import '../../services/service_locator.dart';

class NotificacaoRepository {
  static Future<Map<String, dynamic>> buscarNotificacoes() async {
    Map params = {
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_NOTIFICACAO,
      params: params,
    );
  }
}
