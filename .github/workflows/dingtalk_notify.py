#!/usr/bin/env python3
import requests
import json
import os
import time
import hashlib
import hmac
import base64

def send_dingtalk_notification(commit_msg, author):
    # 获取环境变量
    webhook = os.getenv('DINGTALK_WEBHOOK')
    secret = os.getenv('DINGTALK_SECRET')
    
    if not webhook or not secret:
        print("错误: DINGTALK_WEBHOOK 或 DINGTALK_SECRET 环境变量未设置")
        return False

    # 生成钉钉签名
    timestamp = str(int(time.time() * 1000))
    string_to_sign = f'{timestamp}\n{secret}'
    hmac_code = hmac.new(
        secret.encode(),
        string_to_sign.encode(),
        digestmod=hashlib.sha256
    ).digest()
    sign = base64.b64encode(hmac_code).decode()
    
    # 构造消息体
    payload = {
        'msgtype': 'markdown',
        'markdown': {
            'title': 'GitHub Commit',
            'text': f'**提交者**: {author}\n\n**内容**: {commit_msg}'
        }
    }
    
    # 发送请求
    webhook = f'{webhook}&timestamp={timestamp}&sign={sign}'
    response = requests.post(webhook, json=payload)
    
    print('钉钉响应状态码:', response.status_code)
    print('钉钉响应内容:', response.text)
    
    return response.status_code == 200

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("用法: python dingtalk_notify.py <commit_msg> <author>")
        sys.exit(1)
    
    commit_msg = sys.argv[1]
    author = sys.argv[2]
    
    success = send_dingtalk_notification(commit_msg, author)
    sys.exit(0 if success else 1) 