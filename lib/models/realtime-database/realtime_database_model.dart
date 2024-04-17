class RealtimeDatabaseModel {
  RealtimeDatabaseModel(this.reference);

  late final String reference;
  List<Map> data = [];
  List<RealtimeDatabaseModel> child = [];

  String get relativeReference => reference.split('/').last;
}
