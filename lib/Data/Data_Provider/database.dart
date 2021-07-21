import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

final uuid = Uuid();

class Products extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get productName => text()();
  TextColumn get category => text()();
  TextColumn get uom => text()();
  IntColumn get price => integer()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsInTransactions extends Table {
  TextColumn get productId =>
      text().customConstraint('NOT NULL REFERENCES products (id)')();
  IntColumn get transactionId => integer().customConstraint(
      'NOT NULL REFERENCES sales_transactions (transaction_id)')();
  RealColumn get quantity => real()();
  RealColumn get salePrice => real()();

  @override
  Set<Column> get primaryKey => {productId, transactionId};
}

class SalesTransactions extends Table {
  IntColumn get transactionId => integer().autoIncrement()();
  RealColumn get totalPrice => real()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
  TextColumn get note => text()();
}

@UseMoor(tables: [Products, ProductsInTransactions, SalesTransactions])
class SharedDatabase extends _$SharedDatabase {
  SharedDatabase(QueryExecutor e) : super(e);

  Future<List<Product>> get allProductEntries => select(products).get();

  Future<int> addProduct(ProductsCompanion entry) {
    return into(products).insert(entry);
  }

  Future<Product> selectProductById(String id) {
    return (select(products)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future updateProduct(ProductsCompanion entry) {
    return update(products).replace(entry);
  }

  Future<int> deleteProduct(ProductsCompanion entry) {
    return (delete(products)..where((tbl) => tbl.id.equals(entry.id.value)))
        .go();
  }

  Future<int> deleteProductByID(String entry) {
    return (delete(products)..where((tbl) => tbl.id.equals(entry))).go();
  }

  Future<int> deleteProductByList(List<String> entry) {
    return (delete(products)..where((tbl) => tbl.id.isIn(entry))).go();
  }

  /// CART
  Future<List<ProductsInTransaction>> get allCartEntries =>
      select(productsInTransactions).get();

  Future<List<ProductsInTransaction>> allCartBySaleID(int id) {
    return (select(productsInTransactions)
          ..where((tbl) => tbl.transactionId.equals(id)))
        .get();
  }

  Future<int> addCart(ProductsInTransactionsCompanion entry) {
    return into(productsInTransactions).insert(entry);
  }

  Future addCartList(List<ProductsInTransactionsCompanion> entry) async {
    await batch((batch) => batch.insertAll(productsInTransactions, entry));
  }

  Future updateCart(ProductsInTransactionsCompanion entry) {
    return update(productsInTransactions).replace(entry);
  }

  /// SALES TRANSACTION

  Future<List<SalesTransaction>> get allSalesEntries =>
      select(salesTransactions).get();

  Future<int> addSales(SalesTransactionsCompanion entry) {
    return into(salesTransactions).insert(entry);
  }

  Future<int> countSales() async {
    final salesCount = salesTransactions.transactionId.count();
    final query =
        await select(salesTransactions).addColumns([salesCount]).get();
    return query.first.read(salesCount);
  }

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        m.deleteTable(salesTransactions.actualTableName);
        m.deleteTable(products.actualTableName);
        m.deleteTable(productsInTransactions.actualTableName);
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          m.deleteTable(salesTransactions.actualTableName);
          m.deleteTable(products.actualTableName);
          m.deleteTable(productsInTransactions.actualTableName);
          await m.createAll();
        }
      });
}