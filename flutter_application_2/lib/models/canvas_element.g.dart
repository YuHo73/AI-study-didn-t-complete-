// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasElementImpl _$$CanvasElementImplFromJson(Map<String, dynamic> json) =>
    _$CanvasElementImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      content: json['content'] as Map<String, dynamic>,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      isSelected: json['isSelected'] as bool? ?? false,
      style: json['style'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CanvasElementImplToJson(_$CanvasElementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'isSelected': instance.isSelected,
      'style': instance.style,
    };
