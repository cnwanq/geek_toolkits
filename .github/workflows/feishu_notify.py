#!/usr/bin/env python3
import requests
import json
import os
import sys
import datetime

def send_feishu_notification(commit_msg, repo_name, branch_name, commit_url, author, commit_time):
    # 检查环境变量
    webhook_url = os.getenv("FEISHU_WEBHOOK")
    
    if not webhook_url:
        print("错误: FEISHU_WEBHOOK 环境变量未设置")
        return False

    # 构造详细的消息体
    message = f"""📢 代码更新通知

📦 仓库：{repo_name}
🌿 分支：{branch_name}
👤 提交者：{author}
⏰ 提交时间：{commit_time}
🔗 提交链接：{commit_url}

📝 提交信息：
{commit_msg}"""

    payload = {
        "msg_type": "text",
        "content": {
            "text": message
        }
    }

    try:
        response = requests.post(webhook_url, json=payload)
        print(f"飞书响应状态码: {response.status_code}")
        print(f"飞书响应内容: {response.text}")
        
        response.raise_for_status()
        return True
        
    except requests.exceptions.RequestException as e:
        print(f"发送请求时出错: {str(e)}")
        return False

if __name__ == '__main__':
    if len(sys.argv) != 6:
        print("用法: python feishu_notify.py <commit_msg> <repo_name> <branch_name> <commit_url> <author>")
        sys.exit(1)
    
    commit_msg = sys.argv[1]
    repo_name = sys.argv[2]
    branch_name = sys.argv[3]
    commit_url = sys.argv[4]
    author = sys.argv[5]
    
    # 获取当前时间
    commit_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    success = send_feishu_notification(commit_msg, repo_name, branch_name, commit_url, author, commit_time)
    sys.exit(0 if success else 1) 