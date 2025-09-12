# To run this code you need to install the following dependencies:
# pip install google-genai

import base64
import mimetypes
import os
from google import genai
from google.genai import types


def save_binary_file(file_name, data):
    f = open(file_name, "wb")
    f.write(data)
    f.close()
    print(f"File saved to to: {file_name}")


def generate():
    client = genai.Client(
        api_key=os.environ.get("GEMINI_API_KEY", "AIzaSyBSHBYEk2PLOOpIBaiZH4dV0RxnjrO9okU"),
    )

    model = "gemini-2.5-flash-image-preview"

    # 3. 构建包含文本和参考图片的 contents 列表
    contents = [
        types.Content(
            role="user",
            parts=[
                # 这是您的文本指令
                types.Part.from_text(text="""根据这张图片，生成一张风格类似的新图片"""), # <-- 在这里修改您的指令
                # 这是您的参考图片
                types.Part.from_uri(file_uri="./1.jpg")
            ],
        ),
    ]

    generate_content_config = types.GenerateContentConfig(
        response_modalities=[
            "IMAGE",
            "TEXT",
        ],
    )

    file_index = 0
    for chunk in client.models.generate_content_stream(
        model=model,
        contents=contents,
        config=generate_content_config,
    ):
        if (
            chunk.candidates is None
            or chunk.candidates[0].content is None
            or chunk.candidates[0].content.parts is None
        ):
            continue
        if chunk.candidates[0].content.parts[0].inline_data and chunk.candidates[0].content.parts[0].inline_data.data:
            file_name = f"generated_image_{file_index}" # <-- 修改了默认文件名
            file_index += 1
            inline_data = chunk.candidates[0].content.parts[0].inline_data
            data_buffer = inline_data.data
            file_extension = mimetypes.guess_extension(inline_data.mime_type)
            save_binary_file(f"{file_name}{file_extension}", data_buffer)
        else:
            print(chunk.text)

if __name__ == "__main__":
    generate()