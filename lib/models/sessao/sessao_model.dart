// ignore_for_file: unused_element, prefer_final_fields

import 'package:mobx/mobx.dart';

import '../../utils/functions_utils.dart';

part 'sessao_model.g.dart';

class SessaoModel = _SessaoModel with _$SessaoModel;

abstract class _SessaoModel with Store {
  _SessaoModel.fromDatabase(dynamic data) {
    userUuid = data['user_uuid'];
    usuario = data['usuario'];
    _permissoes = convertPermission(data['permissao']).asObservable();
  }

  _SessaoModel(this.userUuid, this.usuario);

  late final String userUuid;
  late final String usuario;

  @observable
  ObservableList<int> _permissoes = ObservableList();

  @computed
  List<int> get permissoes => [..._permissoes];

  @action
  void setPermissoes(List<int> permissoes) {
    _permissoes = permissoes.asObservable();
  }
}
