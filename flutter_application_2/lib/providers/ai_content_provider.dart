import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ai_model.dart';
import '../models/lesson_plan.dart';
import '../services/ai_service.dart';

/// AI服务提供者
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService(baseUrl: 'https://api.example.com/v1');
});

/// AI内容生成状态
class AIContentState {
  final bool isLoading;
  final String? error;
  final LessonPlan? lessonPlan;
  final Map<String, dynamic>? generatedContent;
  final bool isEnhancing;

  const AIContentState({
    this.isLoading = false,
    this.error,
    this.lessonPlan,
    this.generatedContent,
    this.isEnhancing = false,
  });

  AIContentState copyWith({
    bool? isLoading,
    String? error,
    LessonPlan? lessonPlan,
    Map<String, dynamic>? generatedContent,
    bool? isEnhancing,
  }) {
    return AIContentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lessonPlan: lessonPlan ?? this.lessonPlan,
      generatedContent: generatedContent ?? this.generatedContent,
      isEnhancing: isEnhancing ?? this.isEnhancing,
    );
  }
}

/// AI内容生成控制器
class AIContentNotifier extends StateNotifier<AIContentState> {
  final AIService _aiService;

  AIContentNotifier(this._aiService) : super(const AIContentState());

  /// 生成教案
  Future<void> generateLessonPlan({
    required String topic,
    required String grade,
    required String subject,
    required int durationMinutes,
    required AIModel model,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final lessonPlan = await _aiService.generateLessonPlan(
        topic: topic,
        grade: grade,
        subject: subject,
        durationMinutes: durationMinutes,
        model: model,
      );

      state = state.copyWith(
        isLoading: false,
        lessonPlan: lessonPlan,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '生成教案失败: ${e.toString()}',
      );
    }
  }

  /// 生成多模态内容
  Future<void> generateContent({
    required String prompt,
    required ContentType type,
    required AIModel model,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final content = await _aiService.generateContent(
        prompt: prompt,
        type: type,
        model: model,
      );

      state = state.copyWith(
        isLoading: false,
        generatedContent: content,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '生成内容失败: ${e.toString()}',
      );
    }
  }

  /// 增强内容
  Future<void> enhanceContent({
    required Map<String, dynamic> content,
    required EnhancementType enhancementType,
  }) async {
    state = state.copyWith(isEnhancing: true, error: null);

    try {
      final enhancedContent = await _aiService.enhanceContent(
        content: content,
        enhancementType: enhancementType,
      );

      state = state.copyWith(
        isEnhancing: false,
        generatedContent: enhancedContent,
      );
    } catch (e) {
      state = state.copyWith(
        isEnhancing: false,
        error: '增强内容失败: ${e.toString()}',
      );
    }
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 清除生成的内容
  void clearContent() {
    state = state.copyWith(
      generatedContent: null,
      lessonPlan: null,
      error: null,
    );
  }
}

/// AI内容生成提供者
final aiContentProvider =
    StateNotifierProvider<AIContentNotifier, AIContentState>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  return AIContentNotifier(aiService);
}); 