import { px2vw } from "utils/utils";

const gap = 2;

export default {
  boxSize: px2vw((375 - 4 * gap) / 3),
  boxGap: px2vw(gap),
};
