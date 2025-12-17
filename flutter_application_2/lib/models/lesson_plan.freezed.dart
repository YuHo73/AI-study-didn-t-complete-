// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonPlan _$LessonPlanFromJson(Map<String, dynamic> json) {
  return _LessonPlan.fromJson(json);
}

/// @nodoc
mixin _$LessonPlan {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  List<LessonSection> get sections => throw _privateConstructorUsedError;
  String? get objectives => throw _privateConstructorUsedError;
  String? get materials => throw _privateConstructorUsedError;
  String? get assessment => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LessonPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonPlanCopyWith<LessonPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonPlanCopyWith<$Res> {
  factory $LessonPlanCopyWith(
          LessonPlan value, $Res Function(LessonPlan) then) =
      _$LessonPlanCopyWithImpl<$Res, LessonPlan>;
  @useResult
  $Res call(
      {String id,
      String title,
      String subject,
      String grade,
      int durationMinutes,
      List<LessonSection> sections,
      String? objectives,
      String? materials,
      String? assessment,
      String? notes,
      bool isFavorite,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LessonPlanCopyWithImpl<$Res, $Val extends LessonPlan>
    implements $LessonPlanCopyWith<$Res> {
  _$LessonPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subject = null,
    Object? grade = null,
    Object? durationMinutes = null,
    Object? sections = null,
    Object? objectives = freezed,
    Object? materials = freezed,
    Object? assessment = freezed,
    Object? notes = freezed,
    Object? isFavorite = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<LessonSection>,
      objectives: freezed == objectives
          ? _value.objectives
          : objectives // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as String?,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonPlanImplCopyWith<$Res>
    implements $LessonPlanCopyWith<$Res> {
  factory _$$LessonPlanImplCopyWith(
          _$LessonPlanImpl value, $Res Function(_$LessonPlanImpl) then) =
      __$$LessonPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String subject,
      String grade,
      int durationMinutes,
      List<LessonSection> sections,
      String? objectives,
      String? materials,
      String? assessment,
      String? notes,
      bool isFavorite,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$LessonPlanImplCopyWithImpl<$Res>
    extends _$LessonPlanCopyWithImpl<$Res, _$LessonPlanImpl>
    implements _$$LessonPlanImplCopyWith<$Res> {
  __$$LessonPlanImplCopyWithImpl(
      _$LessonPlanImpl _value, $Res Function(_$LessonPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subject = null,
    Object? grade = null,
    Object? durationMinutes = null,
    Object? sections = null,
    Object? objectives = freezed,
    Object? materials = freezed,
    Object? assessment = freezed,
    Object? notes = freezed,
    Object? isFavorite = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LessonPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<LessonSection>,
      objectives: freezed == objectives
          ? _value.objectives
          : objectives // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as String?,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonPlanImpl implements _LessonPlan {
  const _$LessonPlanImpl(
      {required this.id,
      required this.title,
      required this.subject,
      required this.grade,
      required this.durationMinutes,
      required final List<LessonSection> sections,
      this.objectives,
      this.materials,
      this.assessment,
      this.notes,
      this.isFavorite = false,
      this.createdAt,
      this.updatedAt})
      : _sections = sections;

  factory _$LessonPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subject;
  @override
  final String grade;
  @override
  final int durationMinutes;
  final List<LessonSection> _sections;
  @override
  List<LessonSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final String? objectives;
  @override
  final String? materials;
  @override
  final String? assessment;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LessonPlan(id: $id, title: $title, subject: $subject, grade: $grade, durationMinutes: $durationMinutes, sections: $sections, objectives: $objectives, materials: $materials, assessment: $assessment, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.objectives, objectives) ||
                other.objectives == objectives) &&
            (identical(other.materials, materials) ||
                other.materials == materials) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subject,
      grade,
      durationMinutes,
      const DeepCollectionEquality().hash(_sections),
      objectives,
      materials,
      assessment,
      notes,
      isFavorite,
      createdAt,
      updatedAt);

  /// Create a copy of LessonPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonPlanImplCopyWith<_$LessonPlanImpl> get copyWith =>
      __$$LessonPlanImplCopyWithImpl<_$LessonPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonPlanImplToJson(
      this,
    );
  }
}

abstract class _LessonPlan implements LessonPlan {
  const factory _LessonPlan(
      {required final String id,
      required final String title,
      required final String subject,
      required final String grade,
      required final int durationMinutes,
      required final List<LessonSection> sections,
      final String? objectives,
      final String? materials,
      final String? assessment,
      final String? notes,
      final bool isFavorite,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$LessonPlanImpl;

  factory _LessonPlan.fromJson(Map<String, dynamic> json) =
      _$LessonPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subject;
  @override
  String get grade;
  @override
  int get durationMinutes;
  @override
  List<LessonSection> get sections;
  @override
  String? get objectives;
  @override
  String? get materials;
  @override
  String? get assessment;
  @override
  String? get notes;
  @override
  bool get isFavorite;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of LessonPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonPlanImplCopyWith<_$LessonPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LessonSection _$LessonSectionFromJson(Map<String, dynamic> json) {
  return _LessonSection.fromJson(json);
}

/// @nodoc
mixin _$LessonSection {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String? get activityType => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  /// Serializes this LessonSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonSectionCopyWith<LessonSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonSectionCopyWith<$Res> {
  factory $LessonSectionCopyWith(
          LessonSection value, $Res Function(LessonSection) then) =
      _$LessonSectionCopyWithImpl<$Res, LessonSection>;
  @useResult
  $Res call(
      {String title,
      String content,
      int durationMinutes,
      String? activityType,
      List<String>? resources});
}

/// @nodoc
class _$LessonSectionCopyWithImpl<$Res, $Val extends LessonSection>
    implements $LessonSectionCopyWith<$Res> {
  _$LessonSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? durationMinutes = null,
    Object? activityType = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      activityType: freezed == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonSectionImplCopyWith<$Res>
    implements $LessonSectionCopyWith<$Res> {
  factory _$$LessonSectionImplCopyWith(
          _$LessonSectionImpl value, $Res Function(_$LessonSectionImpl) then) =
      __$$LessonSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      int durationMinutes,
      String? activityType,
      List<String>? resources});
}

/// @nodoc
class __$$LessonSectionImplCopyWithImpl<$Res>
    extends _$LessonSectionCopyWithImpl<$Res, _$LessonSectionImpl>
    implements _$$LessonSectionImplCopyWith<$Res> {
  __$$LessonSectionImplCopyWithImpl(
      _$LessonSectionImpl _value, $Res Function(_$LessonSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? durationMinutes = null,
    Object? activityType = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$LessonSectionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      activityType: freezed == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonSectionImpl implements _LessonSection {
  const _$LessonSectionImpl(
      {required this.title,
      required this.content,
      required this.durationMinutes,
      this.activityType,
      final List<String>? resources})
      : _resources = resources;

  factory _$LessonSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonSectionImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final int durationMinutes;
  @override
  final String? activityType;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LessonSection(title: $title, content: $content, durationMinutes: $durationMinutes, activityType: $activityType, resources: $resources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonSectionImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content, durationMinutes,
      activityType, const DeepCollectionEquality().hash(_resources));

  /// Create a copy of LessonSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonSectionImplCopyWith<_$LessonSectionImpl> get copyWith =>
      __$$LessonSectionImplCopyWithImpl<_$LessonSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonSectionImplToJson(
      this,
    );
  }
}

abstract class _LessonSection implements LessonSection {
  const factory _LessonSection(
      {required final String title,
      required final String content,
      required final int durationMinutes,
      final String? activityType,
      final List<String>? resources}) = _$LessonSectionImpl;

  factory _LessonSection.fromJson(Map<String, dynamic> json) =
      _$LessonSectionImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  int get durationMinutes;
  @override
  String? get activityType;
  @override
  List<String>? get resources;

  /// Create a copy of LessonSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonSectionImplCopyWith<_$LessonSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
