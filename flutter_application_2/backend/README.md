# 多模态教学资源系统 - 后端

本项目是基于多模态大模型的数字化教学资源制作系统的后端部分，使用Python和FastAPI开发。

## 功能特性

- 资源管理：上传、下载、删除教学资源文件
- AI教案生成：基于主题、学科、年级智能生成教案
- 多模态内容转换：文本转图像、图像识别、语音转文本等
- 文本AI对话：智能对话功能
- 图像生成与识别：基于AI的图像生成和分析

## 技术栈

- **Web框架**: FastAPI
- **文件存储**: MinIO
- **AI服务**: 多模态大模型集成

## 项目结构

```
backend/
│
├── app/                      # 应用源码
│   ├── api/                  # API路由
│   ├── core/                 # 核心配置
│   ├── models/               # 数据模型
│   └── services/             # 业务逻辑服务
│
├── main.py                   # 应用入口
├── requirements.txt          # 依赖列表
└── start.bat                 # Windows启动脚本
```

## 快速开始

### 环境要求

- Python 3.8+
- pip 包管理器

### 步骤1: 配置环境

1. 克隆仓库：

```bash
git clone [repository-url]
cd backend
```

2. 安装依赖：

```bash
pip install -r requirements.txt
```

### 步骤2: 配置AI服务

本系统支持多种AI模型服务，需要在 `.env` 文件中配置对应的API接口和密钥：

1. 复制环境变量模板：

```bash
copy AI.env .env
```

2. 编辑 `.env` 文件，填写各种AI模型的API配置：

```
# 文本对话 API
TEXT_CHAT_API_URL=https://your-api-provider.com/v1/chat
TEXT_CHAT_API_KEY=your_api_key

# 教案生成 API
LESSON_PLAN_API_URL=https://your-api-provider.com/v1/generate
LESSON_PLAN_API_KEY=your_api_key

# 多模态内容转换 API
CONTENT_CONVERT_API_URL=https://your-api-provider.com/v1/convert
CONTENT_CONVERT_API_KEY=your_api_key

# 图像识别 API
IMAGE_RECOGNITION_API_URL=https://your-api-provider.com/v1/vision
IMAGE_RECOGNITION_API_KEY=your_api_key

# 图像生成 API
IMAGE_GENERATION_API_URL=https://your-api-provider.com/v1/images
IMAGE_GENERATION_API_KEY=your_api_key
```

### 步骤3: 启动服务

#### Windows用户

直接运行启动脚本：

```bash
start.bat
```

#### Linux/Mac用户

```bash
python main.py
```

服务将在 http://localhost:8000 启动，可通过 http://localhost:8000/docs 访问API文档。

## API 接口

### 资源管理

- `POST /api/v1/resource/upload` - 上传资源文件
- `GET /api/v1/resource/{resource_id}` - 下载资源文件
- `DELETE /api/v1/resource/{resource_id}` - 删除资源文件
- `GET /api/v1/resource/list` - 获取资源列表

### AI服务

- `POST /api/v1/ai/generate/lesson-plan` - 生成教案
- `POST /api/v1/ai/convert` - 内容格式转换
- `POST /api/v1/ai/chat` - AI文本对话
- `POST /api/v1/ai/recognize-image` - 图像识别
- `POST /api/v1/ai/generate-image` - 生成图像
- `GET /api/v1/ai/tasks/{task_id}` - 获取AI任务状态

## 对象存储配置

系统使用MinIO作为对象存储服务，默认配置：

```
MINIO_ENDPOINT=localhost:9000
MINIO_ACCESS_KEY=minioadmin
MINIO_SECRET_KEY=minioadmin
```

可根据实际情况在环境变量中修改。

## 开发说明

当前版本使用内存存储模拟数据库操作，实际项目应集成数据库。同时，AI服务接口目前返回模拟数据，实际项目应连接真实的多模态大模型服务。 