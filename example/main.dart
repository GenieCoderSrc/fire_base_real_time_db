import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fire_base_real_time_db/fire_base_real_time_db.dart';

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Create an instance of the RealTimeDbCrudServiceImpl
  final realTimeDbService = RealTimeDbCrudServiceImpl();

  // Define the path in the database
  String path = 'users';

  // Save a new document
  await realTimeDbService.saveDocument(
    data: {'name': 'John Doe', 'email': 'johndoe@example.com'},
    path: path,
  );

  // Fetch all documents from the database
  List<Map<String, dynamic>?>? users = await realTimeDbService.getAllDocuments(
    path: path,
  );

  print('Users: $users');
}
