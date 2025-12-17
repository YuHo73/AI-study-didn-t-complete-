import 'package:flutter/material.dart';
import 'frosted_card.dart';

/// 悬停放大卡片组件
/// 
/// 特点：
/// 1. 继承FrostedCard的所有特性（毛玻璃效果、阴影等）
/// 2. 鼠标悬停时有放大效果
/// 3. 支持自定义放大比例和动画时长
class HoverCard extends StatefulWidget {
  /// 卡片内容
  final Widget child;
  
  /// 外边距
  final EdgeInsetsGeometry? margin;
  
  /// 内边距
  final EdgeInsetsGeometry? padding;
  
  /// 圆角大小
  final double borderRadius;
  
  /// 毛玻璃模糊程度
  final double blurSigma;
  
  /// 背景色
  final Color backgroundColor;
  
  /// 自定义阴影
  final List<BoxShadow>? boxShadow;
  
  /// 阴影高度
  final double elevation;
  
  /// 悬停时的放大比例
  /// 建议值：1.02-1.1
  /// 值越大放大效果越明显
  final double hoverScale;
  
  /// 动画时长
  final Duration duration;

  const HoverCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius = 16,
    this.blurSigma = 16,
    this.backgroundColor = const Color(0x1A3B82F6),
    this.boxShadow,
    this.elevation = 4,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.hoverScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: FrostedCard(
          margin: widget.margin,
          padding: widget.padding,
          borderRadius: widget.borderRadius,
          blurSigma: widget.blurSigma,
          backgroundColor: widget.backgroundColor,
          boxShadow: widget.boxShadow,
          elevation: widget.elevation,
          child: widget.child,
        ),
      ),
    );
  }
} 