// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/book_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1832771621720988779),
      name: 'BookModel',
      lastPropertyId: const IdUid(9, 6281084658745519037),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6250744827412055531),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2944763619827665034),
            name: 'bookCode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5805634414116402359),
            name: 'isbn',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1980427593471774507),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7641263196701340972),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4267845246189342005),
            name: 'category',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2263706391707619230),
            name: 'publishedDate',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3454720650623118256),
            name: 'price',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6281084658745519037),
            name: 'hardCover',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1832771621720988779),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    BookModel: EntityDefinition<BookModel>(
        model: _entities[0],
        toOneRelations: (BookModel object) => [],
        toManyRelations: (BookModel object) => {},
        getId: (BookModel object) => object.id,
        setId: (BookModel object, int id) {
          object.id = id;
        },
        objectToFB: (BookModel object, fb.Builder fbb) {
          final bookCodeOffset = fbb.writeString(object.bookCode);
          final isbnOffset = fbb.writeString(object.isbn);
          final titleOffset = fbb.writeString(object.title);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final categoryOffset = fbb.writeString(object.category);
          final publishedDateOffset = object.publishedDate == null
              ? null
              : fbb.writeString(object.publishedDate!);
          final hardCoverOffset = object.hardCover == null
              ? null
              : fbb.writeString(object.hardCover!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, bookCodeOffset);
          fbb.addOffset(2, isbnOffset);
          fbb.addOffset(3, titleOffset);
          fbb.addOffset(4, descriptionOffset);
          fbb.addOffset(5, categoryOffset);
          fbb.addOffset(6, publishedDateOffset);
          fbb.addFloat64(7, object.price);
          fbb.addOffset(8, hardCoverOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = BookModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              bookCode: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              isbn: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              category: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              publishedDate: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              price:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 18, 0),
              hardCover: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [BookModel] entity fields to define ObjectBox queries.
class BookModel_ {
  /// see [BookModel.id]
  static final id = QueryIntegerProperty<BookModel>(_entities[0].properties[0]);

  /// see [BookModel.bookCode]
  static final bookCode =
      QueryStringProperty<BookModel>(_entities[0].properties[1]);

  /// see [BookModel.isbn]
  static final isbn =
      QueryStringProperty<BookModel>(_entities[0].properties[2]);

  /// see [BookModel.title]
  static final title =
      QueryStringProperty<BookModel>(_entities[0].properties[3]);

  /// see [BookModel.description]
  static final description =
      QueryStringProperty<BookModel>(_entities[0].properties[4]);

  /// see [BookModel.category]
  static final category =
      QueryStringProperty<BookModel>(_entities[0].properties[5]);

  /// see [BookModel.publishedDate]
  static final publishedDate =
      QueryStringProperty<BookModel>(_entities[0].properties[6]);

  /// see [BookModel.price]
  static final price =
      QueryDoubleProperty<BookModel>(_entities[0].properties[7]);

  /// see [BookModel.hardCover]
  static final hardCover =
      QueryStringProperty<BookModel>(_entities[0].properties[8]);
}
