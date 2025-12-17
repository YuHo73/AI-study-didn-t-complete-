import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/canvas_provider.dart';

class Toolbar extends ConsumerWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(canvasProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: screenWidth, minHeight: 56),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildToolbarChildren(context, ref, canvasState, isMobile),
                ),
              ),
            )
          : Row(
              children: _buildToolbarChildren(context, ref, canvasState, isMobile),
            ),
    );
  }

  List<Widget> _buildToolbarChildren(BuildContext context, WidgetRef ref, dynamic canvasState, bool isMobile) {
    return [
      IconButton(
        icon: const Icon(Icons.undo),
        onPressed: canvasState.undoStack.isEmpty
            ? null
            : () => ref.read(canvasProvider.notifier).undo(),
        tooltip: '撤销',
      ),
      IconButton(
        icon: const Icon(Icons.redo),
        onPressed: canvasState.redoStack.isEmpty
            ? null
            : () => ref.read(canvasProvider.notifier).redo(),
        tooltip: '重做',
      ),
      if (!isMobile) ...[
        const SizedBox(width: 16),
        const VerticalDivider(),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.loose,
          child: TextButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('导出PDF'),
            onPressed: () {
              // TODO: 实现PDF导出功能
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          fit: FlexFit.loose,
          child: TextButton.icon(
            icon: const Icon(Icons.slideshow),
            label: const Text('导出PPTX'),
            onPressed: () {
              // TODO: 实现PPTX导出功能
            },
          ),
        ),
      ],
      if (isMobile)
        PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert),
          tooltip: '更多操作',
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('导出PDF'),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: ListTile(
                leading: const Icon(Icons.slideshow),
                title: const Text('导出PPTX'),
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {
              // TODO: 实现PDF导出功能
            } else if (value == 2) {
              // TODO: 实现PPTX导出功能
            }
          },
        ),
    ];
  }
} 