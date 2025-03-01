// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingsEntityCollection on Isar {
  IsarCollection<SettingsEntity> get settingsEntitys => this.collection();
}

const SettingsEntitySchema = CollectionSchema(
  name: r'SettingsEntity',
  id: -7271317039764597112,
  properties: {
    r'entityID': PropertySchema(
      id: 0,
      name: r'entityID',
      type: IsarType.string,
    ),
    r'lastTimeExamsFetched': PropertySchema(
      id: 1,
      name: r'lastTimeExamsFetched',
      type: IsarType.string,
    ),
    r'lastTimeLessonssFetched': PropertySchema(
      id: 2,
      name: r'lastTimeLessonssFetched',
      type: IsarType.string,
    ),
    r'lastTimeSectionsFetched': PropertySchema(
      id: 3,
      name: r'lastTimeSectionsFetched',
      type: IsarType.string,
    ),
    r'lastTimeSubjectsFetched': PropertySchema(
      id: 4,
      name: r'lastTimeSubjectsFetched',
      type: IsarType.string,
    ),
    r'lastTimeVersionsFetched': PropertySchema(
      id: 5,
      name: r'lastTimeVersionsFetched',
      type: IsarType.string,
    )
  },
  estimateSize: _settingsEntityEstimateSize,
  serialize: _settingsEntitySerialize,
  deserialize: _settingsEntityDeserialize,
  deserializeProp: _settingsEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'entityID': IndexSchema(
      id: -7245804469100520399,
      name: r'entityID',
      unique: true,
      replace: true,
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
  getId: _settingsEntityGetId,
  getLinks: _settingsEntityGetLinks,
  attach: _settingsEntityAttach,
  version: '3.1.0+1',
);

int _settingsEntityEstimateSize(
  SettingsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entityID.length * 3;
  {
    final value = object.lastTimeExamsFetched;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastTimeLessonssFetched;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastTimeSectionsFetched;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastTimeSubjectsFetched;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastTimeVersionsFetched;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _settingsEntitySerialize(
  SettingsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.entityID);
  writer.writeString(offsets[1], object.lastTimeExamsFetched);
  writer.writeString(offsets[2], object.lastTimeLessonssFetched);
  writer.writeString(offsets[3], object.lastTimeSectionsFetched);
  writer.writeString(offsets[4], object.lastTimeSubjectsFetched);
  writer.writeString(offsets[5], object.lastTimeVersionsFetched);
}

SettingsEntity _settingsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SettingsEntity(
    entityID: reader.readString(offsets[0]),
    lastTimeExamsFetched: reader.readStringOrNull(offsets[1]),
    lastTimeLessonssFetched: reader.readStringOrNull(offsets[2]),
    lastTimeSectionsFetched: reader.readStringOrNull(offsets[3]),
    lastTimeSubjectsFetched: reader.readStringOrNull(offsets[4]),
    lastTimeVersionsFetched: reader.readStringOrNull(offsets[5]),
  );
  object.id = id;
  return object;
}

P _settingsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingsEntityGetId(SettingsEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsEntityGetLinks(SettingsEntity object) {
  return [];
}

void _settingsEntityAttach(
    IsarCollection<dynamic> col, Id id, SettingsEntity object) {
  object.id = id;
}

extension SettingsEntityByIndex on IsarCollection<SettingsEntity> {
  Future<SettingsEntity?> getByEntityID(String entityID) {
    return getByIndex(r'entityID', [entityID]);
  }

  SettingsEntity? getByEntityIDSync(String entityID) {
    return getByIndexSync(r'entityID', [entityID]);
  }

  Future<bool> deleteByEntityID(String entityID) {
    return deleteByIndex(r'entityID', [entityID]);
  }

  bool deleteByEntityIDSync(String entityID) {
    return deleteByIndexSync(r'entityID', [entityID]);
  }

  Future<List<SettingsEntity?>> getAllByEntityID(List<String> entityIDValues) {
    final values = entityIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'entityID', values);
  }

  List<SettingsEntity?> getAllByEntityIDSync(List<String> entityIDValues) {
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

  Future<Id> putByEntityID(SettingsEntity object) {
    return putByIndex(r'entityID', object);
  }

  Id putByEntityIDSync(SettingsEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'entityID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEntityID(List<SettingsEntity> objects) {
    return putAllByIndex(r'entityID', objects);
  }

  List<Id> putAllByEntityIDSync(List<SettingsEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'entityID', objects, saveLinks: saveLinks);
  }
}

extension SettingsEntityQueryWhereSort
    on QueryBuilder<SettingsEntity, SettingsEntity, QWhere> {
  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsEntityQueryWhere
    on QueryBuilder<SettingsEntity, SettingsEntity, QWhereClause> {
  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause>
      entityIDEqualTo(String entityID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityID',
        value: [entityID],
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterWhereClause>
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

extension SettingsEntityQueryFilter
    on QueryBuilder<SettingsEntity, SettingsEntity, QFilterCondition> {
  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      entityIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      entityIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      entityIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityID',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      entityIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityID',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeExamsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeExamsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeExamsFetched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTimeExamsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTimeExamsFetched',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeExamsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeExamsFetchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTimeExamsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeLessonssFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeLessonssFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeLessonssFetched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTimeLessonssFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTimeLessonssFetched',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeLessonssFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeLessonssFetchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTimeLessonssFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeSectionsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeSectionsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeSectionsFetched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTimeSectionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTimeSectionsFetched',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeSectionsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSectionsFetchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTimeSectionsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeSubjectsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeSubjectsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeSubjectsFetched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTimeSubjectsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTimeSubjectsFetched',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeSubjectsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeSubjectsFetchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTimeSubjectsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeVersionsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeVersionsFetched',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeVersionsFetched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTimeVersionsFetched',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTimeVersionsFetched',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeVersionsFetched',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterFilterCondition>
      lastTimeVersionsFetchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTimeVersionsFetched',
        value: '',
      ));
    });
  }
}

extension SettingsEntityQueryObject
    on QueryBuilder<SettingsEntity, SettingsEntity, QFilterCondition> {}

extension SettingsEntityQueryLinks
    on QueryBuilder<SettingsEntity, SettingsEntity, QFilterCondition> {}

extension SettingsEntityQuerySortBy
    on QueryBuilder<SettingsEntity, SettingsEntity, QSortBy> {
  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy> sortByEntityID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByEntityIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeExamsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeExamsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeExamsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeExamsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeLessonssFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeLessonssFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeLessonssFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeLessonssFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeSectionsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSectionsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeSectionsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSectionsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeSubjectsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSubjectsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeSubjectsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSubjectsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeVersionsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeVersionsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      sortByLastTimeVersionsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeVersionsFetched', Sort.desc);
    });
  }
}

extension SettingsEntityQuerySortThenBy
    on QueryBuilder<SettingsEntity, SettingsEntity, QSortThenBy> {
  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy> thenByEntityID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByEntityIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityID', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeExamsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeExamsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeExamsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeExamsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeLessonssFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeLessonssFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeLessonssFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeLessonssFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeSectionsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSectionsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeSectionsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSectionsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeSubjectsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSubjectsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeSubjectsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeSubjectsFetched', Sort.desc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeVersionsFetched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeVersionsFetched', Sort.asc);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QAfterSortBy>
      thenByLastTimeVersionsFetchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeVersionsFetched', Sort.desc);
    });
  }
}

extension SettingsEntityQueryWhereDistinct
    on QueryBuilder<SettingsEntity, SettingsEntity, QDistinct> {
  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct> distinctByEntityID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct>
      distinctByLastTimeExamsFetched({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeExamsFetched',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct>
      distinctByLastTimeLessonssFetched({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeLessonssFetched',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct>
      distinctByLastTimeSectionsFetched({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeSectionsFetched',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct>
      distinctByLastTimeSubjectsFetched({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeSubjectsFetched',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsEntity, SettingsEntity, QDistinct>
      distinctByLastTimeVersionsFetched({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeVersionsFetched',
          caseSensitive: caseSensitive);
    });
  }
}

extension SettingsEntityQueryProperty
    on QueryBuilder<SettingsEntity, SettingsEntity, QQueryProperty> {
  QueryBuilder<SettingsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SettingsEntity, String, QQueryOperations> entityIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityID');
    });
  }

  QueryBuilder<SettingsEntity, String?, QQueryOperations>
      lastTimeExamsFetchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeExamsFetched');
    });
  }

  QueryBuilder<SettingsEntity, String?, QQueryOperations>
      lastTimeLessonssFetchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeLessonssFetched');
    });
  }

  QueryBuilder<SettingsEntity, String?, QQueryOperations>
      lastTimeSectionsFetchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeSectionsFetched');
    });
  }

  QueryBuilder<SettingsEntity, String?, QQueryOperations>
      lastTimeSubjectsFetchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeSubjectsFetched');
    });
  }

  QueryBuilder<SettingsEntity, String?, QQueryOperations>
      lastTimeVersionsFetchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeVersionsFetched');
    });
  }
}
