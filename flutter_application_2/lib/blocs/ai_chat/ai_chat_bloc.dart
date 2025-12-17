import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

class AIChatBloc extends Bloc<AIChatEvent, AIChatState> {
  AIChatBloc() : super(const AIChatState()) {
    on<TogglePanelVisibility>((event, emit) {
      emit(state.copyWith(isPanelVisible: !state.isPanelVisible));
    });
  }
} 