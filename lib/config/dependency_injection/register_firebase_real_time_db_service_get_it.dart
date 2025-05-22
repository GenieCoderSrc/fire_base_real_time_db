
import 'package:fire_base_real_time_db/data/data_sources/i_data_sources/i_real_time_db_crud_service.dart';
import 'package:fire_base_real_time_db/data/data_sources/real_time_db_crud_service_impl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';

void registerFirebaseRealTimeDBServiceGetItDI() {
  /// ----------------- Firebase--------------
  // Register DatabaseReference
  sl.registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  // ----------- Image Service ---------
  /// ----------------- Service --------------
  sl.registerLazySingleton<IRealTimeDbCrudService>(
      () => RealTimeDbCrudServiceImpl(realTimeDb: sl.get<FirebaseDatabase>()));
  // final FirebaseInstance firebaseService = FirebaseInstance.getInstance;

}

