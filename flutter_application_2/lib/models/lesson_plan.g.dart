// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonPlanImpl _$$LessonPlanImplFromJson(Map<String, dynamic> json) =>
    _$LessonPlanImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subject: json['subject'] as String,
      grade: json['grade'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => LessonSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      objectives: json['objectives'] as String?,
      materials: json['materials'] as String?,
      assessment: json['assessment'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LessonPlanImplToJson(_$LessonPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'grade': instance.grade,
      'durationMinutes': instance.durationMinutes,
      'sections': instance.sections,
      'objectives': instance.objectives,
      'materials': instance.materials,
      'assessment': instance.assessment,
      'notes': instance.notes,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$LessonSectionImpl _$$LessonSectionImplFromJson(Map<String, dynamic> json) =>
    _$LessonSectionImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      activityType: json['activityType'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$LessonSectionImplToJson(_$LessonSectionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'durationMinutes': instance.durationMinutes,
      'activityType': instance.activityType,
      'resources': instance.resources,
    };
