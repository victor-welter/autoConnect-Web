import 'package:intl/intl.dart';

///Deixa apenas a primeira letra do texto em maiúsculo
///
///Ex: Uma frase de exemplo
String? capitalizeFirstLetter(String? text) {
  if (text == null) {
    return null;
  }

  text = text.trim();
  text = text.toLowerCase();

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  final String firstLetter = text.substring(0, 1).toUpperCase();
  final String remainingLetters = text.substring(1);

  return '$firstLetter$remainingLetters ';
}

///CamelCase
///
/// Ex: Uma Frase de Exemplo
String? capitalizeLetter(String? text) {
  if (text == null) {
    return null;
  }

  text = text.trim();
  text = text.toLowerCase();

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  final List<String> words = text.split(' ');

  String capitalizedWords = '';

  for (int i = 0; i < words.length; i++) {
    final word = words[i].trim();

    if (word.isNotEmpty) {
      if (word.length > 2 || i == 0) {
        final String firstLetter = word.substring(0, 1).toUpperCase();
        final String remainingLetters = word.substring(1);

        capitalizedWords += '$firstLetter$remainingLetters ';
      } else {
        capitalizedWords += '$word ';
      }
    }

    capitalizedWords += '';
  }

  return capitalizedWords.trim();
}

///Capitaliza a primeira letra após um . (ponto)
///
///Ex: Uma frase de exemplo. Uma frase de exemplo
String? capitalizePhrase(String? text) {
  if (text == null) {
    return null;
  }

  text = text.trim();
  text = text.toLowerCase();

  final List<String> phrases = text.split('.');

  final capitalizedPhrases = phrases.map((p) {
    p = p.trim();

    if (p != '') {
      final firstLetter = p.substring(0, 1).toUpperCase();
      final otherLetters = p.substring(1);

      return '$firstLetter$otherLetters';
    }
  });

  return capitalizedPhrases.join('. ');
}

String valorNull(String? value, [String? pattern]) {
  if (value == null || value.trim().isEmpty || value == 'null') {
    return pattern ?? 'Sem informação';
  }

  return value;
}

String? monetario(dynamic valor, [String symbol = '']) {
  if (valor == null) {
    return null;
  }

  return NumberFormat.currency(
    locale: 'pt',
    decimalDigits: 2,
    symbol: symbol,
  ).format(valor);
}

String? truncateZeroDouble(dynamic value, [int? fixed]) {
  if (value == null) {
    return null;
  }

  double decimal = 0;

  if (value is int) {
    return value.toString();
  } else if (value is double) {
    if (value.isNaN) {
      return null;
    }

    decimal = value - value.truncate();
  } else {
    value = double.parse(value.toString());
    decimal = value - value.truncate();
  }

  if (decimal == 0) {
    return value.toStringAsFixed(0);
  }

  if (fixed != null) return value.toStringAsFixed(fixed);

  return value.toString();
}
