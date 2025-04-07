#!/usr/bin/env python3

import json
import logging
import sys
import argparse
from argparse import Namespace


def main(args: Namespace):
    logger = logging.getLogger()
    try:
        # 读取并解析输入文件
        with open(args.input, "r", encoding="utf-8") as input_file:
            with open(args.output, mode="w", encoding="utf-8") as output_file:
                # 生成单行 JSON 字符串
                if args.action == "oneline":
                    data = json.load(input_file)
                    json_str = json.dumps(
                        data, ensure_ascii=False, indent=None, separators=(",", ":")
                    )
                    output_file.write(json_str)
                # 生成多行 JSON 字符串
                if args.action == "expand":
                    data = json.load(input_file)
                    json_str = json.dumps(data, ensure_ascii=False, indent="\t")
                    output_file.write(json_str)
                # 转译
                elif args.action == "encode":
                    content = input_file.read().strip()
                    output_file.write(json.dumps(content))
                # 还原
                elif args.action == "decode":
                    content = input_file.read().strip()
                    data = json.loads(json.loads(content))
                    json.dump(obj=data, fp=output_file, ensure_ascii=False)

    except FileNotFoundError:
        logger.error(f"错误：文件 {args.input} 未找到")
    except json.JSONDecodeError:
        logger.error(f"错误：{args.input} 不是有效的JSON格式")
    except PermissionError:
        logger.error(f"错误：没有权限写入输出文件 {args.output}")
    except Exception as e:
        logger.error(f"发生未知错误: {str(e)}")


if __name__ == "__main__":
    # 配置命令行参数解析
    parser = argparse.ArgumentParser(description="JSON 处理工具")
    parser.add_argument(
        "-i",
        "--input",
        help="输入文件路径（不指定则读取 /dev/stdin）",
        required=False,
        default="/dev/stdin",
    )
    parser.add_argument(
        "-o",
        "--output",
        help="输出文件路径（不指定则输出到 /dev/stdout）",
        required=False,
        default="/dev/stdout",
    )
    parser.add_argument(
        "-a",
        "--action",
        choices=["oneline", "expand", "encode", "decode"],
        help="处理动作：oneline 用于将 JSON 压缩成单行，expand 用于将单行 JSON 展开成多行，encode 用于转译 JSON 字符串，decode 用于还原转译后的 JSON 字符串",
        required=True,
    )

    args = parser.parse_args()
    main(args)
