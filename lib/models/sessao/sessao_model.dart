// ignore_for_file: unused_element, prefer_final_fields

import 'package:mobx/mobx.dart';

part 'sessao_model.g.dart';

class SessaoModel = _SessaoModel with _$SessaoModel;

abstract class _SessaoModel with Store {
  _SessaoModel.fromMap(Map<String, dynamic> data) {
    idUsuario = data['id_usuario'];
    email = data['email'];
    nome = data['nome'];
  }

  // Dados do usuário
  late int idUsuario;
  late String email;
  String? nome;
}
