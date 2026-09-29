# FireBase Real Time DB

A Dart package to simplify CRUD operations on Firebase Realtime Database. This package provides structured methods for handling database operations efficiently in Flutter applications.

## Features

- Save new documents
- Set/update existing documents
- Remove documents
- Retrieve single or multiple documents
- Stream real-time database updates
- Query support for filtering data

## Installation

Add this package to your `pubspec.yaml` file:

```yaml
resolution: workspace

dependencies:
  fire_base_real_time_db: latest_version
```

Then run:

```sh
dart pub get
```

## Usage

### Initialize Service

```dart
import 'package:fire_base_real_time_db/data/data_sources/real_time_db_crud_service_impl.dart';
import 'package:firebase_database/firebase_database.dart';

final realTimeDbService = RealTimeDbCrudServiceImpl(realTimeDb: FirebaseDatabase.instance);
```

### Save a Document

```dart
await realTimeDbService.saveDocument(
  data: {'name': 'John Doe', 'age': 30},
  path: 'users',
);
```

### Update a Document

```dart
await realTimeDbService.updateDocument(
  data: {'age': 31},
  path: 'users',
  id: 'user_id_here',
);
```

### Get a Document by ID

```dart
final snapshot = await realTimeDbService.getDocumentById(
  path: 'users',
  id: 'user_id_here',
);
print(snapshot?.value);
```

### Stream Realtime Updates

```dart
realTimeDbService.getStreamAllDocuments(path: 'users').listen((data) {
  print(data);
});
```

## License

This package is released under the MIT License.

