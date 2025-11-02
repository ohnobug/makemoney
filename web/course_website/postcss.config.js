export default {
  plugins: {
    '@minko-fe/postcss-pxtoviewport': {
      // 设计稿宽度为 375px
      viewportWidth: 375,
      // 视口单位，使用 vw
      unitToConvert: 'px',
      viewportUnit: 'vw',
      // 保留3位小数
      unitPrecision: 3,
      // 需要转换的属性列表，* 表示所有属性
      propList: ['*'],
      // 不转换的选择器
      selectorBlackList: ['.ignore', '.hairlines'],
      // 最小的转换数值
      minPixelValue: 1,
      // 是否在媒体查询中转换 px
      mediaQuery: false,
      // 排除不需要转换的文件
      exclude: /node_modules/i
    }
  }
}