import 'dart:ui';
import 'package:flutter/material.dart';

/// 毛玻璃卡片组件
/// 
/// 特点：
/// 1. 毛玻璃效果（BackdropFilter）
/// 2. 双层阴影效果（主阴影+次要阴影）
/// 3. 可自定义边框和圆角
/// 4. 支持自定义背景色和透明度
/// 
/// 参数修改位置：
/// 1. 构造函数参数：修改默认值
/// 2. build方法中：修改实际效果
class FrostedCard extends StatelessWidget {
  /// 卡片内容
  final Widget child;
  
  /// 外边距
  final EdgeInsetsGeometry? margin;
  
  /// 内边距
  final EdgeInsetsGeometry? padding;
  
  /// 圆角大小
  /// 建议值：8-24
  /// 修改位置：构造函数参数
  final double borderRadius;
  
  /// 毛玻璃模糊程度
  /// 建议值：8-24
  /// 值越大越模糊
  /// 修改位置：构造函数参数
  final double blurSigma;
  
  /// 背景色
  /// 建议使用半透明白色：Colors.white.withOpacity(0.35)
  /// 或主题色半透明：Theme.of(context).colorScheme.primary.withOpacity(0.1)
  /// 修改位置：构造函数参数
  final Color backgroundColor;
  
  /// 自定义阴影
  /// 如果为null则使用默认的双层阴影效果
  /// 修改位置：构造函数参数
  final List<BoxShadow>? boxShadow;
  
  /// 阴影高度
  /// 影响阴影的大小和偏移
  /// 建议值：2-8
  /// 值越大阴影越明显
  /// 修改位置：构造函数参数
  final double elevation;

  const FrostedCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    // 修改位置1：圆角大小
    this.borderRadius = 16,
    // 修改位置2：毛玻璃模糊程度
    this.blurSigma = 16,
    // 修改位置3：背景色 - 淡蓝色半透明
    this.backgroundColor = const Color(0x1A3B82F6), // 使用主题色亮蓝，透明度0.1
    this.boxShadow,
    // 修改位置4：阴影高度
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    // 获取主题色
    final theme = Theme.of(context);
    // 修改位置5：主阴影颜色
    final primaryColor = theme.colorScheme.primary;    // 主色：亮蓝
    // 修改位置6：次要阴影颜色
    final accentColor = theme.colorScheme.secondary;   // 强调色：亮青

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ?? [
          // 修改位置7：主阴影参数
          // 透明度：0.15 - 调整阴影深浅
          // blurRadius：elevation * 4 - 调整阴影扩散范围
          // offset：elevation - 调整阴影偏移距离
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            blurRadius: elevation * 4,
            offset: Offset(0, elevation),
          ),
          // 修改位置8：次要阴影参数
          // 透明度：0.1 - 调整阴影深浅
          // blurRadius：elevation * 2 - 调整阴影扩散范围
          // offset：elevation / 2 - 调整阴影偏移距离
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation / 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          // 修改位置9：毛玻璃效果
          // sigmaX/Y：blurSigma - 调整模糊程度
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding ?? const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                // 修改位置10：边框颜色和透明度
                // 建议值：0.1-0.3
                color: Colors.white.withOpacity(0.2),
                // 修改位置11：边框宽度
                // 建议值：0.5-2
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
} 