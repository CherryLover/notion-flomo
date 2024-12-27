FROM python:3.9-slim

WORKDIR /app

# 安装 cron
RUN apt-get update && apt-get install -y cron

# 复制项目文件
COPY . .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制 crontab 文件
COPY crontab /etc/cron.d/app-cron
RUN chmod 0644 /etc/cron.d/app-cron
RUN crontab /etc/cron.d/app-cron

# 创建日志文件
RUN touch /var/log/cron.log

# 启动命令
CMD cron && tail -f /var/log/cron.log 