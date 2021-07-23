// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String productName;
  final String category;
  final String uom;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  Product(
      {required this.id,
      required this.productName,
      required this.category,
      required this.uom,
      required this.price,
      required this.createdAt,
      required this.updatedAt});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Product(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      uom: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uom'])!,
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_name'] = Variable<String>(productName);
    map['category'] = Variable<String>(category);
    map['uom'] = Variable<String>(uom);
    map['price'] = Variable<int>(price);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      productName: Value(productName),
      category: Value(category),
      uom: Value(uom),
      price: Value(price),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
      category: serializer.fromJson<String>(json['category']),
      uom: serializer.fromJson<String>(json['uom']),
      price: serializer.fromJson<int>(json['price']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productName': serializer.toJson<String>(productName),
      'category': serializer.toJson<String>(category),
      'uom': serializer.toJson<String>(uom),
      'price': serializer.toJson<int>(price),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith(
          {String? id,
          String? productName,
          String? category,
          String? uom,
          int? price,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Product(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        category: category ?? this.category,
        uom: uom ?? this.uom,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('uom: $uom, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          productName.hashCode,
          $mrjc(
              category.hashCode,
              $mrjc(
                  uom.hashCode,
                  $mrjc(price.hashCode,
                      $mrjc(createdAt.hashCode, updatedAt.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.productName == this.productName &&
          other.category == this.category &&
          other.uom == this.uom &&
          other.price == this.price &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> productName;
  final Value<String> category;
  final Value<String> uom;
  final Value<int> price;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
    this.category = const Value.absent(),
    this.uom = const Value.absent(),
    this.price = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String productName,
    required String category,
    required String uom,
    required int price,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : productName = Value(productName),
        category = Value(category),
        uom = Value(uom),
        price = Value(price);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? productName,
    Expression<String>? category,
    Expression<String>? uom,
    Expression<int>? price,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productName != null) 'product_name': productName,
      if (category != null) 'category': category,
      if (uom != null) 'uom': uom,
      if (price != null) 'price': price,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<String>? productName,
      Value<String>? category,
      Value<String>? uom,
      Value<int>? price,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ProductsCompanion(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      uom: uom ?? this.uom,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (uom.present) {
      map['uom'] = Variable<String>(uom.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('uom: $uom, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  late final GeneratedColumn<String?> productName = GeneratedColumn<String?>(
      'product_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _uomMeta = const VerificationMeta('uom');
  late final GeneratedColumn<String?> uom = GeneratedColumn<String?>(
      'uom', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  late final GeneratedColumn<int?> price = GeneratedColumn<int?>(
      'price', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns =>
      [id, productName, category, uom, price, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'products';
  @override
  String get actualTableName => 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('uom')) {
      context.handle(
          _uomMeta, uom.isAcceptableOrUnknown(data['uom']!, _uomMeta));
    } else if (isInserting) {
      context.missing(_uomMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Product.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class ProductsInTransaction extends DataClass
    implements Insertable<ProductsInTransaction> {
  final String productId;
  final int transactionId;
  final double quantity;
  final double salePrice;
  ProductsInTransaction(
      {required this.productId,
      required this.transactionId,
      required this.quantity,
      required this.salePrice});
  factory ProductsInTransaction.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductsInTransaction(
      productId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      transactionId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id'])!,
      quantity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity'])!,
      salePrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sale_price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['transaction_id'] = Variable<int>(transactionId);
    map['quantity'] = Variable<double>(quantity);
    map['sale_price'] = Variable<double>(salePrice);
    return map;
  }

  ProductsInTransactionsCompanion toCompanion(bool nullToAbsent) {
    return ProductsInTransactionsCompanion(
      productId: Value(productId),
      transactionId: Value(transactionId),
      quantity: Value(quantity),
      salePrice: Value(salePrice),
    );
  }

  factory ProductsInTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductsInTransaction(
      productId: serializer.fromJson<String>(json['productId']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'transactionId': serializer.toJson<int>(transactionId),
      'quantity': serializer.toJson<double>(quantity),
      'salePrice': serializer.toJson<double>(salePrice),
    };
  }

  ProductsInTransaction copyWith(
          {String? productId,
          int? transactionId,
          double? quantity,
          double? salePrice}) =>
      ProductsInTransaction(
        productId: productId ?? this.productId,
        transactionId: transactionId ?? this.transactionId,
        quantity: quantity ?? this.quantity,
        salePrice: salePrice ?? this.salePrice,
      );
  @override
  String toString() {
    return (StringBuffer('ProductsInTransaction(')
          ..write('productId: $productId, ')
          ..write('transactionId: $transactionId, ')
          ..write('quantity: $quantity, ')
          ..write('salePrice: $salePrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      productId.hashCode,
      $mrjc(transactionId.hashCode,
          $mrjc(quantity.hashCode, salePrice.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsInTransaction &&
          other.productId == this.productId &&
          other.transactionId == this.transactionId &&
          other.quantity == this.quantity &&
          other.salePrice == this.salePrice);
}

class ProductsInTransactionsCompanion
    extends UpdateCompanion<ProductsInTransaction> {
  final Value<String> productId;
  final Value<int> transactionId;
  final Value<double> quantity;
  final Value<double> salePrice;
  const ProductsInTransactionsCompanion({
    this.productId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.salePrice = const Value.absent(),
  });
  ProductsInTransactionsCompanion.insert({
    required String productId,
    required int transactionId,
    required double quantity,
    required double salePrice,
  })  : productId = Value(productId),
        transactionId = Value(transactionId),
        quantity = Value(quantity),
        salePrice = Value(salePrice);
  static Insertable<ProductsInTransaction> custom({
    Expression<String>? productId,
    Expression<int>? transactionId,
    Expression<double>? quantity,
    Expression<double>? salePrice,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (quantity != null) 'quantity': quantity,
      if (salePrice != null) 'sale_price': salePrice,
    });
  }

  ProductsInTransactionsCompanion copyWith(
      {Value<String>? productId,
      Value<int>? transactionId,
      Value<double>? quantity,
      Value<double>? salePrice}) {
    return ProductsInTransactionsCompanion(
      productId: productId ?? this.productId,
      transactionId: transactionId ?? this.transactionId,
      quantity: quantity ?? this.quantity,
      salePrice: salePrice ?? this.salePrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsInTransactionsCompanion(')
          ..write('productId: $productId, ')
          ..write('transactionId: $transactionId, ')
          ..write('quantity: $quantity, ')
          ..write('salePrice: $salePrice')
          ..write(')'))
        .toString();
  }
}

class $ProductsInTransactionsTable extends ProductsInTransactions
    with TableInfo<$ProductsInTransactionsTable, ProductsInTransaction> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProductsInTransactionsTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  late final GeneratedColumn<String?> productId = GeneratedColumn<String?>(
      'product_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES products (id)');
  final VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  late final GeneratedColumn<int?> transactionId = GeneratedColumn<int?>(
      'transaction_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES sales_transactions (transaction_id)');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  late final GeneratedColumn<double?> quantity = GeneratedColumn<double?>(
      'quantity', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _salePriceMeta = const VerificationMeta('salePrice');
  late final GeneratedColumn<double?> salePrice = GeneratedColumn<double?>(
      'sale_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [productId, transactionId, quantity, salePrice];
  @override
  String get aliasedName => _alias ?? 'products_in_transactions';
  @override
  String get actualTableName => 'products_in_transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductsInTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(_salePriceMeta,
          salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta));
    } else if (isInserting) {
      context.missing(_salePriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, transactionId};
  @override
  ProductsInTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductsInTransaction.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductsInTransactionsTable createAlias(String alias) {
    return $ProductsInTransactionsTable(_db, alias);
  }
}

class SalesTransaction extends DataClass
    implements Insertable<SalesTransaction> {
  final int transactionId;
  final String customer;
  final double totalPrice;
  final double payment;
  final bool paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String note;
  SalesTransaction(
      {required this.transactionId,
      required this.customer,
      required this.totalPrice,
      required this.payment,
      required this.paymentStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.note});
  factory SalesTransaction.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SalesTransaction(
      transactionId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id'])!,
      customer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}customer'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      payment: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment'])!,
      paymentStatus: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transaction_id'] = Variable<int>(transactionId);
    map['customer'] = Variable<String>(customer);
    map['total_price'] = Variable<double>(totalPrice);
    map['payment'] = Variable<double>(payment);
    map['payment_status'] = Variable<bool>(paymentStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['note'] = Variable<String>(note);
    return map;
  }

  SalesTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SalesTransactionsCompanion(
      transactionId: Value(transactionId),
      customer: Value(customer),
      totalPrice: Value(totalPrice),
      payment: Value(payment),
      paymentStatus: Value(paymentStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      note: Value(note),
    );
  }

  factory SalesTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SalesTransaction(
      transactionId: serializer.fromJson<int>(json['transactionId']),
      customer: serializer.fromJson<String>(json['customer']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      payment: serializer.fromJson<double>(json['payment']),
      paymentStatus: serializer.fromJson<bool>(json['paymentStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionId': serializer.toJson<int>(transactionId),
      'customer': serializer.toJson<String>(customer),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'payment': serializer.toJson<double>(payment),
      'paymentStatus': serializer.toJson<bool>(paymentStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'note': serializer.toJson<String>(note),
    };
  }

  SalesTransaction copyWith(
          {int? transactionId,
          String? customer,
          double? totalPrice,
          double? payment,
          bool? paymentStatus,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? note}) =>
      SalesTransaction(
        transactionId: transactionId ?? this.transactionId,
        customer: customer ?? this.customer,
        totalPrice: totalPrice ?? this.totalPrice,
        payment: payment ?? this.payment,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('SalesTransaction(')
          ..write('transactionId: $transactionId, ')
          ..write('customer: $customer, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('payment: $payment, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      transactionId.hashCode,
      $mrjc(
          customer.hashCode,
          $mrjc(
              totalPrice.hashCode,
              $mrjc(
                  payment.hashCode,
                  $mrjc(
                      paymentStatus.hashCode,
                      $mrjc(createdAt.hashCode,
                          $mrjc(updatedAt.hashCode, note.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesTransaction &&
          other.transactionId == this.transactionId &&
          other.customer == this.customer &&
          other.totalPrice == this.totalPrice &&
          other.payment == this.payment &&
          other.paymentStatus == this.paymentStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.note == this.note);
}

class SalesTransactionsCompanion extends UpdateCompanion<SalesTransaction> {
  final Value<int> transactionId;
  final Value<String> customer;
  final Value<double> totalPrice;
  final Value<double> payment;
  final Value<bool> paymentStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> note;
  const SalesTransactionsCompanion({
    this.transactionId = const Value.absent(),
    this.customer = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.payment = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  SalesTransactionsCompanion.insert({
    this.transactionId = const Value.absent(),
    required String customer,
    required double totalPrice,
    required double payment,
    required bool paymentStatus,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String note,
  })  : customer = Value(customer),
        totalPrice = Value(totalPrice),
        payment = Value(payment),
        paymentStatus = Value(paymentStatus),
        note = Value(note);
  static Insertable<SalesTransaction> custom({
    Expression<int>? transactionId,
    Expression<String>? customer,
    Expression<double>? totalPrice,
    Expression<double>? payment,
    Expression<bool>? paymentStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (transactionId != null) 'transaction_id': transactionId,
      if (customer != null) 'customer': customer,
      if (totalPrice != null) 'total_price': totalPrice,
      if (payment != null) 'payment': payment,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (note != null) 'note': note,
    });
  }

  SalesTransactionsCompanion copyWith(
      {Value<int>? transactionId,
      Value<String>? customer,
      Value<double>? totalPrice,
      Value<double>? payment,
      Value<bool>? paymentStatus,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? note}) {
    return SalesTransactionsCompanion(
      transactionId: transactionId ?? this.transactionId,
      customer: customer ?? this.customer,
      totalPrice: totalPrice ?? this.totalPrice,
      payment: payment ?? this.payment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (customer.present) {
      map['customer'] = Variable<String>(customer.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (payment.present) {
      map['payment'] = Variable<double>(payment.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<bool>(paymentStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesTransactionsCompanion(')
          ..write('transactionId: $transactionId, ')
          ..write('customer: $customer, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('payment: $payment, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SalesTransactionsTable extends SalesTransactions
    with TableInfo<$SalesTransactionsTable, SalesTransaction> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SalesTransactionsTable(this._db, [this._alias]);
  final VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  late final GeneratedColumn<int?> transactionId = GeneratedColumn<int?>(
      'transaction_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _customerMeta = const VerificationMeta('customer');
  late final GeneratedColumn<String?> customer = GeneratedColumn<String?>(
      'customer', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _paymentMeta = const VerificationMeta('payment');
  late final GeneratedColumn<double?> payment = GeneratedColumn<double?>(
      'payment', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  late final GeneratedColumn<bool?> paymentStatus = GeneratedColumn<bool?>(
      'payment_status', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (payment_status IN (0, 1))');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        transactionId,
        customer,
        totalPrice,
        payment,
        paymentStatus,
        createdAt,
        updatedAt,
        note
      ];
  @override
  String get aliasedName => _alias ?? 'sales_transactions';
  @override
  String get actualTableName => 'sales_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<SalesTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('customer')) {
      context.handle(_customerMeta,
          customer.isAcceptableOrUnknown(data['customer']!, _customerMeta));
    } else if (isInserting) {
      context.missing(_customerMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('payment')) {
      context.handle(_paymentMeta,
          payment.isAcceptableOrUnknown(data['payment']!, _paymentMeta));
    } else if (isInserting) {
      context.missing(_paymentMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transactionId};
  @override
  SalesTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SalesTransaction.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SalesTransactionsTable createAlias(String alias) {
    return $SalesTransactionsTable(_db, alias);
  }
}

abstract class _$SharedDatabase extends GeneratedDatabase {
  _$SharedDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductsInTransactionsTable productsInTransactions =
      $ProductsInTransactionsTable(this);
  late final $SalesTransactionsTable salesTransactions =
      $SalesTransactionsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [products, productsInTransactions, salesTransactions];
}
