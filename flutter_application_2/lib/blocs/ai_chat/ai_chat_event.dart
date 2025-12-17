part of 'ai_chat_bloc.dart';

abstract class AIChatEvent extends Equatable {
  const AIChatEvent();

  @override
  List<Object> get props => [];
}

class TogglePanelVisibility extends AIChatEvent {} 