import 'package:flutter/material.dart';
import '../models/ai_model.dart';

class AIControlPanel extends StatelessWidget {
  final AIModel selectedModel;
  final double temperature;
  final Function(AIModel) onModelChanged;
  final Function(double) onTemperatureChanged;

  const AIControlPanel({
    super.key,
    required this.selectedModel,
    required this.temperature,
    required this.onModelChanged,
    required this.onTemperatureChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '模型选择',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButton<AIModel>(
            value: selectedModel,
            isExpanded: true,
            items: AIModel.values.map((model) {
              return DropdownMenuItem(
                value: model,
                child: Text(model.displayName),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onModelChanged(value);
              }
            },
          ),
          const SizedBox(height: 24),
          Text(
            '温度参数',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('0.0'),
              Expanded(
                child: Slider(
                  value: temperature,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: temperature.toStringAsFixed(1),
                  onChanged: onTemperatureChanged,
                ),
              ),
              const Text('1.0'),
            ],
          ),
        ],
      ),
    );
  }
} 