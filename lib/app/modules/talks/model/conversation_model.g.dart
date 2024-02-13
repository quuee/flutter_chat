// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConversationModelCollection on Isar {
  IsarCollection<ConversationModel> get conversationModels => this.collection();
}

const ConversationModelSchema = CollectionSchema(
  name: r'ConversationModel',
  id: 828316010797989352,
  properties: {
    r'avatarUrl': PropertySchema(
      id: 0,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'cmd': PropertySchema(
      id: 1,
      name: r'cmd',
      type: IsarType.long,
    ),
    r'contactUserId': PropertySchema(
      id: 2,
      name: r'contactUserId',
      type: IsarType.longList,
    ),
    r'conversationName': PropertySchema(
      id: 3,
      name: r'conversationName',
      type: IsarType.string,
    ),
    r'currentUserId': PropertySchema(
      id: 4,
      name: r'currentUserId',
      type: IsarType.long,
    ),
    r'lastMessage': PropertySchema(
      id: 5,
      name: r'lastMessage',
      type: IsarType.string,
    ),
    r'lastTime': PropertySchema(
      id: 6,
      name: r'lastTime',
      type: IsarType.string,
    )
  },
  estimateSize: _conversationModelEstimateSize,
  serialize: _conversationModelSerialize,
  deserialize: _conversationModelDeserialize,
  deserializeProp: _conversationModelDeserializeProp,
  idName: r'conversationId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _conversationModelGetId,
  getLinks: _conversationModelGetLinks,
  attach: _conversationModelAttach,
  version: '3.1.0+1',
);

int _conversationModelEstimateSize(
  ConversationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avatarUrl.length * 3;
  bytesCount += 3 + object.contactUserIds.length * 8;
  bytesCount += 3 + object.conversationName.length * 3;
  {
    final value = object.lastMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _conversationModelSerialize(
  ConversationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarUrl);
  writer.writeLong(offsets[1], object.cmd);
  writer.writeLongList(offsets[2], object.contactUserIds);
  writer.writeString(offsets[3], object.conversationName);
  writer.writeLong(offsets[4], object.currentUserId);
  writer.writeString(offsets[5], object.lastMessage);
  writer.writeString(offsets[6], object.lastTime);
}

ConversationModel _conversationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConversationModel(
    avatarUrl: reader.readString(offsets[0]),
    cmd: reader.readLong(offsets[1]),
    contactUserIds: reader.readLongList(offsets[2]) ?? [],
    conversationId: id,
    conversationName: reader.readString(offsets[3]),
    currentUserId: reader.readLongOrNull(offsets[4]),
    lastMessage: reader.readStringOrNull(offsets[5]),
    lastTime: reader.readStringOrNull(offsets[6]),
  );
  return object;
}

P _conversationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _conversationModelGetId(ConversationModel object) {
  return object.conversationId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _conversationModelGetLinks(
    ConversationModel object) {
  return [];
}

void _conversationModelAttach(
    IsarCollection<dynamic> col, Id id, ConversationModel object) {
  object.conversationId = id;
}

extension ConversationModelQueryWhereSort
    on QueryBuilder<ConversationModel, ConversationModel, QWhere> {
  QueryBuilder<ConversationModel, ConversationModel, QAfterWhere>
      anyConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConversationModelQueryWhere
    on QueryBuilder<ConversationModel, ConversationModel, QWhereClause> {
  QueryBuilder<ConversationModel, ConversationModel, QAfterWhereClause>
      conversationIdEqualTo(Id conversationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: conversationId,
        upper: conversationId,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterWhereClause>
      conversationIdNotEqualTo(Id conversationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: conversationId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: conversationId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: conversationId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: conversationId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterWhereClause>
      conversationIdGreaterThan(Id conversationId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: conversationId, includeLower: include),
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterWhereClause>
      conversationIdLessThan(Id conversationId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: conversationId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterWhereClause>
      conversationIdBetween(
    Id lowerConversationId,
    Id upperConversationId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerConversationId,
        includeLower: includeLower,
        upper: upperConversationId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConversationModelQueryFilter
    on QueryBuilder<ConversationModel, ConversationModel, QFilterCondition> {
  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      cmdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cmd',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      cmdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cmd',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      cmdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cmd',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      cmdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cmd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      contactUserIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactUserId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'conversationId',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'conversationId',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conversationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conversationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationName',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      conversationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conversationName',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentUserId',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentUserId',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      currentUserIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTime',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTime',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterFilterCondition>
      lastTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastTime',
        value: '',
      ));
    });
  }
}

extension ConversationModelQueryObject
    on QueryBuilder<ConversationModel, ConversationModel, QFilterCondition> {}

extension ConversationModelQueryLinks
    on QueryBuilder<ConversationModel, ConversationModel, QFilterCondition> {}

extension ConversationModelQuerySortBy
    on QueryBuilder<ConversationModel, ConversationModel, QSortBy> {
  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy> sortByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByCmdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByConversationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationName', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByConversationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationName', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByCurrentUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByLastMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByLastMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByLastTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTime', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      sortByLastTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTime', Sort.desc);
    });
  }
}

extension ConversationModelQuerySortThenBy
    on QueryBuilder<ConversationModel, ConversationModel, QSortThenBy> {
  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy> thenByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByCmdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByConversationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationName', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByConversationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationName', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByCurrentUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByLastMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByLastMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessage', Sort.desc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByLastTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTime', Sort.asc);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QAfterSortBy>
      thenByLastTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTime', Sort.desc);
    });
  }
}

extension ConversationModelQueryWhereDistinct
    on QueryBuilder<ConversationModel, ConversationModel, QDistinct> {
  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByAvatarUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cmd');
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByContactUserIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactUserId');
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByConversationName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentUserId');
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByLastMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConversationModel, ConversationModel, QDistinct>
      distinctByLastTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTime', caseSensitive: caseSensitive);
    });
  }
}

extension ConversationModelQueryProperty
    on QueryBuilder<ConversationModel, ConversationModel, QQueryProperty> {
  QueryBuilder<ConversationModel, int, QQueryOperations>
      conversationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationId');
    });
  }

  QueryBuilder<ConversationModel, String, QQueryOperations>
      avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<ConversationModel, int, QQueryOperations> cmdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cmd');
    });
  }

  QueryBuilder<ConversationModel, List<int>, QQueryOperations>
      contactUserIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactUserId');
    });
  }

  QueryBuilder<ConversationModel, String, QQueryOperations>
      conversationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationName');
    });
  }

  QueryBuilder<ConversationModel, int?, QQueryOperations>
      currentUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentUserId');
    });
  }

  QueryBuilder<ConversationModel, String?, QQueryOperations>
      lastMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessage');
    });
  }

  QueryBuilder<ConversationModel, String?, QQueryOperations>
      lastTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTime');
    });
  }
}
