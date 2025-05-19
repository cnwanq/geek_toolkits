#!/usr/bin/env python3
import requests
import json
import os
import time
import hashlib
import hmac
import base64
import urllib.parse
import sys

def escape_markdown(text):
    # 转义 Markdown 特殊字符
    special_chars = ["*", "_", "#", ">", "|", "`", "~", "[", "]", "(", ")", "!"]
    for char in special_chars:
        text = text.replace(char, "\\" + char)
    return text

def send_feishu_notification(commit_msg):
    # 检查环境变量
    webhook_url = os.getenv("FEISHU_WEBHOOK")
    secret = os.getenv("FEISHU_SIGN")
    
    if not webhook_url or not secret:
        print("错误: FEISHU_WEBHOOK 或 FEISHU_SIGN 环境变量未设置")
        return False

    # 转义提交信息
    escaped_msg = escape_markdown(commit_msg)
    
    # 生成飞书签名
    timestamp = str(int(time.time()))
    string_to_sign = f"{timestamp}\n{secret}"
    hmac_code = hmac.new(
        secret.encode("utf-8"),
        string_to_sign.encode("utf-8"),
        digestmod=hashlib.sha256
    ).digest()
    sign = base64.b64encode(hmac_code).decode("utf-8")

    # 构造消息体
    payload = {
        "msg_type": "text",
        "content": {
            "text": escaped_msg
        }
    }

    try:
        # 将签名和时间戳添加到 URL
        url_parts = list(urllib.parse.urlparse(webhook_url))
        query = dict(urllib.parse.parse_qsl(url_parts[4]))
        query.update({
            "timestamp": timestamp,
            "sign": sign
        })
        url_parts[4] = urllib.parse.urlencode(query)
        final_url = urllib.parse.urlunparse(url_parts)
        
        print(f"\n请求信息:")
        print(f"时间戳: {timestamp}")
        print(f"签名字符串: {repr(string_to_sign)}")
        print(f"签名结果: {sign}")
        print(f"完整 URL: {final_url}")
        
        response = requests.post(final_url, json=payload)
        print(f"\n响应信息:")
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