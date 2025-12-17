import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'canvas_element.freezed.dart';
part 'canvas_element.g.dart';

@freezed
class CanvasElement with _$CanvasElement {
  const factory CanvasElement({
    required String id,
    required String type,
    required Map<String, dynamic> content,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(false) bool isSelected,
    @Default({}) Map<String, dynamic> style,
  }) = _CanvasElement;

  factory CanvasElement.create({
    required String type,
    required Map<String, dynamic> content,
    required double x,
    required double y,
    double? width,
    double? height,
  }) {
    return CanvasElement(
      id: const Uuid().v4(),
      type: type,
      content: content,
      x: x,
      y: y,
      width: width ?? 200,
      height: height ?? 100,
    );
  }

  factory CanvasElement.fromJson(Map<String, dynamic> json) =>
      _$CanvasElementFromJson(json);
} 