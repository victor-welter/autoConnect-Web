import 'package:validators/validators.dart' as validators;

import '../configs/constants.dart';
import '../utils/functions_utils.dart';

mixin ValidationsMixin {
  /// Combina uma lista de validadores e retorna a primeira mensagem de erro encontrada
  String? combine(List<String? Function()> validators) {
    for (var validator in validators) {
      var message = validator();
      if (!isNullOrEmpty(message)) {
        return message;
      }
    }

    return null;
  }

  /// Verifica se o valor é nulo ou vazio
  String? isNotEmpty(dynamic value, [String? message]) {
    if (isNullOrEmpty(value)) {
      return message ?? 'Este campo é obrigatório';
    }

    return null;
  }

  /// Verifica se o valor é completo, ou seja, se possui duas partes
  String? hasPartName(String? value, [String? message]) {
    List<String> partsName = value!.split(' ');

    if (partsName.length == 1) {
      return message ?? 'Informe o seu nome completo';
    } else {
      if (partsName.length >= 2) {
        if (partsName[1].trim() == '') {
          return message ?? 'Informe o seu nome completo';
        }
      }
    }

    return null;
  }

  /// Verifica se a length do valor é menor que o valor informado
  String? hasLength(String? value, int length, [String? message]) {
    if (value!.length != length) {
      return message ?? 'Este campo deve ter $length caracteres';
    }

    return null;
  }

  /// Verifica se a length do valor é menor que o valor informado
  String? hasMinLength(String? value, int length, [String? message]) {
    if (value!.length < length) {
      return message ?? 'Este campo deve ter no mínimo $length caracteres';
    }

    return null;
  }

  /// Verifica se a length do valor é maior que o valor informado
  String? hasMaxLength(String? value, int length, [String? message]) {
    if (value!.length > length) {
      return message ?? 'Este campo deve ter no máximo $length caracteres';
    }

    return null;
  }

  /// Verificar se a length do valor está entre os valores informados
  String? hasRangeLength(String? value, int min, int max, [String? message]) {
    if (value!.length < min || value.length > max) {
      return message ?? 'Este campo deve ter entre $min e $max caracteres';
    }

    return null;
  }

  /// Verifica se a length do valor não está entre os valores informados
  String? hasNotRangeLength(String? value, int min, int max, [String? message]) {
    if (value!.length > min && value.length < max) {
      return message ?? 'Este campo não deve ter entre $min e $max caracteres';
    }

    return null;
  }

  /// Verifica se o valor é um e-mail válido
  String? isEmail(String? value, [String? message]) {
    if (!validators.isEmail(value!)) {
      return message ?? 'E-mail inválido';
    }

    return null;
  }

  String? hasPassword(String? value, [String? message]) {
    if (!RegExp(ValidationPattern.PATTERN).hasMatch(value!)) {
      return message ?? 'A senha não atende a todos os requisitos';
    }

    return null;
  }

  String? confirmPassword(String? value, String? confirmValue, [String? message]) {
    if (isNullOrEmpty(value)) {
      if (isNullOrEmpty(confirmValue)) {
        return 'Confirme a sua senha';
      }

      if (value != confirmValue) {
        return message ?? 'As senhas são diferentes';
      }
    }

    return null;
  }

  /// Verifica se o valor é um CPF válido
  String? isValidateCPF(String? value) {
    if (value == null || value.length < 11 ||  value.length > 11) {
      return null;
    }

    value = value.replaceAll(RegExp(r'[^\d]'), ''); // Remove caracteres não numéricos
    if (value.length != 11) {
      return 'CPF inválido';
    }

    if (RegExp(r'^(\d)\1{10}$').hasMatch(value)) {
      // Verifica CPF com todos os dígitos iguais
      return 'CPF inválido';
    }

    // Calcular o primeiro dígito verificador
    var soma = 0;
    for (var i = 0; i < 9; i++) {
      soma += int.parse(value[i]) * (10 - i);
    }
    var resto = soma % 11;
    var digito1 = resto < 2 ? 0 : 11 - resto;

    // Verificar o primeiro dígito verificador
    if (digito1 != int.parse(value[9])) {
      return 'CPF inválido';
    }

    // Calcular o segundo dígito verificador
    soma = 0;
    for (var i = 0; i < 10; i++) {
      soma += int.parse(value[i]) * (11 - i);
    }
    resto = soma % 11;
    var digito2 = resto < 2 ? 0 : 11 - resto;

    // Verificar o segundo dígito verificador
    if (digito2 != int.parse(value[10])) {
      return 'CPF inválido';
    }

    // Se chegou até aqui, o CPF é válido
    return null;
  }

  /// Verifica se o valor é um CNPJ válido
  String? isValidateCNPJ(String? value) {
    if (value == null || value.length < 14) {
      return null;
    }

    // Remove caracteres não numéricos
    value = value.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se a string tem 14 caracteres numéricos
    if (value.length != 14) {
      return 'CNPJ inválido';
    }

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(value)) {
      return 'CNPJ inválido';
    }

    // Cálculo do primeiro dígito verificador
    var soma = 0;
    for (var i = 0; i < 12; i++) {
      soma += int.parse(value[i]) * (i < 4 ? 5 - i : 13 - i);
    }
    var dv1 = (11 - soma % 11) % 10;

    // Cálculo do segundo dígito verificador
    soma = 0;
    for (var i = 0; i < 13; i++) {
      soma += int.parse(value[i]) * (i < 5 ? 6 - i : 14 - i);
    }
    var dv2 = (11 - soma % 11) % 10;

    // Verificação dos dígitos verificadores
    if (dv1 != int.parse(value[12]) || dv2 != int.parse(value[13])) {
      return 'CNPJ inválido';
    }

    // Se chegou até aqui, o CNPJ é válido
    return null;
  }
}

