import 'package:drift/drift.dart';
import 'connection/native.dart';

part 'app_database.g.dart';

class LocalRooms extends Table {
  TextColumn get id => text()();
  TextColumn get restaurantId => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get number => integer()();
  TextColumn get status => text().withDefault(const Constant('AVAILABLE'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalCategories extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalProducts extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  TextColumn get name => text().withLength(min: 1, max: 150)();
  IntColumn get price => integer()();
  TextColumn get unit => text().withDefault(const Constant('dona'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalOrders extends Table {
  TextColumn get id => text()();
  TextColumn get restaurantId => text()();
  TextColumn get roomId => text()();
  TextColumn get waiterId => text()();
  TextColumn get status => text().withDefault(const Constant('OPEN'))();
  IntColumn get totalAmount => integer().withDefault(const Constant(0))();
  TextColumn get idempotencyKey => text().nullable()();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closedAt => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalOrderItems extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text().references(LocalOrders, #id)();
  TextColumn get productId => text()();
  RealColumn get quantity => real()();
  IntColumn get unitPriceAtSale => integer()();
  IntColumn get totalPrice => integer()();
  TextColumn get status => text().withDefault(const Constant('PENDING'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalSyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get tableName => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text()();
  TextColumn get idempotencyKey => text()();
  TextColumn get status => text().withDefault(const Constant('PENDING'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  LocalRooms,
  LocalCategories,
  LocalProducts,
  LocalOrders,
  LocalOrderItems,
  LocalSyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connectToDatabase());

  @override
  int get schemaVersion => 1;
}