import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ai_model.dart';
import '../models/lesson_plan.dart';

/// 内容类型枚举，表示可以生成的内容类型
enum ContentType {
  text,
  image,
  audio,
  lessonPlan,
  quiz,
  presentation
}

/// 内容增强类型枚举
enum EnhancementType {
  simplify,
  elaborate,
  visualize,
  translate,
  adapt
}

/// AI服务类，负责与多模态大模型API交互
class AIService {
  final String _baseUrl;
  final http.Client _client;
  
  AIService({
    required String baseUrl,
    http.Client? client,
  }) : _baseUrl = baseUrl,
       _client = client ?? http.Client();
  
  /// 生成教案
  /// 
  /// [topic] 教案主题
  /// [grade] 年级
  /// [subject] 学科
  /// [durationMinutes] 课程时长（分钟）
  /// [model] 使用的AI模型
  Future<LessonPlan> generateLessonPlan({
    required String topic,
    required String grade,
    required String subject,
    required int durationMinutes,
    required AIModel model,
  }) async {
    try {
      // 这里是模拟API调用，实际项目中应替换为真实API调用
      // await Future.delayed(const Duration(seconds: 2));
      
      final response = await _client.post(
        Uri.parse('$_baseUrl/generate/lesson-plan'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'topic': topic,
          'grade': grade,
          'subject': subject,
          'durationMinutes': durationMinutes,
          'model': model.toString(),
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LessonPlan.fromJson(data);
      } else {
        throw Exception('生成教案失败: ${response.statusCode}');
      }
    } catch (e) {
      // 模拟数据，实际项目中应删除
      return _getMockLessonPlan(topic, grade, subject, durationMinutes);
    }
  }
  
  /// 生成多模态内容
  /// 
  /// [prompt] 提示词
  /// [type] 内容类型
  /// [model] 使用的AI模型
  Future<Map<String, dynamic>> generateContent({
    required String prompt,
    required ContentType type,
    required AIModel model,
  }) async {
    // 实际项目中应实现真实API调用
    await Future.delayed(const Duration(seconds: 2));
    
    // 返回模拟数据
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'type': type.toString(),
      'content': '这是基于提示"$prompt"生成的${_getContentTypeName(type)}内容',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
  
  /// 增强内容
  /// 
  /// [content] 原始内容
  /// [enhancementType] 增强类型
  Future<Map<String, dynamic>> enhanceContent({
    required Map<String, dynamic> content,
    required EnhancementType enhancementType,
  }) async {
    // 实际项目中应实现真实API调用
    await Future.delayed(const Duration(seconds: 1));
    
    // 返回模拟数据
    return {
      ...content,
      'content': '${content['content']} (已${_getEnhancementTypeName(enhancementType)})',
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
  
  /// 图像转文本
  Future<String> imageToText(String imagePath) async {
    // 实际项目中应实现真实API调用
    await Future.delayed(const Duration(seconds: 1));
    return '这是从图片中提取的文本内容';
  }
  
  /// 文本转语音
  Future<String> textToSpeech(String text) async {
    // 实际项目中应实现真实API调用
    await Future.delayed(const Duration(seconds: 1));
    return 'audio_file_url.mp3';
  }
  
  // 获取内容类型名称
  String _getContentTypeName(ContentType type) {
    switch (type) {
      case ContentType.text:
        return '文本';
      case ContentType.image:
        return '图片';
      case ContentType.audio:
        return '音频';
      case ContentType.lessonPlan:
        return '教案';
      case ContentType.quiz:
        return '测验';
      case ContentType.presentation:
        return '演示文稿';
    }
  }
  
  // 获取增强类型名称
  String _getEnhancementTypeName(EnhancementType type) {
    switch (type) {
      case EnhancementType.simplify:
        return '简化';
      case EnhancementType.elaborate:
        return '详细阐述';
      case EnhancementType.visualize:
        return '可视化';
      case EnhancementType.translate:
        return '翻译';
      case EnhancementType.adapt:
        return '适应性调整';
    }
  }
  
  // 生成模拟教案数据
  LessonPlan _getMockLessonPlan(String topic, String grade, String subject, int durationMinutes) {
    return LessonPlan.create(
      title: '$topic - $grade $subject 教案',
      subject: subject,
      grade: grade,
      durationMinutes: durationMinutes,
      objectives: '1. 理解$topic的基本概念\n2. 掌握$topic的应用方法\n3. 能够解决相关问题',
      materials: '教科书、多媒体设备、学习单',
      assessment: '课堂提问、小组活动表现、课后作业',
      notes: '注意引导学生主动思考，鼓励参与讨论',
      sections: [
        LessonSection(
          title: '导入',
          content: '通过日常生活例子引入$topic话题，激发学生兴趣',
          durationMinutes: 5,
          activityType: '讲解',
        ),
        LessonSection(
          title: '新知识讲解',
          content: '详细讲解$topic的核心概念和原理',
          durationMinutes: 15,
          activityType: '讲解',
        ),
        LessonSection(
          title: '小组活动',
          content: '学生分组讨论$topic的应用场景',
          durationMinutes: 10,
          activityType: '小组活动',
        ),
        LessonSection(
          title: '练习与巩固',
          content: '完成相关习题，巩固所学知识',
          durationMinutes: 10,
          activityType: '个人练习',
        ),
        LessonSection(
          title: '总结与反思',
          content: '总结课堂内容，布置课后作业',
          durationMinutes: 5,
          activityType: '讲解',
        ),
      ],
    );
  }
} 