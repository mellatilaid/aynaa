// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aynaa_versions_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAynaaVersionsEntityCollection on Isar {
  IsarCollection<AynaaVersionsEntity> get aynaaVersionsEntitys =>
      this.collection();
}

const AynaaVersionsEntitySchema = CollectionSchema(
  name: r'AynaaVersionsEntity',
  id: 8826641509927852117,
  properties: {
    r'entityID': PropertySchema(
      id: 0,
      name: r'entityID',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 1,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'localFilePath': PropertySchema(
      id: 2,
      name: r'localFilePath',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'oldUrl': PropertySchema(
      id: 4,
      name: r'oldUrl',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 6,
      name: r'url',
      type: IsarType.string,
    ),
    r'versionName': PropertySchema(
      id: 7,
      name: r'versionName',
      type: IsarType.string,
    )
  },
  estimateSize: _aynaaVersionsEntityEstimateSize,
  serialize: _aynaaVersionsEntitySerialize,
  deserialize: _aynaaVersionsEntityDeserialize,
  deserializeProp: _aynaaVersionsEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'entityID': IndexSchema(
      id: -7245804469100520399,
      name: r'entityID',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entityID',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _aynaaVersionsEntityGetId,
  getLinks: _aynaaVersionsEntityGetLinks,
  attach: _aynaaVersionsEntityAttach,
  version: '3.1.0+1',
);

int _aynaaVersionsEntityEstimateSize(
  AynaaVersionsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entityID.length * 3;
  {
    final value = object.localFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.oldUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.updatedAt.length * 3;
  bytesCount += 3 + object.url.length * 3;
  bytesCount += 3 + object.versionName.length * 3;
  return bytesCount;
}

void _aynaaVersionsEntitySerialize(
  AynaaVersionsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.entityID);
  writer.writeBool(offsets[1], object.isDeleted);
  writer.writeString(offsets[2], object.localFilePath);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.oldUrl);
  writer.writeString(offsets[5], object.updatedAt);
  writer.writeString(offsets[6], object.url);
  writer.writeString(offsets[7], object.versionName);
}

AynaaVersionsEntity _aynaaVersionsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AynaaVersionsEntity(
    entityID: reader.readString(offsets[0]),
    isDeleted: reader.readBoolOrNull(offsets[1]) ?? false,
    localFilePath: reader.readStringOrNull(offsets[2]),
    oldUrl: reader.readStringOrNull(offsets[4]),
    updatedAt: reader.readString(offsets[5]),
    url: reader.readString(offsets[6]),
    versionName: reader.readString(offsets[7]),
  );
  object.id = id;
  return object;
}

P _aynaaVersionsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aynaaVersionsEntityGetId(AynaaVersionsEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aynaaVersionsEntityGetLinks(
    AynaaVersionsEntity object) {
  return [];
}

void _aynaaVersionsEntityAttach(
    IsarCollection<dynamic> col, Id id, AynaaVersionsEntity object) {
  object.id = id;
}

extension AynaaVersionsEntityByIndex on IsarCollection<AynaaVersionsEntity> {
  Future<AynaaVersionsEntity?> getByEntityID(String entityID) {
    return getByIndex(r'entityID', [entityID]);
  }

  AynaaVersionsEntity? getByEntityIDSync(String entityID) {
    return getByIndexSync(r'entityID', [entityID]);
  }

  Future<bool> deleteByEntityID(String entityID) {
    return deleteByIndex(r'entityID', [entityID]);
  }

  bool deleteByEntityIDSync(String entityID) {
    return deleteByIndexSync(r'entityID', [entityID]);
  }

  Future<List<AynaaVersionsEntity?>> getAllByEntityID(
      List<String> entityIDValues) {
    final values = entityIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'entityID', values);
  }

  List<AynaaVersionsEntity?> getAllByEntityIDSync(List<String> entityIDValues) {
    final values = entityIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'entityID', values);
  }

  Future<int> deleteAllByEntityID(List<String> entityIDValues) {
    final values = entityIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'entityID', values);
  }

  int deleteAllByEntityIDSync(List<String> entityIDValues) {
    final values = entityIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'entityID', values);
  }

  Future<Id> putByEntityID(AynaaVersionsEntity object) {
    return putByIndex(r'entityID', object);
  }

  Id putByEntityIDSync(AynaaVersionsEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'entityID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEntityID(List<AynaaVersionsEntity> objects) {
    return putAllByIndex(r'entityID', objects);
  }

  List<Id> putAllByEntityIDSync(List<AynaaVersionsEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'entityID', objects, saveLinks: saveLinks);
  }
}

extension AynaaVersionsEntityQueryWhereSort
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QWhere> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AynaaVersionsEntityQueryWhere
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QWhereClause> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
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

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
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

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
      entityIDEqualTo(String entityID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityID',
        value: [entityID],
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterWhereClause>
      entityIDNotEqualTo(String entityID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityID',
              lower: [],
              upper: [entityID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityID',
              lower: [entityID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityID',
              lower: [entityID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityID',
              lower: [],
              upper: [entityID],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AynaaVersionsEntityQueryFilter on QueryBuilder<AynaaVersionsEntity,
    AynaaVersionsEntity, QFilterCondition> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entityID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityID',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      entityIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityID',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
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

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
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

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
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

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localFilePath',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localFilePath',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      localFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'oldUrl',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'oldUrl',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oldUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'oldUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'oldUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      oldUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'oldUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: '',
      ));
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterFilterCondition>
      versionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionName',
        value: '',
      ));
    });
  }
}

extension AynaaVersionsEntityQueryObject on QueryBuilder<AynaaVersionsEntity,
    AynaaVersionsEntity, QFilterCondition> {}

extension AynaaVersionsEntityQueryLinks on QueryBuilder<AynaaVersionsEntity,
    AynaaVersionsEntity, QFilterCondition> {}

extension AynaaVersionsEntityQuerySortBy
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QSortBy> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByEntityID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByEntityIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByLocalFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFilePath', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByLocalFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFilePath', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByOldUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldUrl', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByOldUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldUrl', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      sortByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
    });
  }
}

extension AynaaVersionsEntityQuerySortThenBy
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QSortThenBy> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByEntityID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByEntityIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByLocalFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFilePath', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByLocalFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFilePath', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByOldUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldUrl', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByOldUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldUrl', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QAfterSortBy>
      thenByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
    });
  }
}

extension AynaaVersionsEntityQueryWhereDistinct
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct> {
  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByEntityID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByLocalFilePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localFilePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByOldUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'oldUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByUpdatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QDistinct>
      distinctByVersionName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionName', caseSensitive: caseSensitive);
    });
  }
}

extension AynaaVersionsEntityQueryProperty
    on QueryBuilder<AynaaVersionsEntity, AynaaVersionsEntity, QQueryProperty> {
  QueryBuilder<AynaaVersionsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String, QQueryOperations>
      entityIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityID');
    });
  }

  QueryBuilder<AynaaVersionsEntity, bool, QQueryOperations>
      isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String?, QQueryOperations>
      localFilePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localFilePath');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String?, QQueryOperations>
      oldUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'oldUrl');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<AynaaVersionsEntity, String, QQueryOperations>
      versionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionName');
    });
  }
}
