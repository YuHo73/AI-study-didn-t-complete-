import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/canvas_provider.dart';
import 'frosted_card.dart';

class PropertyPanel extends ConsumerWidget {
  const PropertyPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(canvasProvider);
    final selectedElement = canvasState.selectedElements.isNotEmpty
        ? canvasState.selectedElements.first
        : null;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return FrostedCard(
      borderRadius: 0,
      blurSigma: 16,
      backgroundColor: Colors.white.withOpacity(0.35),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                if (isMobile)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: '收起',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '属性设置',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (selectedElement != null) ...[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFontSettings(context, selectedElement),
                  const SizedBox(height: 16),
                  _buildAnimationSettings(context, selectedElement),
                  const SizedBox(height: 16),
                  _buildAISuggestions(context, selectedElement),
                ],
              ),
            ),
          ] else
            const Expanded(
              child: Center(
                child: Text('请选择一个元素'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFontSettings(BuildContext context, dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '字体设置',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<double>(
          value: element.style['fontSize']?.toDouble() ?? 16.0,
          decoration: const InputDecoration(
            labelText: '字号',
            border: OutlineInputBorder(),
          ),
          items: [12.0, 14.0, 16.0, 18.0, 20.0, 24.0, 28.0, 32.0]
              .map((size) => DropdownMenuItem(
                    value: size,
                    child: Text(size.toString()),
                  ))
              .toList(),
          onChanged: (value) {
            // TODO: 更新字体大小
          },
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<FontWeight>(
          value: element.style['fontWeight'] ?? FontWeight.normal,
          decoration: const InputDecoration(
            labelText: '字重',
            border: OutlineInputBorder(),
          ),
          items: [
            FontWeight.normal,
            FontWeight.bold,
            FontWeight.w500,
          ].map((weight) => DropdownMenuItem(
                value: weight,
                child: Text(weight == FontWeight.normal
                    ? '常规'
                    : weight == FontWeight.bold
                        ? '粗体'
                        : '中等'),
              )).toList(),
          onChanged: (value) {
            // TODO: 更新字重
          },
        ),
      ],
    );
  }

  Widget _buildAnimationSettings(BuildContext context, dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '动画效果',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: element.style['animation'] ?? 'none',
          decoration: const InputDecoration(
            labelText: '动画类型',
            border: OutlineInputBorder(),
          ),
          items: [
            'none',
            'fade',
            'slide',
            'scale',
          ].map((type) => DropdownMenuItem(
                value: type,
                child: Text(type == 'none'
                    ? '无'
                    : type == 'fade'
                        ? '淡入淡出'
                        : type == 'slide'
                            ? '滑动'
                            : '缩放'),
              )).toList(),
          onChanged: (value) {
            // TODO: 更新动画类型
          },
        ),
      ],
    );
  }

  Widget _buildAISuggestions(BuildContext context, dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI优化建议',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.auto_awesome),
          label: const Text('获取优化建议'),
          onPressed: () {
            // TODO: 实现AI优化建议功能
          },
        ),
      ],
    );
  }
} 