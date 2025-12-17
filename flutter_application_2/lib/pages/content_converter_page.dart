import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/ai_model.dart';
import '../services/ai_service.dart';
import '../providers/ai_content_provider.dart';
import '../widgets/loading_overlay.dart';

/// 转换类型枚举
enum ConversionType {
  textToSpeech,
  speechToText,
  imageToText,
  textToImage,
}

/// 多模态内容转换器页面
class ContentConverterPage extends ConsumerStatefulWidget {
  const ContentConverterPage({super.key});

  @override
  ConsumerState<ContentConverterPage> createState() => _ContentConverterPageState();
}

class _ContentConverterPageState extends ConsumerState<ContentConverterPage> {
  // 当前选择的转换类型
  ConversionType _conversionType = ConversionType.textToSpeech;
  
  // 文本输入控制器
  final TextEditingController _textController = TextEditingController();
  
  // 选择的文件路径
  String? _selectedFilePath;
  
  // 文件名
  String? _selectedFileName;
  
  // 转换结果
  String? _conversionResult;
  
  // 是否正在加载
  bool _isLoading = false;
  
  // 选择的AI模型
  AIModel _selectedModel = AIModel.gpt4;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('多模态内容转换'),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        loadingText: _getLoadingText(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 转换类型选择
              _buildConversionTypeSelector(),
              const SizedBox(height: 24),
              
              // 输入区域
              _buildInputSection(),
              const SizedBox(height: 24),
              
              // 转换按钮
              _buildConvertButton(),
              const SizedBox(height: 24),
              
              // 结果区域
              if (_conversionResult != null)
                _buildResultSection(),
            ],
          ),
        ),
      ),
    );
  }
  
  /// 构建转换类型选择器
  Widget _buildConversionTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '选择转换类型',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildConversionTypeChip(
              ConversionType.textToSpeech,
              '文本转语音',
              Icons.record_voice_over,
            ),
            _buildConversionTypeChip(
              ConversionType.speechToText,
              '语音转文本',
              Icons.mic,
            ),
            _buildConversionTypeChip(
              ConversionType.imageToText,
              '图像转文本',
              Icons.image,
            ),
            _buildConversionTypeChip(
              ConversionType.textToImage,
              '文本转图像',
              Icons.brush,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // AI模型选择
        DropdownButtonFormField<AIModel>(
          value: _selectedModel,
          decoration: const InputDecoration(
            labelText: 'AI模型',
            prefixIcon: Icon(Icons.smart_toy),
          ),
          items: AIModel.values.map((model) {
            return DropdownMenuItem<AIModel>(
              value: model,
              child: Text(model.displayName),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedModel = value;
              });
            }
          },
        ),
      ],
    );
  }
  
  /// 构建转换类型选择芯片
  Widget _buildConversionTypeChip(
    ConversionType type,
    String label,
    IconData icon,
  ) {
    final bool isSelected = _conversionType == type;
    final theme = Theme.of(context);
    
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _conversionType = type;
            _selectedFilePath = null;
            _selectedFileName = null;
            _conversionResult = null;
          });
        }
      },
    );
  }
  
  /// 构建输入区域
  Widget _buildInputSection() {
    switch (_conversionType) {
      case ConversionType.textToSpeech:
      case ConversionType.textToImage:
        return _buildTextInputSection();
      case ConversionType.speechToText:
      case ConversionType.imageToText:
        return _buildFileInputSection();
    }
  }
  
  /// 构建文本输入区域
  Widget _buildTextInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _conversionType == ConversionType.textToSpeech
              ? '输入要转换为语音的文本'
              : '输入要转换为图像的描述',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: _conversionType == ConversionType.textToSpeech
                ? '请输入中文文本...'
                : '请输入详细的图像描述...',
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
  
  /// 构建文件输入区域
  Widget _buildFileInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _conversionType == ConversionType.speechToText
              ? '选择要转换为文本的音频文件'
              : '选择要转换为文本的图像文件',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _selectedFileName ?? '未选择文件',
                  style: TextStyle(
                    color: _selectedFileName != null
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.upload_file),
              label: const Text('选择文件'),
            ),
          ],
        ),
        if (_selectedFilePath != null && _conversionType == ConversionType.imageToText)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Image.file(
              File(_selectedFilePath!),
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
      ],
    );
  }
  
  /// 构建转换按钮
  Widget _buildConvertButton() {
    bool isEnabled = false;
    
    switch (_conversionType) {
      case ConversionType.textToSpeech:
      case ConversionType.textToImage:
        isEnabled = _textController.text.isNotEmpty;
        break;
      case ConversionType.speechToText:
      case ConversionType.imageToText:
        isEnabled = _selectedFilePath != null;
        break;
    }
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled ? _convertContent : null,
        icon: const Icon(Icons.transform),
        label: Text('开始${_getConversionTypeText()}'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
  
  /// 构建结果区域
  Widget _buildResultSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '转换结果',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildResultContent(),
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建结果内容
  Widget _buildResultContent() {
    switch (_conversionType) {
      case ConversionType.textToSpeech:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('生成的音频文件:'),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    // 播放音频
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('播放功能尚未实现')),
                    );
                  },
                ),
                Expanded(
                  child: Text(_conversionResult ?? ''),
                ),
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // 下载音频
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('下载功能尚未实现')),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      case ConversionType.textToImage:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('生成的图像:'),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Container(
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text('保存图像'),
                  onPressed: () {
                    // 保存图像
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('保存功能尚未实现')),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      case ConversionType.speechToText:
      case ConversionType.imageToText:
        return SingleChildScrollView(
          child: Text(_conversionResult ?? ''),
        );
    }
  }
  
  /// 选择文件
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: _conversionType == ConversionType.imageToText
          ? FileType.image
          : FileType.audio,
    );
    
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFilePath = result.files.single.path!;
        _selectedFileName = result.files.single.name;
        _conversionResult = null;
      });
    }
  }
  
  /// 转换内容
  Future<void> _convertContent() async {
    setState(() {
      _isLoading = true;
    });
    
    final aiService = ref.read(aiServiceProvider);
    
    try {
      switch (_conversionType) {
        case ConversionType.textToSpeech:
          final result = await aiService.textToSpeech(_textController.text);
          setState(() {
            _conversionResult = result;
          });
          break;
        case ConversionType.speechToText:
          // 模拟语音转文本
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            _conversionResult = '这是从音频中识别出的文本内容。实际应用中应调用真实的AI服务。';
          });
          break;
        case ConversionType.imageToText:
          if (_selectedFilePath != null) {
            final result = await aiService.imageToText(_selectedFilePath!);
            setState(() {
              _conversionResult = result;
            });
          }
          break;
        case ConversionType.textToImage:
          // 模拟文本转图像
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            _conversionResult = '图像已生成';
          });
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('转换失败: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  /// 获取转换类型文本
  String _getConversionTypeText() {
    switch (_conversionType) {
      case ConversionType.textToSpeech:
        return '文本转语音';
      case ConversionType.speechToText:
        return '语音转文本';
      case ConversionType.imageToText:
        return '图像转文本';
      case ConversionType.textToImage:
        return '文本转图像';
    }
  }
  
  /// 获取加载文本
  String _getLoadingText() {
    switch (_conversionType) {
      case ConversionType.textToSpeech:
        return '正在将文本转换为语音...';
      case ConversionType.speechToText:
        return '正在将语音转换为文本...';
      case ConversionType.imageToText:
        return '正在分析图像内容...';
      case ConversionType.textToImage:
        return '正在生成图像...';
    }
  }
} 