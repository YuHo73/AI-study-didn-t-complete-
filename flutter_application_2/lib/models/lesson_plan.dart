import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'lesson_plan.freezed.dart';
part 'lesson_plan.g.dart';

/// 教案模型类，用于表示AI生成的教案内容
@freezed
class LessonPlan with _$LessonPlan {
  const factory LessonPlan({
    required String id,
    required String title,
    required String subject,
    required String grade,
    required int durationMinutes,
    required List<LessonSection> sections,
    String? objectives,
    String? materials,
    String? assessment,
    String? notes,
    @Default(false) bool isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LessonPlan;

  /// 创建新的教案实例
  factory LessonPlan.create({
    required String title,
    required String subject,
    required String grade,
    required int durationMinutes,
    required List<LessonSection> sections,
    String? objectives,
    String? materials,
    String? assessment,
    String? notes,
  }) {
    return LessonPlan(
      id: const Uuid().v4(),
      title: title,
      subject: subject,
      grade: grade,
      durationMinutes: durationMinutes,
      sections: sections,
      objectives: objectives,
      materials: materials,
      assessment: assessment,
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory LessonPlan.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanFromJson(json);
}

/// 教案章节模型，表示教案中的一个教学环节
@freezed
class LessonSection with _$LessonSection {
  const factory LessonSection({
    required String title,
    required String content,
    required int durationMinutes,
    String? activityType,
    List<String>? resources,
  }) = _LessonSection;

  factory LessonSection.fromJson(Map<String, dynamic> json) =>
      _$LessonSectionFromJson(json);
} 