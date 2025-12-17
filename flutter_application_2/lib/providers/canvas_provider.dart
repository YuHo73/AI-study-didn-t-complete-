import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/canvas_element.dart';

class CanvasState {
  final List<CanvasElement> elements;
  final List<CanvasElement> selectedElements;
  final List<Map<String, dynamic>> undoStack;
  final List<Map<String, dynamic>> redoStack;

  CanvasState({
    required this.elements,
    required this.selectedElements,
    required this.undoStack,
    required this.redoStack,
  });

  CanvasState copyWith({
    List<CanvasElement>? elements,
    List<CanvasElement>? selectedElements,
    List<Map<String, dynamic>>? undoStack,
    List<Map<String, dynamic>>? redoStack,
  }) {
    return CanvasState(
      elements: elements ?? this.elements,
      selectedElements: selectedElements ?? this.selectedElements,
      undoStack: undoStack ?? this.undoStack,
      redoStack: redoStack ?? this.redoStack,
    );
  }
}

class CanvasNotifier extends StateNotifier<CanvasState> {
  CanvasNotifier()
      : super(CanvasState(
          elements: [],
          selectedElements: [],
          undoStack: [],
          redoStack: [],
        ));

  void addElement(CanvasElement element) {
    final newElements = [...state.elements, element];
    state = state.copyWith(
      elements: newElements,
      undoStack: [...state.undoStack, {'action': 'add', 'element': element}],
    );
  }

  void removeElement(String id) {
    final element = state.elements.firstWhere((e) => e.id == id);
    final newElements = state.elements.where((e) => e.id != id).toList();
    state = state.copyWith(
      elements: newElements,
      undoStack: [...state.undoStack, {'action': 'remove', 'element': element}],
    );
  }

  void updateElement(CanvasElement element) {
    final index = state.elements.indexWhere((e) => e.id == element.id);
    if (index != -1) {
      final newElements = [...state.elements];
      newElements[index] = element;
      state = state.copyWith(
        elements: newElements,
        undoStack: [...state.undoStack, {'action': 'update', 'element': element}],
      );
    }
  }

  void selectElement(String id) {
    final element = state.elements.firstWhere((e) => e.id == id);
    state = state.copyWith(
      selectedElements: [element],
    );
  }

  void clearSelection() {
    state = state.copyWith(selectedElements: []);
  }

  void undo() {
    if (state.undoStack.isEmpty) return;
    final lastAction = state.undoStack.last;
    final newUndoStack = state.undoStack.sublist(0, state.undoStack.length - 1);
    state = state.copyWith(
      undoStack: newUndoStack,
      redoStack: [...state.redoStack, lastAction],
    );
    _applyAction(lastAction, isUndo: true);
  }

  void redo() {
    if (state.redoStack.isEmpty) return;
    final lastAction = state.redoStack.last;
    final newRedoStack = state.redoStack.sublist(0, state.redoStack.length - 1);
    state = state.copyWith(
      redoStack: newRedoStack,
      undoStack: [...state.undoStack, lastAction],
    );
    _applyAction(lastAction, isUndo: false);
  }

  void _applyAction(Map<String, dynamic> action, {required bool isUndo}) {
    final element = action['element'] as CanvasElement;
    switch (action['action']) {
      case 'add':
        if (isUndo) {
          removeElement(element.id);
        } else {
          addElement(element);
        }
        break;
      case 'remove':
        if (isUndo) {
          addElement(element);
        } else {
          removeElement(element.id);
        }
        break;
      case 'update':
        if (isUndo) {
          final oldElement = state.elements.firstWhere((e) => e.id == element.id);
          updateElement(oldElement);
        } else {
          updateElement(element);
        }
        break;
    }
  }
}

final canvasProvider = StateNotifierProvider<CanvasNotifier, CanvasState>((ref) {
  return CanvasNotifier();
}); 