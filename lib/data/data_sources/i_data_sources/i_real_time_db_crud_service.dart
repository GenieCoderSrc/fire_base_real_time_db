import 'package:fire_base_real_time_db/data/models/query_parameter.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IRealTimeDbCrudService {
  Future<bool> saveDocument(
      {Map<String, dynamic> data, required String path, String? successTxt});

  Future<bool> setDocument(
      {required Map<String, dynamic> data,
      required String path,
      required String id,
      String? successTxt});

  Future<bool> updateDocument(
      {required Map<String, dynamic> data,
      required String path,
      required String id,
      String? successTxt});

  Future<bool> removeDocument({
    required String path,
    required String id,
    String? successTxt,
  });

  Future<DataSnapshot?> getDocumentById(
      {required String path, required String id});

  Future<List<Map<String, dynamic>?>?> getAllDocuments(
      {required String path, List<QueryParameter>? queryParameters});

  Stream<List<Map<String, dynamic>?>?> getStreamAllDocuments({
    required String path,
    List<QueryParameter>? queryParameters,
  });

// Stream<List<Map<String, dynamic>?>?> getStreamAllDocumentsWithQuery({
//   required String path,
//   Map<String, dynamic>? equalToMap,
//   String? startAt,
//   String? endAt,
//   String? orderBy,
//   bool isDescending = false,
//   int? limit,
//   required List<QueryParameter> queryParameters,
// });
}
