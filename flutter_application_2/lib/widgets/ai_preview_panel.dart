import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'hover_card.dart';

class AIPreviewPanel extends StatefulWidget {
  final List<Map<String, dynamic>> generatedContent;
  final bool isLoading;

  const AIPreviewPanel({
    super.key,
    required this.generatedContent,
    this.isLoading = false,
  });

  @override
  State<AIPreviewPanel> createState() => _AIPreviewPanelState();
}

class _AIPreviewPanelState extends State<AIPreviewPanel> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.generatedContent.length,
            itemBuilder: (context, index) {
              final content = widget.generatedContent[index];
              return _buildContentCard(content);
            },
          ),
        ),
        if (widget.isLoading)
          Center(
            child: Lottie.asset(
              'assets/animations/loading.json',
              width: 100,
              height: 100,
            ),
          ),
      ],
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    switch (content['type']) {
      case 'text':
        return HoverCard(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          hoverScale: 1.03,
          child: Text(content['content'] as String),
        );
      case 'image':
        return HoverCard(
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.zero,
          hoverScale: 1.03,
          child: Image.network(
            content['url'] as String,
            fit: BoxFit.contain,
          ),
        );
      case 'code':
        return HoverCard(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          hoverScale: 1.03,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Text(
                content['code'] as String,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
} 