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
    r'cmd': PropertySchema(
      id: 0,
      name: r'cmd',
      type: IsarType.long,
    ),
    r'conversationId': PropertySchema(
      id: 1,
      name: r'conversationId',
      type: IsarType.long,
    ),
    r'currentUserId': PropertySchema(
      id: 2,
      name: r'currentUserId',
      type: IsarType.long,
    ),
    r'message': PropertySchema(
      id: 3,
      name: r'message',
      type: IsarType.string,
    ),
    r'messageTime': PropertySchema(
      id: 4,
      name: r'messageTime',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 5,
      name: r'senderId',
      type: IsarType.long,
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
  bytesCount += 3 + object.message.length * 3;
  bytesCount += 3 + object.messageTime.length * 3;
  return bytesCount;
}

void _chatLogModelSerialize(
  ChatLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cmd);
  writer.writeLong(offsets[1], object.conversationId);
  writer.writeLong(offsets[2], object.currentUserId);
  writer.writeString(offsets[3], object.message);
  writer.writeString(offsets[4], object.messageTime);
  writer.writeLong(offsets[5], object.senderId);
}

ChatLogModel _chatLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatLogModel(
    cmd: reader.readLong(offsets[0]),
    conversationId: reader.readLong(offsets[1]),
    currentUserId: reader.readLong(offsets[2]),
    logId: id,
    message: reader.readString(offsets[3]),
    messageTime: reader.readString(offsets[4]),
    senderId: reader.readLong(offsets[5]),
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
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
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
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> cmdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cmd',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> cmdLessThan(
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition> cmdBetween(
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
      messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterFilterCondition>
      messageTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageTime',
        value: '',
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
}

extension ChatLogModelQueryObject
    on QueryBuilder<ChatLogModel, ChatLogModel, QFilterCondition> {}

extension ChatLogModelQueryLinks
    on QueryBuilder<ChatLogModel, ChatLogModel, QFilterCondition> {}

extension ChatLogModelQuerySortBy
    on QueryBuilder<ChatLogModel, ChatLogModel, QSortBy> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByCmdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.desc);
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> sortByMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageTime', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      sortByMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageTime', Sort.desc);
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
}

extension ChatLogModelQuerySortThenBy
    on QueryBuilder<ChatLogModel, ChatLogModel, QSortThenBy> {
  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByCmdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cmd', Sort.desc);
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

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy> thenByMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageTime', Sort.asc);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QAfterSortBy>
      thenByMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageTime', Sort.desc);
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
}

extension ChatLogModelQueryWhereDistinct
    on QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> {
  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByCmd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cmd');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct>
      distinctByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationId');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct>
      distinctByCurrentUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentUserId');
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctByMessageTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatLogModel, ChatLogModel, QDistinct> distinctBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId');
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

  QueryBuilder<ChatLogModel, int, QQueryOperations> cmdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cmd');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> conversationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationId');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> currentUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentUserId');
    });
  }

  QueryBuilder<ChatLogModel, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<ChatLogModel, String, QQueryOperations> messageTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageTime');
    });
  }

  QueryBuilder<ChatLogModel, int, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }
}
