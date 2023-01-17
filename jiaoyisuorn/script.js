const fs = require("fs");
const path = require("path");

const __dirname__ = path.resolve("");
const file = path.resolve(__dirname__, "./web-build/index.html");
let content = fs.readFileSync(file);
let contentUTF8 = content.toString("utf-8");

let output = contentUTF8.replace(
  /<title>(.*?)<\/title>/g,
  "<title>H币交易所 v0.0.1</title>"
);

fs.writeFileSync(file, output);
