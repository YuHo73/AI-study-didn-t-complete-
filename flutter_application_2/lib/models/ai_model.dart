enum AIModel {
  gpt4,
  claude3,
  vllm;

  String get displayName {
    switch (this) {
      case AIModel.gpt4:
        return 'GPT-4';
      case AIModel.claude3:
        return 'Claude 3';
      case AIModel.vllm:
        return 'VLLM';
    }
  }
} 