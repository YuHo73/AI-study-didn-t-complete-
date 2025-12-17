part of 'ai_chat_bloc.dart';

class AIChatState extends Equatable {
  final bool isPanelVisible;

  const AIChatState({this.isPanelVisible = true});

  AIChatState copyWith({
    bool? isPanelVisible,
  }) {
    return AIChatState(
      isPanelVisible: isPanelVisible ?? this.isPanelVisible,
    );
  }

  @override
  List<Object> get props => [isPanelVisible];
} 