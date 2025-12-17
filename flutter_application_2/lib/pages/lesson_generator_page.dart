import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ai_model.dart';
import '../models/lesson_plan.dart';
import '../providers/ai_content_provider.dart';
import '../widgets/loading_overlay.dart';

/// 教案生成器页面
class LessonGeneratorPage extends ConsumerStatefulWidget {
  const LessonGeneratorPage({super.key});

  @override
  ConsumerState<LessonGeneratorPage> createState() => _LessonGeneratorPageState();
}

class _LessonGeneratorPageState extends ConsumerState<LessonGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  
  // 表单字段控制器
  final _topicController = TextEditingController();
  final _subjectController = TextEditingController();
  
  // 表单字段值
  String _grade = '小学三年级';
  int _durationMinutes = 40;
  AIModel _selectedModel = AIModel.gpt4;
  
  // 预设年级选项
  final List<String> _gradeOptions = [
    '小学一年级',
    '小学二年级',
    '小学三年级',
    '小学四年级',
    '小学五年级',
    '小学六年级',
    '初中一年级',
    '初中二年级',
    '初中三年级',
    '高中一年级',
    '高中二年级',
    '高中三年级',
  ];
  
  // 预设课时选项
  final List<int> _durationOptions = [20, 30, 40, 45, 60, 90];
  
  @override
  void dispose() {
    _topicController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aiContentState = ref.watch(aiContentProvider);
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('智能教案生成器'),
        actions: [
          if (aiContentState.lessonPlan != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: '重新生成',
              onPressed: () {
                ref.read(aiContentProvider.notifier).clearContent();
              },
            ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: aiContentState.isLoading,
        loadingText: '正在生成教案...',
        child: aiContentState.lessonPlan == null
            ? _buildGeneratorForm(context)
            : _buildLessonPlanView(context, aiContentState.lessonPlan!),
      ),
    );
  }
  
  /// 构建生成器表单
  Widget _buildGeneratorForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 表单标题
          const Text(
            '智能教案生成',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '请填写以下信息，AI将为您生成一份完整的教案',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          
          // 教学主题
          TextFormField(
            controller: _topicController,
            decoration: const InputDecoration(
              labelText: '教学主题 *',
              hintText: '例如：分数的基本概念',
              prefixIcon: Icon(Icons.topic),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入教学主题';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          // 学科
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: '学科 *',
              hintText: '例如：数学',
              prefixIcon: Icon(Icons.book),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入学科';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          // 年级选择
          DropdownButtonFormField<String>(
            value: _grade,
            decoration: const InputDecoration(
              labelText: '年级 *',
              prefixIcon: Icon(Icons.school),
            ),
            items: _gradeOptions.map((grade) {
              return DropdownMenuItem<String>(
                value: grade,
                child: Text(grade),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _grade = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          
          // 课时长度
          DropdownButtonFormField<int>(
            value: _durationMinutes,
            decoration: const InputDecoration(
              labelText: '课时长度 (分钟) *',
              prefixIcon: Icon(Icons.timer),
            ),
            items: _durationOptions.map((duration) {
              return DropdownMenuItem<int>(
                value: duration,
                child: Text('$duration 分钟'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _durationMinutes = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          
          // AI模型选择
          DropdownButtonFormField<AIModel>(
            value: _selectedModel,
            decoration: const InputDecoration(
              labelText: 'AI模型 *',
              prefixIcon: Icon(Icons.smart_toy),
            ),
            items: AIModel.values.map((model) {
              return DropdownMenuItem<AIModel>(
                value: model,
                child: Text(model.displayName),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedModel = value;
                });
              }
            },
          ),
          const SizedBox(height: 32),
          
          // 生成按钮
          ElevatedButton.icon(
            onPressed: _generateLessonPlan,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('生成教案'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
  
  /// 生成教案
  void _generateLessonPlan() {
    if (_formKey.currentState!.validate()) {
      // 收起键盘
      FocusScope.of(context).unfocus();
      
      // 调用AI服务生成教案
      ref.read(aiContentProvider.notifier).generateLessonPlan(
        topic: _topicController.text,
        grade: _grade,
        subject: _subjectController.text,
        durationMinutes: _durationMinutes,
        model: _selectedModel,
      );
    }
  }
  
  /// 构建教案查看界面
  Widget _buildLessonPlanView(BuildContext context, LessonPlan lessonPlan) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // 标签栏
          const TabBar(
            tabs: [
              Tab(text: '教案概览'),
              Tab(text: '教学环节'),
            ],
          ),
          
          // 标签内容
          Expanded(
            child: TabBarView(
              children: [
                // 教案概览标签
                _buildLessonPlanOverview(context, lessonPlan),
                
                // 教学环节标签
                _buildLessonSections(context, lessonPlan),
              ],
            ),
          ),
          
          // 底部操作栏
          _buildActionBar(context, lessonPlan),
        ],
      ),
    );
  }
  
  /// 构建教案概览
  Widget _buildLessonPlanOverview(BuildContext context, LessonPlan lessonPlan) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 教案标题
        Text(
          lessonPlan.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        
        // 教案元信息
        Row(
          children: [
            _buildInfoChip(Icons.school, lessonPlan.grade),
            const SizedBox(width: 8),
            _buildInfoChip(Icons.book, lessonPlan.subject),
            const SizedBox(width: 8),
            _buildInfoChip(Icons.timer, '${lessonPlan.durationMinutes}分钟'),
          ],
        ),
        const SizedBox(height: 24),
        
        // 教学目标
        _buildSection('教学目标', lessonPlan.objectives ?? ''),
        const SizedBox(height: 16),
        
        // 教学材料
        _buildSection('教学材料', lessonPlan.materials ?? ''),
        const SizedBox(height: 16),
        
        // 评估方式
        _buildSection('评估方式', lessonPlan.assessment ?? ''),
        const SizedBox(height: 16),
        
        // 教学笔记
        _buildSection('教学笔记', lessonPlan.notes ?? ''),
      ],
    );
  }
  
  /// 构建信息标签
  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
  
  /// 构建教案章节
  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(content),
      ],
    );
  }
  
  /// 构建教学环节列表
  Widget _buildLessonSections(BuildContext context, LessonPlan lessonPlan) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: lessonPlan.sections.length,
      itemBuilder: (context, index) {
        final section = lessonPlan.sections[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 环节标题和时长
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        section.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text('${section.durationMinutes}分钟'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // 活动类型
                if (section.activityType != null)
                  Chip(
                    label: Text(section.activityType!),
                    visualDensity: VisualDensity.compact,
                  ),
                const SizedBox(height: 8),
                
                // 环节内容
                Text(section.content),
                
                // 资源列表
                if (section.resources != null && section.resources!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        '相关资源:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      ...section.resources!.map((resource) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('• $resource'),
                        );
                      }).toList(),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  /// 构建底部操作栏
  Widget _buildActionBar(BuildContext context, LessonPlan lessonPlan) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.edit_document,
            label: '编辑教案',
            onPressed: () {
              // 跳转到编辑器页面，并传递教案数据
              Navigator.pushNamed(context, '/editor', arguments: lessonPlan);
            },
          ),
          _buildActionButton(
            icon: Icons.save,
            label: '保存教案',
            onPressed: () {
              // 保存教案到本地
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('教案已保存')),
              );
            },
          ),
          _buildActionButton(
            icon: Icons.share,
            label: '分享教案',
            onPressed: () {
              // 分享教案
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('分享功能尚未实现')),
              );
            },
          ),
        ],
      ),
    );
  }
  
  /// 构建操作按钮
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
} 