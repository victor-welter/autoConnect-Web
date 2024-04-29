// ignore_for_file: unused_element, prefer_final_fields

import 'package:mobx/mobx.dart';

part 'sessao_model.g.dart';

class SessaoModel = _SessaoModel with _$SessaoModel;

abstract class _SessaoModel with Store {
  _SessaoModel.fromDatabase(dynamic data) {
    userUuid = data['user_uuid'];
    usuario = data['usuario'];
  }

  _SessaoModel(this.userUuid, this.usuario);

  late final String userUuid;
  late final String usuario;

  // Dados do usuário
  String? cpfCnpj;
  String? nome;
  String? email;
}
