// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Model/InputFields.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5673005334699530012),
      name: 'InputField',
      lastPropertyId: const IdUid(10, 2164371237563942673),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3776836468584756256),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6654991970764247389),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2084931971201268450),
            name: 'item_name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8110418326314328706),
            name: 'grosswt',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2493868891350578029),
            name: 'netwt',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 9079621122475784988),
            name: 'purity',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7948893255734882714),
            name: 'remark',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 550220062062871440),
            name: 'certificate_no',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5962261155440973965),
            name: 'img',
            type: 23,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 2164371237563942673),
            name: 'huid',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 367122612160742558),
      name: 'ItemName',
      lastPropertyId: const IdUid(2, 2697273007086144908),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9017529687685861956),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2697273007086144908),
            name: 'item_name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String directory,
        int maxDBSizeInKB,
        int fileMode,
        int maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String macosApplicationGroup}) async =>
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
      lastEntityId: const IdUid(2, 367122612160742558),
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
    InputField: EntityDefinition<InputField>(
        model: _entities[0],
        toOneRelations: (InputField object) => [],
        toManyRelations: (InputField object) => {},
        getId: (InputField object) => object.id,
        setId: (InputField object, int id) {
          object.id = id;
        },
        objectToFB: (InputField object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name);
          final item_nameOffset = object.item_name == null
              ? null
              : fbb.writeString(object.item_name);
          final purityOffset =
              object.purity == null ? null : fbb.writeString(object.purity);
          final remarkOffset =
              object.remark == null ? null : fbb.writeString(object.remark);
          final imgOffset =
              object.img == null ? null : fbb.writeListInt8(object.img);
          final huidOffset =
              object.huid == null ? null : fbb.writeString(object.huid);
          fbb.startTable(11);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, item_nameOffset);
          fbb.addFloat64(3, object.grosswt);
          fbb.addFloat64(4, object.netwt);
          fbb.addOffset(5, purityOffset);
          fbb.addOffset(6, remarkOffset);
          fbb.addInt64(7, object.certificate_no);
          fbb.addOffset(8, imgOffset);
          fbb.addOffset(9, huidOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final imgValue = const fb.ListReader<int>(fb.Int8Reader())
              .vTableGetNullable(buffer, rootOffset, 20);
          final object = InputField(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              item_name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              grosswt: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              netwt: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              purity: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              remark: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              certificate_no: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              img: imgValue == null ? null : Uint8List.fromList(imgValue),
              huid: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 22));

          return object;
        }),
    ItemName: EntityDefinition<ItemName>(
        model: _entities[1],
        toOneRelations: (ItemName object) => [],
        toManyRelations: (ItemName object) => {},
        getId: (ItemName object) => object.id,
        setId: (ItemName object, int id) {
          object.id = id;
        },
        objectToFB: (ItemName object, fb.Builder fbb) {
          final item_nameOffset = object.item_name == null
              ? null
              : fbb.writeString(object.item_name);
          fbb.startTable(3);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, item_nameOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ItemName(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              item_name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [InputField] entity fields to define ObjectBox queries.
class InputField_ {
  /// see [InputField.id]
  static final id =
      QueryIntegerProperty<InputField>(_entities[0].properties[0]);

  /// see [InputField.name]
  static final name =
      QueryStringProperty<InputField>(_entities[0].properties[1]);

  /// see [InputField.item_name]
  static final item_name =
      QueryStringProperty<InputField>(_entities[0].properties[2]);

  /// see [InputField.grosswt]
  static final grosswt =
      QueryDoubleProperty<InputField>(_entities[0].properties[3]);

  /// see [InputField.netwt]
  static final netwt =
      QueryDoubleProperty<InputField>(_entities[0].properties[4]);

  /// see [InputField.purity]
  static final purity =
      QueryStringProperty<InputField>(_entities[0].properties[5]);

  /// see [InputField.remark]
  static final remark =
      QueryStringProperty<InputField>(_entities[0].properties[6]);

  /// see [InputField.certificate_no]
  static final certificate_no =
      QueryIntegerProperty<InputField>(_entities[0].properties[7]);

  /// see [InputField.img]
  static final img =
      QueryByteVectorProperty<InputField>(_entities[0].properties[8]);

  /// see [InputField.huid]
  static final huid =
      QueryStringProperty<InputField>(_entities[0].properties[9]);
}

/// [ItemName] entity fields to define ObjectBox queries.
class ItemName_ {
  /// see [ItemName.id]
  static final id = QueryIntegerProperty<ItemName>(_entities[1].properties[0]);

  /// see [ItemName.item_name]
  static final item_name =
      QueryStringProperty<ItemName>(_entities[1].properties[1]);
}
