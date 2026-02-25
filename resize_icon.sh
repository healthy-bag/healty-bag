#!/bin/bash

# 입력 이미지 경로 및 출력 이미지 경로 설정
INPUT_IMAGE="/Users/t2025-m0205/Desktop/proj/healty-bag/assets/images/App Icon.png"
OUTPUT_IMAGE="/Users/t2025-m0205/Desktop/proj/healty-bag/assets/images/App Icon_512.png"

# macOS에 내장된 sips(Scriptable Image Processing System) 명령어를 사용하여 이미지 크기를 512x512로 변경
echo "이미지 리사이징을 시작합니다..."
sips -z 512 512 "$INPUT_IMAGE" --out "$OUTPUT_IMAGE"

echo "완료되었습니다! 결과물 경로: $OUTPUT_IMAGE"
