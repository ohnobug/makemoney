const fs = require('fs');
const path = require('path');

// 指定要操作的文件夹路径
const folderPath = './src/components/LJNIcon/iconfont/';

// 读取文件夹中的所有文件
fs.readdir(folderPath, (err, files) => {
  if (err) {
    console.error('Error reading directory:', err);
    return;
  }

  // 遍历文件
  files.forEach(file => {
    const filePath = path.join(folderPath, file);

    // 检查是否为文件
    fs.stat(filePath, (err, stats) => {
      if (err) {
        console.error('Error getting file stats:', err);
        return;
      }

      if (stats.isFile()) {
        fs.readFile(filePath, 'utf8', (err, data) => {
          if (err) {
            console.error('Error reading file:', err);
            return;
          }

          console.log("正在替换：", filePath)

          // 进行替换
          const newData = data.replace(/.*?\.defaultProps = {[\s\S]*?};/g, '');

          // 写入修改后的内容
          fs.writeFile(filePath, newData, 'utf8', err => {
            if (err) {
              console.error('Error writing file:', err);
              return;
            }
          });
        });
      }
    });
  });
});