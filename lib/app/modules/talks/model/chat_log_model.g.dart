// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_log_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatLogModelCollection on Isar {
  IsarCollection<ChatLogModel> get chatLogModels => this.collection();
}

const ChatLogModelSchema = CollectionSchema(
  name: r'ChatLogModel',
  id: -8378373002482223657,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'contentTime': PropertySchema(
      id: 1,
      name: r'contentTime',
      type: IsarType.string,
    ),
    r'contentType': PropertySchema(
      id: 2,
      name: r'contentType',
      type: IsarType.long,
    ),
    r'conversationId': PropertySchema(
      id: 3,
      name: r'conversationId',
      type: IsarType.long,
    ),
    r'conversationType': PropertySchema(
      id: 4,
      name: r'conversationType',
      type: IsarType.long,
    ),
    r'currentUserId': PropertySchema(
      id: 5,
      name: r'currentUserId',
      type: IsarType.long,
    ),
    r'imagePath': PropertySchema(
      id: 6,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 7,
      name: r'senderId',
      type: IsarType.long,
    ),
    r'soundPath': PropertySchema(
      id: 8,
      name: r'soundPath',
      type: IsarType.string,
    )
  },
  estimateSize: _chatLogModelEstimateSize,
  serialize: _chatLogModelSerialize,
  deserialize: _chatLogModelDeserialize,
  deserializeProp: _chatLogModelDeserializeProp,
  idName: r'logId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _chatLogModelGetId,
  getLinks: _chatLogModelGetLinks,
  attach: _chatLogModelAttach,
  version: '3.1.0+1',
);

int _chatLogModelEstimateSize(
  ChatLogModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.contentTime.length * 3;
  {
    final value = object.imagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.soundPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _chatLogModelSerialize(
  ChatLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeString(offsets[1], object.contentTime);
  writer.writeLong(offsets[2], object.contentType);
  writer.writeLong(offsets[3], object.conversationId);
  writer.writeLong(offsets[4], object.conversationType);
  writer.writeLong(offsets[5], object.currentUserId);
  writer.writeString(offsets[6], object.imagePath);
  writer.writeLong(offsets[7], object.senderId);
  writer.writeString(offsets[8], object.soundPath);
}

ChatLogModel _chatLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatLogModel(
    content: reader.readString(offsets[0]),
    contentTime: reader.readString(offsets[1]),
    contentType: reader.readLong(offsets[2]),
    conversationId: reader.readLong(offsets[3]),
    conversationType: reader.readLong(offsets[4]),
    currentUserId: reader.readLong(offsets[5]),
    imagePath: reader.readStringOrNull(offsets[6]),
    logId: id,
    senderId: reader.readLong(offsets[7]),
    soundPath: reader.readStringOrNull(offsets[8]),
  );
  return object;
}

P _chatLogModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _chatLogModelGetId(ChatLogModel object) {
  return object.logId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _chatLogModelGetLinks(ChatLogModel object) {
  return [];
}

void _chatLogModelAttach(
    IsarCollection<dynamic> col, Id id, ChatLogModel object) {
  object.logId = id;
}

extension ChatLogModelQueryWhereSort
    on QueryBuilder<ChatLogModel, ChatLogModel, QWhere> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhere> anyLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatLogModelQueryWhere
    on QueryBuilder<ChatLogModel, ChatLogModel, QWhereClause> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhereClause> logIdEqualTo(
      Id logId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: logId,
        upper: logId,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhereClause> logIdNotEqualTo(
      Id logId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: logId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: logId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: logId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: logId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhereClause> logIdGreaterThan(
      Id logId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: logId, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhereClause> logIdLessThan(
      Id logId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: logId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterWhereClause> logIdBetween(
    Id lowerLogId,
    Id upperLogId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLogId,
        includeLower: includeLower,
        upper: upperLogId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatLogModelQueryFilter
    on QueryBuilder<ChatLogModel, ChatLogModel, QFilterCondition> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTypeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      contentTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationIdGreaterThan(
    int value, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationIdLessThan(
    int value, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationTypeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      conversationTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      currentUserIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      currentUserIdGreaterThan(
    int value, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      currentUserIdLessThan(
    int value, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      currentUserIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagePath',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagePath',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      logIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logId',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      logIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logId',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> logIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      logIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> logIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> logIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      senderIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      senderIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      senderIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      senderIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soundPath',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soundPath',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soundPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soundPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soundPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      soundPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soundPath',
        value: '',
      ));
    });
  }
}

extension ChatLogModelQueryObject
    on QueryBuilder<ChatLogModel, ChatLogModel, QFilterCondition> {}

extension ChatLogModelQueryLinks
    on QueryBuilder<ChatLogModel, ChatLogModel, QFilterCondition> {}

extension ChatLogModelQuerySortBy
    on QueryBuilder<ChatLogModel, ChatLogModel, QSortBy> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByContentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTime', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByContentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTime', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByConversationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationType', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByConversationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationType', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByCurrentUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortBySoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundPath', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortBySoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundPath', Sort.desc);
    });
  }
}

extension ChatLogModelQuerySortThenBy
    on QueryBuilder<ChatLogModel, ChatLogModel, QSortThenBy> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByContentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTime', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByContentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentTime', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByConversationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationType', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByConversationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationType', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByCurrentUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUserId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByLogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenBySoundPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundPath', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenBySoundPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundPath', Sort.desc);
    });
  }
}

extension ChatLogModelQueryWhereDistinct
    on QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> {
  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByContentTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct>
      distinctByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationId');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct>
      distinctByConversationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationType');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct>
      distinctByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentUserId');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctBySoundPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundPath', caseSensitive: caseSensitive);
    });
  }
}

extension ChatLogModelQueryProperty
    on QueryBuilder<ChatLogModel, ChatLogModel, QQueryProperty> {
  QueryBuilder<ChatLogModel, int, QQueryOperations> logIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logId');
    });
  }

  QueryBuilder<ChatLogModel, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<ChatLogModel, String, QQueryOperations> contentTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentTime');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> conversationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationId');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> conversationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationType');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> currentUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentUserId');
    });
  }

  QueryBuilder<ChatLogModel, String?, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<ChatLogModel, String?, QQueryOperations> soundPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundPath');
    });
  }
}
