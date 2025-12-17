@echo off
chcp 65001
echo 正在启动多模态教学资源系统后端服务...

REM 检查是否存在虚拟环境
if not exist venv (
    echo 创建虚拟环境...
    python -m venv venv
)

REM 激活虚拟环境
call venv\Scripts\activate

REM 安装依赖
echo 安装依赖...
pip install -r requirements.txt --user

REM 设置环境变量
echo 设置环境变量...
set PORT=8000
set MINIO_ENDPOINT=http://10.0.113.17:9000
set MINIO_ACCESS_KEY=YuHo
set MINIO_SECRET_KEY=7happyyyh
set MINIO_BUCKET_NAME=teaching-resources
set AI_SERVICE_URL=https://api.siliconflow.cn/v1/chat/completions
set AI_SERVICE_KEY=sk-msdofyzvjuxqnyhegwivaxqxhyrabbyelqgqqjbqimuxqawp

REM 复制 AI.env 文件到 .env (如果不存在)
if not exist .env (
    copy AI.env .env
    echo 已创建 .env 文件，请编辑该文件配置您的 API 密钥
)

REM 启动应用
echo 启动应用...
:: 使用虚拟环境中的Python启动应用，如果没有虚拟环境则使用系统Python
python main.py

REM 如果应用结束运行
echo 应用已关闭
pause 