import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/realtime-database/realtime_database_model.dart';
import '../services/dialog_service.dart';
import '../widgets/cs_icon.dart';
import '../widgets/cs_icon_button.dart';

///Converte a data vinda do banco de dados.
///
///Milissegundos -> DateTime
DateTime? convertDataDB(int? milliseconds) {
  if (milliseconds == null) {
    return null;
  }

  return DateTime.fromMillisecondsSinceEpoch(milliseconds);
}

String? formatDateBR(DateTime? date) {
  if (date == null) {
    return null;
  }

  return DateFormat('dd/MM/yyyy').format(date);
}

String? uploadDateFormat(DateTime? date) {
  if (date == null) {
    return null;
  }

  return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(date.toUtc());
}

String? uploadHourFormat(DateTime? hour) {
  if (hour == null) {
    return null;
  }

  return DateFormat('HH:mm:ss').format(hour);
}

DateTime? tryParseDate(dynamic value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value.toString());
}

///Verifica se um objeto é nulo e, em caso de Strings, verifica ainda se ela está vazia
bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  }

  if (value is String) {
    if (value.trim().isEmpty || value == 'null') {
      return true;
    }
  }

  return false;
}

///Redireciona usuário para a url informada
void launchURL(String? url) async {
  if (isNullOrEmpty(url)) {
    return;
  }

  if (await canLaunchUrl(Uri.parse(url!))) {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else {
    showSnackbar(
      description: 'Não foi possível prosseguir com a solicitação',
      seconds: 2,
    );
  }
}

Widget clearField({required dynamic value, required VoidCallback onClear, Color? color}) {
  if (value == null || (value is String && value.isEmpty)) {
    return const SizedBox();
  }

  return CsIconButton.light(
    icon: CsIcon(
      icon: Icons.clear,
      color: color,
    ),
    onPressed: onClear,
    tooltip: 'Limpar filtro',
  );
}

void readRealtimeDatabase(Map map, RealtimeDatabaseModel object) {
  for (var key in map.keys) {
    String runtime = map[key].runtimeType.toString();
    //O runtimeType em modo Release fica alterando... Ocasionando esses 'minifield'
    if (runtime == '_JsonMap' || runtime.contains('minifield') || runtime.contains('minified')) {
      final child = RealtimeDatabaseModel('${object.reference}/$key');
      object.child.add(child);
      readRealtimeDatabase(map[key], child);
    } else {
      object.data.add({key: map[key]});
    }
  }
}

String encodePermission(List<int> permission) {
  return permission.join(',');
}

//Método 'extension()' do package 'path' não funcionava na Web. Criado método próprio
String getExtension(String path, {bool includeDot = true}) {
  try {
    List<String> dirs = path.split('/');

    if (dirs.isNotEmpty) {
      if (dirs.last.contains('.')) {
        return '${includeDot ? '.' : ''}${dirs.last.split('.').last}';
      }
    }
  } catch (_) {}

  return '';
}

int? timeOfDayToSeconds(TimeOfDay time) {
  if (time.hour == 0 && time.minute == 0) {
    return null;
  }

  return time.hour * 3600 + time.minute * 60;
}

String? validator(dynamic value, String message) {
  if (isNullOrEmpty(value)) {
    return message;
  }

  return null;
}

///Retorna uma nova instância da lista clonada (Permite tipagem)
List<T> cloneList<T>(List<dynamic> list) {
  return list.map((e) => e as T).toList();
}
