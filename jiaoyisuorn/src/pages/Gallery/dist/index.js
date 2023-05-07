"use strict";
exports.__esModule = true;
var react_1 = require("react");
var react_native_1 = require("react-native");
var bus_1 = require("../../bus");
var LJNScrollView_1 = require("../../components/LJNScrollView");
var LJNTabbar_1 = require("../../components/LJNTabbar");
var hooks_1 = require("../../hooks");
var styles_1 = require("./styles");
var LJNGalleryStyle1_1 = require("./Components/LJNGalleryStyle1");
var LJNGalleryStyle2_1 = require("./Components/LJNGalleryStyle2");
var LJNGalleryStyle3_1 = require("./Components/LJNGalleryStyle3");
var LJNGalleryStyle4_1 = require("./Components/LJNGalleryStyle4");
var imagesArr = [
    require("../../assets/gallery/1.jpg"),
    require("../../assets/gallery/2.jpg"),
    require("../../assets/gallery/3.jpg"),
    require("../../assets/gallery/4.jpg"),
    require("../../assets/gallery/5.jpg"),
    require("../../assets/gallery/6.jpg"),
    require("../../assets/gallery/7.jpg"),
    require("../../assets/gallery/8.jpg"),
    require("../../assets/gallery/9.jpg"),
    require("../../assets/gallery/10.jpg"),
    require("../../assets/gallery/11.jpg"),
    require("../../assets/gallery/12.jpg"),
    require("../../assets/gallery/13.jpg"),
    require("../../assets/gallery/14.jpg"),
    require("../../assets/gallery/15.jpg"),
    require("../../assets/gallery/16.jpg"),
    require("../../assets/gallery/17.jpg"),
    require("../../assets/gallery/18.jpg"),
    require("../../assets/gallery/19.jpg"),
    require("../../assets/gallery/20.jpg"),
    require("../../assets/gallery/21.jpg"),
    require("../../assets/gallery/22.jpg"),
    require("../../assets/gallery/23.jpg"),
    require("../../assets/gallery/24.jpg"),
    require("../../assets/gallery/25.jpg"),
    require("../../assets/gallery/26.jpg"),
    require("../../assets/gallery/27.jpg"),
    require("../../assets/gallery/28.jpg"),
    require("../../assets/gallery/29.jpg"),
    require("../../assets/gallery/30.jpg"),
    require("../../assets/gallery/31.jpg"),
    require("../../assets/gallery/32.jpg"),
    require("../../assets/gallery/33.jpg"),
    require("../../assets/gallery/34.jpg"),
    require("../../assets/gallery/35.jpg"),
    require("../../assets/gallery/36.jpg"),
    require("../../assets/gallery/37.jpg"),
    require("../../assets/gallery/38.jpg"),
    require("../../assets/gallery/39.jpg"),
    require("../../assets/gallery/40.jpg"),
    require("../../assets/gallery/41.jpg"),
    require("../../assets/gallery/42.jpg"),
    require("../../assets/gallery/43.jpg"),
    require("../../assets/gallery/44.jpg"),
    require("../../assets/gallery/45.jpg"),
    require("../../assets/gallery/46.jpg"),
    require("../../assets/gallery/47.jpg"),
    require("../../assets/gallery/48.jpg"),
    require("../../assets/gallery/49.jpg"),
    require("../../assets/gallery/50.jpg"),
    require("../../assets/gallery/51.jpg"),
    require("../../assets/gallery/52.jpg"),
    require("../../assets/gallery/53.jpg"),
    require("../../assets/gallery/54.jpg"),
    require("../../assets/gallery/55.jpg"),
    require("../../assets/gallery/56.jpg"),
    require("../../assets/gallery/57.jpg"),
    require("../../assets/gallery/58.jpg"),
    require("../../assets/gallery/59.jpg"),
    require("../../assets/gallery/60.jpg"),
    require("../../assets/gallery/61.jpg"),
    require("../../assets/gallery/62.jpg"),
    require("../../assets/gallery/63.jpg"),
    require("../../assets/gallery/64.jpg"),
    require("../../assets/gallery/65.jpg"),
    require("../../assets/gallery/66.jpg"),
    require("../../assets/gallery/67.jpg"),
    require("../../assets/gallery/68.jpg"),
    require("../../assets/gallery/69.jpg"),
    require("../../assets/gallery/70.jpg"),
    require("../../assets/gallery/71.jpg"),
    require("../../assets/gallery/72.jpg"),
    require("../../assets/gallery/73.jpg"),
    require("../../assets/gallery/74.jpg"),
    require("../../assets/gallery/75.jpg"),
    require("../../assets/gallery/76.jpg"),
    require("../../assets/gallery/77.jpg"),
    require("../../assets/gallery/78.jpg"),
    require("../../assets/gallery/79.jpg"),
    require("../../assets/gallery/80.jpg"),
    require("../../assets/gallery/81.jpg"),
    require("../../assets/gallery/82.jpg"),
    require("../../assets/gallery/83.jpg"),
    require("../../assets/gallery/84.jpg"),
    require("../../assets/gallery/85.jpg"),
    require("../../assets/gallery/86.jpg"),
    require("../../assets/gallery/87.jpg"),
    require("../../assets/gallery/88.jpg"),
    require("../../assets/gallery/89.jpg"),
    require("../../assets/gallery/90.jpg"),
    require("../../assets/gallery/91.jpg"),
    require("../../assets/gallery/92.jpg"),
    require("../../assets/gallery/93.jpg"),
    require("../../assets/gallery/94.jpg"),
    require("../../assets/gallery/95.jpg"),
    require("../../assets/gallery/96.jpg"),
    require("../../assets/gallery/97.jpg"),
    require("../../assets/gallery/98.jpg"),
    require("../../assets/gallery/99.jpg"),
    require("../../assets/gallery/100.jpg"),
    require("../../assets/gallery/101.jpg"),
    require("../../assets/gallery/102.jpg"),
    require("../../assets/gallery/103.jpg"),
    require("../../assets/gallery/104.jpg"),
    require("../../assets/gallery/105.jpg"),
    require("../../assets/gallery/106.jpg"),
    require("../../assets/gallery/107.jpg"),
    require("../../assets/gallery/108.jpg"),
    require("../../assets/gallery/109.jpg"),
    require("../../assets/gallery/110.jpg"),
    require("../../assets/gallery/111.jpg"),
    require("../../assets/gallery/112.jpg"),
    require("../../assets/gallery/113.jpg"),
    require("../../assets/gallery/114.jpg"),
    require("../../assets/gallery/115.jpg"),
    require("../../assets/gallery/116.jpg"),
    require("../../assets/gallery/117.jpg"),
    require("../../assets/gallery/118.jpg"),
    require("../../assets/gallery/119.jpg"),
    require("../../assets/gallery/120.jpg"),
    require("../../assets/gallery/121.jpg"),
    require("../../assets/gallery/122.jpg"),
    require("../../assets/gallery/123.jpg"),
    require("../../assets/gallery/124.jpg"),
    require("../../assets/gallery/125.jpg"),
    require("../../assets/gallery/126.jpg"),
    require("../../assets/gallery/127.jpg"),
    require("../../assets/gallery/128.jpg"),
    require("../../assets/gallery/129.jpg"),
    require("../../assets/gallery/130.jpg"),
    require("../../assets/gallery/131.jpg"),
    require("../../assets/gallery/132.jpg"),
];
var index = function (props) {
    var bigScrollView = react_1.useRef(null);
    react_1.useEffect(function () {
        bus_1["default"].emit("getBigScrollView", bigScrollView.current);
    }, [bigScrollView]);
    var styles = hooks_1.useStyles(styles_1.setTheme);
    var makeData = function (n) {
        return new Array(n).fill("").map(function () {
            var exampleImageUri;
            if (react_native_1.Platform.OS === "web") {
                exampleImageUri = imagesArr[~~(Math.random() * 132)];
            }
            else {
                exampleImageUri = react_native_1.Image.resolveAssetSource(imagesArr[~~(Math.random() * 132)]).uri;
            }
            return {
                url: "",
                image: exampleImageUri
            };
        });
    };
    return (react_1["default"].createElement(react_native_1.View, { style: styles.container },
        react_1["default"].createElement(LJNScrollView_1["default"], { style: styles.ljn_main, horizontal: false, ref: bigScrollView, children: react_1["default"].createElement(react_1["default"].Fragment, null, new Array(20).fill(0).map(function (item, index) {
                var r = 1 + ~~(Math.random() * 4);
                if (r === 1) {
                    return react_1["default"].createElement(LJNGalleryStyle1_1["default"], { gallery: makeData(6), key: index });
                }
                else if (r === 2) {
                    return react_1["default"].createElement(LJNGalleryStyle2_1["default"], { gallery: makeData(5), key: index });
                }
                else if (r === 3) {
                    return react_1["default"].createElement(LJNGalleryStyle3_1["default"], { gallery: makeData(5), key: index });
                }
                else if (r === 4) {
                    return react_1["default"].createElement(LJNGalleryStyle4_1["default"], { gallery: makeData(5), key: index });
                }
            })) }),
        react_1["default"].createElement(react_native_1.View, { style: styles.ljn_footer },
            react_1["default"].createElement(LJNTabbar_1["default"], null))));
};
exports["default"] = index;
