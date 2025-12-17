import 'package:flutter/material.dart';
import 'frosted_card.dart';

class ResourcePanel extends StatelessWidget {
  const ResourcePanel({super.key});

  @override
  Widget build(BuildContext context) {
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
                    '资源库',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSubjectCategory(
                  context,
                  '数学',
                  [
                    '代数',
                    '几何',
                    '微积分',
                    '概率统计',
                  ],
                ),
                _buildSubjectCategory(
                  context,
                  '物理',
                  [
                    '力学',
                    '热学',
                    '电磁学',
                    '光学',
                  ],
                ),
                _buildSubjectCategory(
                  context,
                  '化学',
                  [
                    '无机化学',
                    '有机化学',
                    '物理化学',
                    '分析化学',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCategory(
    BuildContext context,
    String title,
    List<String> subcategories,
  ) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(
            subcategory,
            style: const TextStyle(fontSize: 13),
          ),
          onTap: () {
            // TODO: 处理子分类点击事件
          },
        );
      }).toList(),
    );
  }
} 