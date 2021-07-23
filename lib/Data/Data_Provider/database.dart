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
  TextColumn get customer => text()();
  RealColumn get totalPrice => real()();
  RealColumn get payment => real()();
  BoolColumn get paymentStatus => boolean()();
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

  Future<List<SalesTransaction>> allSalesEntries() {
    return (select(salesTransactions)).get();
  }

  Future<int> addSales(SalesTransactionsCompanion entry) {
    return into(salesTransactions).insert(entry);
  }

  Future<SalesTransaction> selectInvoicetById(int id) {
    return (select(salesTransactions)
          ..where((tbl) => tbl.transactionId.equals(id)))
        .getSingle();
  }

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) async {
        // await m.deleteTable(salesTransactions.actualTableName);
        // await m.deleteTable(products.actualTableName);
        // await m.deleteTable(productsInTransactions.actualTableName);
        await m.createAll();
        await m.createTrigger(Trigger('''
        CREATE TRIGGER updated_at_trigger 
        AFTER UPDATE
        ON products
        FOR EACH ROW
        WHEN NEW.updated_at = OLD.updated_at
          BEGIN
            UPDATE products SET updated_at = (strftime('%s','now'))
          WHERE id == OLD.id;
        END;
        ''', 'x'));
        await m.createTrigger(Trigger('''
        CREATE TRIGGER updated_at_sales_transactions
        AFTER UPDATE
        ON sales_transactions
        FOR EACH ROW
        WHEN NEW.updated_at = OLD.updated_at
          BEGIN
            UPDATE sales_transactions SET updated_at = (strftime('%s','now'))
          WHERE transaction_id == OLD.transaction_id;
        END;
        ''', 'y'));
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.deleteTable(salesTransactions.actualTableName);
          await m.deleteTable(products.actualTableName);
          await m.deleteTable(productsInTransactions.actualTableName);
          await m.createAll();
        }
      });
}
