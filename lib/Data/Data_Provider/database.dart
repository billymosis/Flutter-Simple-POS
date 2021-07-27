import 'package:moor/moor.dart';
import 'package:project_pos/Data/Data_Provider/Platform_Helper/shared.dart';

part 'database.g.dart';

@UseMoor(
  include: {'tables.moor'},
)
class SharedDatabase extends _$SharedDatabase {
  SharedDatabase(QueryExecutor e) : super(e);

  static final SharedDatabase x = constructDb();
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

  Future<List<ProductsInTransaction>> allCartBySaleID(String id) {
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

  Future<SalesTransaction> selectInvoicetById(String id) {
    return (select(salesTransactions)
          ..where((tbl) => tbl.transactionId.equals(id)))
        .getSingle();
  }

  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) async {
        await m.createAll();
        // await m.createTrigger(Trigger('''
        // CREATE TRIGGER updated_at_trigger
        // AFTER UPDATE
        // ON products
        // FOR EACH ROW
        // WHEN NEW.updated_at = OLD.updated_at
        //   BEGIN
        //     UPDATE products SET updated_at = (strftime('%s','now'))
        //   WHERE id == OLD.id;
        // END;
        // ''', 'x'));
        // await m.createTrigger(Trigger('''
        // CREATE TRIGGER updated_at_sales_transactions
        // AFTER UPDATE
        // ON sales_transactions
        // FOR EACH ROW
        // WHEN NEW.updated_at = OLD.updated_at
        //   BEGIN
        //     UPDATE sales_transactions SET updated_at = (strftime('%s','now'))
        //   WHERE transaction_id == OLD.transaction_id;
        // END;
        // ''', 'y'));
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.deleteTable(salesTransactions.actualTableName);
          await m.deleteTable(products.actualTableName);
          await m.deleteTable(productsInTransactions.actualTableName);
          await m.createAll();
        }
      });
}
