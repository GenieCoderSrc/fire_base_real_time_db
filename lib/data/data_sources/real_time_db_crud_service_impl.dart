import 'package:fire_base_real_time_db/data/data_sources/i_data_sources/i_real_time_db_crud_service.dart';
import 'package:fire_base_real_time_db/data/models/query_parameter.dart';
import 'package:fire_base_real_time_db/extentions/data_base_reference_extentions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class RealTimeDbCrudServiceImpl implements IRealTimeDbCrudService {
  final FirebaseDatabase _realTimeDb;

  RealTimeDbCrudServiceImpl({FirebaseDatabase? realTimeDb})
    : _realTimeDb = realTimeDb ?? FirebaseDatabase.instance;

  @override
  Future<bool> saveDocument({
    Map<String, dynamic>? data,
    required String path,
    String? successTxt,
  }) async {
    try {
      if (data != null) {
        return await _realTimeDb
            .ref()
            .child(path)
            .push()
            .set(data)
            .then((_) {
              if (successTxt != null) {
                debugPrint(successTxt);
              }
              return true;
            })
            .catchError((error) {
              debugPrint(
                'RealTimeDbCrudServiceImpl | saveDocument | Error: $error',
              );
              return false;
            });
      } else {
        debugPrint(
          'RealTimeDbCrudServiceImpl | saveDocument | Error: data is null',
        );
      }
      return false;
    } catch (e) {
      debugPrint('RealTimeDbCrudServiceImpl | saveDocument | error: $e');
      return false;
    }
  }

  @override
  Future<bool> setDocument({
    required Map<String, dynamic> data,
    required String path,
    required String id,
    String? successTxt,
  }) async {
    try {
      DatabaseReference reference = _realTimeDb.ref().child(path).child(id);
      return await reference
          .set(data)
          .then((_) {
            if (successTxt != null) {
              debugPrint(successTxt);
            }
            return true;
          })
          .catchError((error) {
            debugPrint(
              'RealTimeDbCrudServiceImpl | setDocument | Error: $error',
            );
            return false;
          });
    } catch (e) {
      debugPrint('RealTimeDbCrudServiceImpl | setDocument | Error: $e');
      return false;
    }
  }

  @override
  Future<bool> updateDocument({
    required Map<String, dynamic> data,
    required String path,
    required String id,
    String? successTxt,
  }) async {
    try {
      DatabaseReference reference = _realTimeDb.ref().child(path).child(id);
      return await reference
          .update(data)
          .then((_) {
            if (successTxt != null) {
              debugPrint(successTxt);
            }
            return true;
          })
          .catchError((error) {
            debugPrint(
              'RealTimeDbCrudServiceImpl | updateDocument | catchError: $error',
            );
            return false;
          });
    } catch (e) {
      debugPrint('RealTimeDbCrudServiceImpl | updateDocument | Error: $e');
      return false;
    }
  }

  @override
  Future<bool> removeDocument({
    required String path,
    required String id,
    String? successTxt,
  }) async {
    try {
      DatabaseReference reference = _realTimeDb.ref().child(path).child(id);
      return await reference
          .remove()
          .then((_) {
            if (successTxt != null) {
              debugPrint(successTxt);
            }
            return true;
          })
          .catchError((error) {
            debugPrint(
              'RealTimeDbCrudServiceImpl | removeDocument | catchError: $error',
            );
            return false;
          });
    } catch (e) {
      debugPrint('RealTimeDbCrudServiceImpl | removeDocument | Error: $e');
      return false;
    }
  }

  // Single Data
  @override
  Future<DataSnapshot?> getDocumentById({
    required String path,
    required String id,
  }) async {
    try {
      DatabaseEvent event = await _realTimeDb
          .ref()
          .child(path)
          .child(id)
          .once();
      return event.snapshot;
    } catch (e) {
      debugPrint(
        'RealTimeDbCrudServiceImpl | getDocumentById | Error getting document by ID: $e',
      );
      return null;
    }
  }

  // Get Future Data Collection
  @override
  Future<List<Map<String, dynamic>?>?> getAllDocuments({
    required String path,
    List<QueryParameter>? queryParameters,
  }) async {
    try {
      DatabaseReference reference = FirebaseDatabase.instance.ref().child(path);

      Query query = reference.applyQueryParameters(queryParameters);

      DatabaseEvent event = await query.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values =
            snapshot.value as Map<dynamic, dynamic>;
        return values
            .map(
              (key, value) =>
                  MapEntry(key.toString(), value as Map<String, dynamic>),
            )
            .values
            .toList();
      }

      return null;
    } catch (e) {
      // Handle the error and return it or throw it as needed.
      debugPrint('RealTimeDbCrudServiceImpl | getAllDocuments | Error: $e');
      return null;
    }
  }
  // Future<Map<dynamic, dynamic>?> getAllDocuments({required String path}) async {
  //   try {
  //     DatabaseEvent event = await _realTimeDb.ref().child(path).once();
  //     final Map<dynamic, dynamic>? values =
  //         event.snapshot.value as Map<dynamic, dynamic>?;
  //
  //     debugPrint(
  //         'RealTimeDbCrudServiceImpl | getAllDocuments | event.snapshot.value: ${values.toString()}');
  //
  //     return values;
  //
  //     // if (values != null) {
  //     //   List<Map<String, dynamic>> documents = [];
  //     //   values.forEach((key, value) {
  //     //     Map<String, dynamic> document = value;
  //     //     document['id'] = key;
  //     //     documents.add(document);
  //     //   });
  //     //   return documents;
  //     // } else {
  //     //   return null;
  //     // }
  //   } catch (e) {
  //     debugPrint(
  //         'RealTimeDbCrudServiceImpl | getAllDocuments |  Error getting all documents: $e');
  //     return null;
  //   }
  // }

  // Get Stream Data Collection
  @override
  Stream<List<Map<String, dynamic>?>?> getStreamAllDocuments({
    required String path,
    List<QueryParameter>? queryParameters,
  }) {
    DatabaseReference reference = FirebaseDatabase.instance.ref().child(path);

    Query query = reference.applyQueryParameters(queryParameters);

    return query.onValue.map(
      (DatabaseEvent event) => [event.snapshot.value as Map<String, dynamic>?],
    );
  }

  // @override
  // Stream<Map<String, dynamic>?> getStreamAllDocuments({required String path}) {
  //   try {
  //     Stream<DatabaseEvent> snapshotStream =
  //         _databaseReference.child(path).onValue;
  //
  //     return snapshotStream
  //         .map((event) => event.snapshot.value as Map<String, dynamic>?);
  //   } catch (e) {
  //     debugPrint(
  //         'RealTimeDbCrudServiceImpl | getStreamAllDocuments | Error getting all documents: $e');
  //     return Stream.value(null);
  //   }
  // }

  // @override
  // Stream<Map<String, dynamic>?> getStreamAllDocuments(
  //     {required String path}) async* {
  //   try {
  //     Stream<DatabaseEvent> eventStream = _realTimeDb.ref().child(path).onValue;
  //
  //     await for (DatabaseEvent event in eventStream) {
  //       yield event.snapshot.value as Map<String, dynamic>?;
  //     }
  //   } catch (e) {
  //     debugPrint(
  //         'RealTimeDbCrudServiceImpl | getStreamAllDocuments | Error getting all documents: $e');
  //     yield null;
  //   }
  // }

  // @override
  // Stream<Map<String, dynamic>?> getStreamAllDocumentsWithQuery(
  //     {required String path,
  //     String? orderBy,
  //     bool isDescending = false,
  //     Map<String, dynamic>? equalToMap,
  //     String? startAt,
  //     String? endAt,
  //     int? limit}) async* {
  //   try {
  //     DatabaseReference ref = _realTimeDb.ref().child(path);
  //
  //     Query query = ref;
  //
  //     bool hasStartingPointBeenSet = false;
  //
  //     if (orderBy != null) {
  //       query = query.orderByChild(orderBy);
  //     }
  //
  //     if (equalToMap != null) {
  //       query = setEqualToMap(equalToMap: equalToMap, query: query);
  //     }
  //
  //     if (startAt != null && !hasStartingPointBeenSet) {
  //       query = query.startAt(startAt);
  //       hasStartingPointBeenSet = true;
  //     }
  //
  //     if (endAt != null) {
  //       query = query.endAt(endAt);
  //     }
  //
  //     if (limit != null && !isDescending) {
  //       query = query.limitToFirst(limit);
  //     } else if (limit != null && isDescending) {
  //       query = query.limitToLast(limit);
  //     }
  //
  //     Stream<DatabaseEvent> eventStream = query.onValue;
  //
  //     await for (DatabaseEvent event in eventStream) {
  //       yield (event.snapshot.value as Map?)?.cast<String, dynamic>();
  //     }
  //   } catch (e) {
  //     debugPrint(
  //         'RealTimeDbCrudServiceImpl | getStreamAllDocumentsWithQuery | Error getting all documents with query: $e');
  //     yield null;
  //   }
  // }

  Query setEqualToMap({
    required Map<String, dynamic> equalToMap,
    required Query query,
  }) {
    try {
      for (var entry in equalToMap.entries) {
        var key = entry.key;
        var value = entry.value;
        if (value is List) {
          // Use orderByChild and equalTo to filter by multiple values
          Query subQuery = query.orderByChild(key);
          for (var v in value) {
            subQuery = subQuery.equalTo(v);
            query = subQuery;
          }
        } else {
          // Use equalTo for single values
          query = query.equalTo(value, key: key);
        }
      }
    } catch (e) {
      debugPrint('RealTimeDbCrudServiceImpl | setEqualToMap | error: $e');
    }
    return query;
  }
}
