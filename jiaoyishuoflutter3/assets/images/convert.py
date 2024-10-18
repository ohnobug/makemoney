import cv2  
import os  

# os.chdir("./assets/images")
os.chdir("./")


def convert(source_folder, target_folder):
    # 确保目标文件夹存在  
    if not os.path.exists(target_folder):  
        os.makedirs(target_folder)  
    
    # 遍历源文件夹中的所有文件  
    for filename in os.listdir(source_folder):  
        if filename.endswith('.png') or filename.endswith('.jpg'):  # 确保只处理PNG文件  
            img_path = os.path.join(source_folder, filename)  

            print(img_path)
            img = cv2.imread(img_path)  # 读取图片  
            
            # 构造目标文件路径  
            webp_filename = os.path.splitext(filename)[0] + '.webp'  
            webp_path = os.path.join(target_folder, webp_filename)  
            
            # 将图片保存为WebP格式  
            cv2.imwrite(webp_path, img, [int(cv2.IMWRITE_WEBP_QUALITY), 80])  # 95是质量参数，可以根据需要调整  
    
    print("所有PNG图片已成功转换为WebP格式并保存到目标文件夹。")

# 源文件夹和目标文件夹路径  
source_folder = './icon'
target_folder = './icon_webp'
convert(source_folder, target_folder)


source_folder = './avatar'
target_folder = './avatar_webp'
convert(source_folder, target_folder)