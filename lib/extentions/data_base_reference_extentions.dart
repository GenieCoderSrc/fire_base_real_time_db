import 'package:fire_base_real_time_db/data/enums/query_type.dart';
import 'package:fire_base_real_time_db/data/models/query_parameter.dart';
import 'package:firebase_database/firebase_database.dart';

extension DatabaseReferenceExtension on Query {
  Query applyQueryParameters(List<QueryParameter>? queryParameters) {
    Query query = this;

    if (queryParameters != null) {
      for (QueryParameter param in queryParameters) {
        query = applySingleQueryParameter(query, param);
      }
    }

    return query;
  }

  Query applySingleQueryParameter(Query query, QueryParameter param) {
    String? field = param.field;
    switch (param.type) {
      case QueryType.orderByChild:
        return field != null ? query.orderByChild(field) : query;
      case QueryType.orderByValue:
        return query.orderByValue();
      case QueryType.orderByPriority:
        return query.orderByPriority();
      case QueryType.limitToFirst:
        return query.limitToFirst(param.value);
      case QueryType.limitToLast:
        return query.limitToLast(param.value);
      case QueryType.equalTo:
        return query.equalTo(param.value, key: field);
      case QueryType.startAt:
        return query.startAt(param.value, key: field);
      case QueryType.endAt:
        return query.endAt(param.value, key: field);
      case QueryType.orderByKey:
        return query.orderByKey();
    }
  }
}
