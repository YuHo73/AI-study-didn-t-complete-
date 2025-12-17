import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/frosted_card.dart';
import '../widgets/hover_card.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final int crossAxisCount = isMobile ? 2 : 3;
    final double childAspectRatio = isMobile ? 0.65 : 1.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('资源库'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 实现搜索功能
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 实现筛选功能
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '搜索课件...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: 实现搜索逻辑
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: '全部',
                  items: ['全部', '数学', '物理', '化学', '生物']
                      .map((subject) => DropdownMenuItem(
                            value: subject,
                            child: Text(subject),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // TODO: 实现分类筛选
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 10, // 示例数据
              itemBuilder: (context, index) {
                return _buildCoursewareCard(context, isMobile);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现新建课件功能
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCoursewareCard(BuildContext context, bool isMobile) {
    return HoverCard(
      borderRadius: 16,
      blurSigma: 24,
      backgroundColor: Colors.white.withOpacity(0.28),
      elevation: 8,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      hoverScale: 1.05,
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: () {
          // TODO: 实现课件预览
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: isMobile ? 1.2 : 1.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.slideshow,
                    size: 48,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '示例课件 ${DateTime.now().millisecondsSinceEpoch % 100}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '最后编辑：${DateTime.now().toString().substring(0, 10)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 