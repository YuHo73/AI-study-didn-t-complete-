import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';
import '../providers/canvas_provider.dart';
import '../models/canvas_element.dart';

class CanvasArea extends ConsumerWidget {
  final Function(String) onElementSelected;

  const CanvasArea({
    super.key,
    required this.onElementSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(canvasProvider);
    
    return Container(
      color: Theme.of(context).colorScheme.background,
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: ReorderableWrap(
        spacing: 8.0,
        runSpacing: 8.0,
        padding: const EdgeInsets.all(8),
        onReorder: (oldIndex, newIndex) {
          // TODO: 实现元素重排序
        },
        children: canvasState.elements.map((element) {
          return _buildElement(context, element);
        }).toList(),
      ),
    );
  }

  Widget _buildElement(BuildContext context, CanvasElement element) {
    return MouseRegion(
      onEnter: (_) {
        // TODO: 实现hover效果
      },
      onExit: (_) {
        // TODO: 实现hover效果
      },
      child: GestureDetector(
        onTap: () => onElementSelected(element.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: element.isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: element.isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor,
            ),
          ),
          child: _buildElementContent(element),
        ),
      ),
    );
  }

  Widget _buildElementContent(CanvasElement element) {
    switch (element.type) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            element.content['text'] as String,
            style: TextStyle(
              fontSize: element.style['fontSize']?.toDouble() ?? 16.0,
              fontWeight: element.style['fontWeight'] ?? FontWeight.normal,
            ),
          ),
        );
      case 'image':
        return Image.network(
          element.content['url'] as String,
          fit: BoxFit.cover,
        );
      default:
        return const SizedBox.shrink();
    }
  }
} 