// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_itmes_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeletedItmesEntityCollection on Isar {
  IsarCollection<DeletedItmesEntity> get deletedItmesEntitys =>
      this.collection();
}

const DeletedItmesEntitySchema = CollectionSchema(
  name: r'DeletedItmesEntity',
  id: 2849161178396113034,
  properties: {
    r'isCompleted': PropertySchema(
      id: 0,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isVersion': PropertySchema(
      id: 1,
      name: r'isVersion',
      type: IsarType.bool,
    ),
    r'itemID': PropertySchema(
      id: 2,
      name: r'itemID',
      type: IsarType.string,
    )
  },
  estimateSize: _deletedItmesEntityEstimateSize,
  serialize: _deletedItmesEntitySerialize,
  deserialize: _deletedItmesEntityDeserialize,
  deserializeProp: _deletedItmesEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'itemID': IndexSchema(
      id: 3205555870462710224,
      name: r'itemID',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'itemID',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _deletedItmesEntityGetId,
  getLinks: _deletedItmesEntityGetLinks,
  attach: _deletedItmesEntityAttach,
  version: '3.1.0+1',
);

int _deletedItmesEntityEstimateSize(
  DeletedItmesEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.itemID.length * 3;
  return bytesCount;
}

void _deletedItmesEntitySerialize(
  DeletedItmesEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCompleted);
  writer.writeBool(offsets[1], object.isVersion);
  writer.writeString(offsets[2], object.itemID);
}

DeletedItmesEntity _deletedItmesEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeletedItmesEntity(
    reader.readString(offsets[2]),
    reader.readBool(offsets[1]),
    reader.readBool(offsets[0]),
  );
  object.id = id;
  return object;
}

P _deletedItmesEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deletedItmesEntityGetId(DeletedItmesEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deletedItmesEntityGetLinks(
    DeletedItmesEntity object) {
  return [];
}

void _deletedItmesEntityAttach(
    IsarCollection<dynamic> col, Id id, DeletedItmesEntity object) {
  object.id = id;
}

extension DeletedItmesEntityByIndex on IsarCollection<DeletedItmesEntity> {
  Future<DeletedItmesEntity?> getByItemID(String itemID) {
    return getByIndex(r'itemID', [itemID]);
  }

  DeletedItmesEntity? getByItemIDSync(String itemID) {
    return getByIndexSync(r'itemID', [itemID]);
  }

  Future<bool> deleteByItemID(String itemID) {
    return deleteByIndex(r'itemID', [itemID]);
  }

  bool deleteByItemIDSync(String itemID) {
    return deleteByIndexSync(r'itemID', [itemID]);
  }

  Future<List<DeletedItmesEntity?>> getAllByItemID(List<String> itemIDValues) {
    final values = itemIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'itemID', values);
  }

  List<DeletedItmesEntity?> getAllByItemIDSync(List<String> itemIDValues) {
    final values = itemIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'itemID', values);
  }

  Future<int> deleteAllByItemID(List<String> itemIDValues) {
    final values = itemIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'itemID', values);
  }

  int deleteAllByItemIDSync(List<String> itemIDValues) {
    final values = itemIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'itemID', values);
  }

  Future<Id> putByItemID(DeletedItmesEntity object) {
    return putByIndex(r'itemID', object);
  }

  Id putByItemIDSync(DeletedItmesEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'itemID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByItemID(List<DeletedItmesEntity> objects) {
    return putAllByIndex(r'itemID', objects);
  }

  List<Id> putAllByItemIDSync(List<DeletedItmesEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'itemID', objects, saveLinks: saveLinks);
  }
}

extension DeletedItmesEntityQueryWhereSort
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QWhere> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeletedItmesEntityQueryWhere
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QWhereClause> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      itemIDEqualTo(String itemID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'itemID',
        value: [itemID],
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterWhereClause>
      itemIDNotEqualTo(String itemID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemID',
              lower: [],
              upper: [itemID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemID',
              lower: [itemID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemID',
              lower: [itemID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemID',
              lower: [],
              upper: [itemID],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DeletedItmesEntityQueryFilter
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QFilterCondition> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      isVersionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemID',
        value: '',
      ));
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterFilterCondition>
      itemIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemID',
        value: '',
      ));
    });
  }
}

extension DeletedItmesEntityQueryObject
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QFilterCondition> {}

extension DeletedItmesEntityQueryLinks
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QFilterCondition> {}

extension DeletedItmesEntityQuerySortBy
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QSortBy> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByIsVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVersion', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByIsVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVersion', Sort.desc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByItemID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemID', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      sortByItemIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemID', Sort.desc);
    });
  }
}

extension DeletedItmesEntityQuerySortThenBy
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QSortThenBy> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByIsVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVersion', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByIsVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVersion', Sort.desc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByItemID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemID', Sort.asc);
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QAfterSortBy>
      thenByItemIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemID', Sort.desc);
    });
  }
}

extension DeletedItmesEntityQueryWhereDistinct
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QDistinct> {
  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QDistinct>
      distinctByIsVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVersion');
    });
  }

  QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QDistinct>
      distinctByItemID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemID', caseSensitive: caseSensitive);
    });
  }
}

extension DeletedItmesEntityQueryProperty
    on QueryBuilder<DeletedItmesEntity, DeletedItmesEntity, QQueryProperty> {
  QueryBuilder<DeletedItmesEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeletedItmesEntity, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<DeletedItmesEntity, bool, QQueryOperations> isVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVersion');
    });
  }

  QueryBuilder<DeletedItmesEntity, String, QQueryOperations> itemIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemID');
    });
  }
}
