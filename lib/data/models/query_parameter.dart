import 'package:fire_base_real_time_db/data/enums/query_type.dart';

class QueryParameter {
  final QueryType type;
  final String? field;
  final dynamic value;

  QueryParameter({required this.type, required this.field, this.value});
}
