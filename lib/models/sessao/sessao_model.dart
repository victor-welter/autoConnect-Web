// ignore_for_file: unused_element, prefer_final_fields

import 'package:mobx/mobx.dart';

part 'sessao_model.g.dart';

class SessaoModel = _SessaoModel with _$SessaoModel;

abstract class _SessaoModel with Store {
  _SessaoModel.fromMap(Map<String, dynamic> data) {
    cpfCnpj = data['cpf_cnpj'];
    nome = data['nome'];
    email = data['email'];
  }

  // Dados do usuário
  late String cpfCnpj;
  String? nome;
  String? email;
}
