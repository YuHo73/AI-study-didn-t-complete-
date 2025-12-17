import 'package:flutter/material.dart';
import '../models/ai_model.dart';
import '../widgets/ai_input_panel.dart';
import '../widgets/ai_preview_panel.dart';
import '../widgets/ai_control_panel.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/ai_chat/ai_chat_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

// 悬停效果按钮
class _HoverFeatureButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  
  const _HoverFeatureButton({
    required this.icon,
    required this.label,
    this.onTap,
  });
  
  @override
  State<_HoverFeatureButton> createState() => _HoverFeatureButtonState();
}

class _HoverFeatureButtonState extends State<_HoverFeatureButton> {
  bool isHovered = false;
  bool isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedScale(
          scale: isPressed ? 0.95 : (isHovered ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPressed 
                ? colorScheme.primary.withOpacity(0.1) 
                : (isHovered ? colorScheme.surface.withOpacity(0.9) : colorScheme.surface),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.primary.withOpacity(isHovered || isPressed ? 0.5 : 0.3)),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(isPressed ? 0.1 : (isHovered ? 0.2 : 0.1)),
                  blurRadius: isPressed ? 2 : (isHovered ? 6 : 4),
                  spreadRadius: isPressed ? 0 : (isHovered ? 1 : 0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: colorScheme.primary, size: 18),
                const SizedBox(width: 4),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: isHovered || isPressed ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  // 卡片位置动画
  late Animation<Offset> _cardOffsetAnimation;
  // 卡片透明度动画
  late Animation<double> _cardOpacityAnimation;
  // 按钮位置控制
  double _buttonBottomPosition = 8.0;
  double _buttonTopPosition = 0.0;
  
  // 面板是否展开
  bool _isPanelExpanded = true;
  
  // 保存面板状态的键
  static const String _panelStateKey = 'isPanelExpanded';
  
  // 状态是否已加载完成
  bool _isStateLoaded = false;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // 初始化卡片位置动画
    _cardOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 5), // 向下移动屏幕高度的5倍
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    
    // 初始化卡片透明度动画
    _cardOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    
    // 从SharedPreferences加载面板状态
    _loadPanelState();
  }
  
  // 加载面板状态
  Future<void> _loadPanelState() async {
    final prefs = await SharedPreferences.getInstance();
    final isPanelExpanded = prefs.getBool(_panelStateKey) ?? true;
    
    if (mounted) {
      setState(() {
        _isPanelExpanded = isPanelExpanded;
        if (!_isPanelExpanded) {
          _controller.value = 1.0; // 立即设置动画到最终状态，避免动画过渡
          _buttonBottomPosition = 0.0;
          _buttonTopPosition = 80.0;
        }
        _isStateLoaded = true; // 标记状态已加载
      });
    }
  }
  
  // 保存面板状态
  Future<void> _savePanelState(bool isPanelExpanded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_panelStateKey, isPanelExpanded);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 切换面板状态
  void _togglePanel() {
    setState(() {
      _isPanelExpanded = !_isPanelExpanded;
      if (_isPanelExpanded) {
        _controller.reverse(); // 展开面板
        _buttonBottomPosition = 8.0; // 按钮回到原位置
        _buttonTopPosition = 0.0;
      } else {
        _controller.forward(); // 收起面板
        _buttonBottomPosition = 0.0; // 按钮移到底部
        _buttonTopPosition = 80.0;
      }
      
      // 保存面板状态
      _savePanelState(_isPanelExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;
    
    // 获取安全区域
    final EdgeInsets padding = MediaQuery.of(context).padding;
    
    // 获取主题颜色
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color primaryColor = colorScheme.primary;
    final Color backgroundColor = colorScheme.background;
    final Color surfaceColor = colorScheme.surface;
    final Color textColor = colorScheme.onSurface;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('AI助手'),
        actions: [
          // 多模态功能菜单
          PopupMenuButton<String>(
            icon: const Icon(Icons.apps),
            tooltip: '多模态功能',
            onSelected: (value) {
              _navigateToFeature(context, value);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'lesson-generator',
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_stories,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 8),
                    const Text('智能教案生成'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'content-converter',
                child: Row(
                  children: [
                    Icon(
                      Icons.swap_horiz,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(width: 8),
                    const Text('多模态内容转换'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'grading',
                child: Row(
                  children: [
                    Icon(
                      Icons.grading,
                      color: Colors.orange.shade600,
                    ),
                    const SizedBox(width: 8),
                    const Text('智能批改'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'slideshow',
                child: Row(
                  children: [
                    Icon(
                      Icons.slideshow,
                      color: Colors.purple.shade600,
                    ),
                    const SizedBox(width: 8),
                    const Text('课件智能生成'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.volume_off),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // 聊天内容区域
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      // 这里可以添加聊天消息
                      _buildAIMessage(context, "您好，我是您的AI助手，有什么可以帮您的吗？"),
                      _buildUserMessage(context, "帮我写一篇关于人工智能的文章"),
                      _buildAIMessage(context, "好的，我将为您撰写一篇关于人工智能的文章。请稍等..."),
                    ],
                  ),
                ),
                
                // 底部输入区域和收起按钮
                if (_isStateLoaded) // 只有在状态加载完成后才显示卡片
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SlideTransition(
                      position: _cardOffsetAnimation,
                      child: FadeTransition(
                        opacity: _cardOpacityAnimation,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // 功能按钮区
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 4),
                                        _buildFeatureButton(context, Icons.image, "AI生图"),
                                        const SizedBox(width: 8),
                                        _buildFeatureButton(context, Icons.camera_alt, "拍题答疑"),
                                        const SizedBox(width: 8),
                                        _buildFeatureButton(context, Icons.edit, "帮我写作"),
                                        const SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // 输入框区域
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(24),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  style: TextStyle(color: textColor),
                                                  decoration: InputDecoration(
                                                    hintText: '发消息或按住说话',
                                                    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                                                    border: InputBorder.none,
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                                                  onPressed: () {},
                                                  constraints: const BoxConstraints(
                                                    minWidth: 32,
                                                    minHeight: 32,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // 底部导航栏的占位符，确保有足够空间
                SizedBox(height: padding.bottom),
              ],
            ),
            
            // 收起按钮，放在Stack中以便独立控制位置
            if (_isStateLoaded) // 只有在状态加载完成后才显示按钮
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                left: 16,
                bottom: _isPanelExpanded ? 130 : 16, // 调整为紧挨着卡片
                child: FloatingActionButton.small(
                  onPressed: _togglePanel,
                  backgroundColor: primaryColor,
                  elevation: 4,
                  child: Icon(
                    _isPanelExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, IconData icon, String label) {
    return _HoverFeatureButton(
      icon: icon, 
      label: label,
      onTap: () {
        // 处理按钮点击
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('点击了 $label')),
        );
      },
    );
  }

  Widget _buildUserMessage(BuildContext context, String message) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(Icons.person, color: colorScheme.onPrimaryContainer, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildAIMessage(BuildContext context, String message) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.secondaryContainer,
            child: Icon(Icons.smart_toy, color: colorScheme.onSecondaryContainer, size: 18),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 导航到指定功能页面
  void _navigateToFeature(BuildContext context, String path) {
    if (path == 'grading' || path == 'slideshow') {
      _showFeatureNotImplemented(context);
    } else {
      context.push('/ai/$path');
    }
  }
  
  // 显示功能未实现提示
  void _showFeatureNotImplemented(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('该功能正在开发中，敬请期待！')),
    );
  }
} 