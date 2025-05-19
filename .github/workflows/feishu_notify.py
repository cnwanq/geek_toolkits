#!/usr/bin/env python3
import requests
import json
import os
import sys

def send_feishu_notification(commit_msg):
    # 检查环境变量
    webhook_url = os.getenv("FEISHU_WEBHOOK")
    
    if not webhook_url:
        print("错误: FEISHU_WEBHOOK 环境变量未设置")
        return False

    # 构造最简单的消息体
    payload = {
        "msg_type": "text",
        "content": {
            "text": commit_msg
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
    if len(sys.argv) != 2:
        print("用法: python feishu_notify.py <commit_msg>")
        sys.exit(1)
    
    commit_msg = sys.argv[1]
    success = send_feishu_notification(commit_msg)
    sys.exit(0 if success else 1) 