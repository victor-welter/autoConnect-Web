// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../configs/assets/assets_path.dart';
import '../configs/constants.dart';
import '../configs/theme/theme_date_picker.dart';
import '../widgets/cs_text_button.dart';
import '../widgets/dialog-content/cs_alert_dialog.dart';
import '../widgets/dialog-content/cs_alert_dialog_content.dart';
import 'navigator_service.dart';
import 'service_locator.dart';

final _navigatorKey = getIt<NavigationService>().navigatorKey;

bool _dialogOpen = false;
bool _modalOpen = false;

Future<T?> openSimpleDialog<T>({
  required String title,
  required String description,
  List<Widget>? actions,
  DialogAction defaultAction = DialogAction.ok,
  bool tapDismiss = true,
}) async {
  actions = _defaultAction(defaultAction);

  _dialogOpen = true;

  return await showDialog<T>(
    context: _navigatorKey.currentContext!,
    barrierDismissible: tapDismiss,
    useSafeArea: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(tapDismiss);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: CsAlertDialog(
            title: title,
            description: description,
            actions: actions,
          ),
        ),
      );
    },
  ).then((value) {
    _dialogOpen = false;
    return value;
  });
}

Future<dynamic> openDialogWithContent<T>({
  required String title,
  required Widget content,
  bool tapDismiss = true,
}) async {
  _dialogOpen = true;

  return await showDialog<T>(
    context: _navigatorKey.currentContext!,
    barrierDismissible: tapDismiss,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CsAlertDialogContent(
          title: title,
          content: content,
        ),
      );
    },
  ).then((value) {
    _dialogOpen = false;
    return value;
  });
}

void closeDialog() async {
  if (_dialogOpen) {
    _navigatorKey.currentContext!.pop();
  }
}

void closeModal() {
  if (_modalOpen) {
    _navigatorKey.currentContext!.pop();
  }
}

List<Widget>? _defaultAction(DialogAction defaultAction) {
  if (defaultAction == DialogAction.ok) {
    return [
      CsTextButton(
        label: 'OK',
        onTap: () => _navigatorKey.currentContext!.pop(),
      ),
    ];
  } else if (defaultAction == DialogAction.sim_nao) {
    return [
      CsTextButton(
        label: 'SIM',
        onTap: () => _navigatorKey.currentContext!.pop(true),
      ),
      CsTextButton(
        label: 'NÃO',
        onTap: () => _navigatorKey.currentContext!.pop(false),
      ),
    ];
  }

  return null;
}

Future<DateTime?> getDate({
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? initialDate,
  DatePickerMode datePickerMode = DatePickerMode.day,
  DatePickerEntryMode entryMode = DatePickerEntryMode.calendarOnly,
}) async {
  return await showDatePicker(
    context: _navigatorKey.currentContext!,
    locale: const Locale('pt', 'BR'),
    initialDatePickerMode: datePickerMode,
    initialEntryMode: entryMode,
    firstDate: firstDate, //Range inicial
    lastDate: lastDate, //Range final
    initialDate: initialDate ?? DateTime.now(), //Data inicial selecionada
    builder: (_, child) {
      return ThemeDatePicker(child: child!);
    },
  );
}

void showSnackbar({
  required String description,
  int seconds = 5,
  SnackBarAction? action,
  SnackBarBehavior? behavior,
}) {
  ScaffoldMessenger.of(_navigatorKey.currentContext!).removeCurrentSnackBar();

  ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(_navigatorKey.currentContext!).snackBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            AssetsPath.LOGO,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Theme.of(_navigatorKey.currentContext!).colorScheme.secondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    duration: Duration(seconds: seconds),
    behavior: behavior ?? SnackBarBehavior.floating,
    padding: const EdgeInsets.all(0),
    action: action,
  ));
}

Future<T> openModal<T>({required Widget content}) async {
  _modalOpen = true;

  return await showModalBottomSheet(
    context: _navigatorKey.currentContext!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    barrierColor: Colors.black54,
    builder: (_) {
      return content;
    },
  ).then((value) {
    _modalOpen = false;

    return value;
  });
}

Future<TimeOfDay?> getTime({
  required TimeOfDay? initialTime,
  String? helpText,
}) async {
  return await showTimePicker(
    context: _navigatorKey.currentContext!,
    confirmText: 'OK',
    cancelText: 'CANCELAR',
    helpText: helpText ?? 'SELECIONE O HORÁRIO',
    initialTime: initialTime ?? TimeOfDay.now(),
    builder: (_, child) {
      return ThemeDatePicker(child: child!);
    },
  );
}
