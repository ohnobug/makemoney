// 列表类型
interface IList {
  tabname: string;
  list: IListItem[];
}

// 列表项类型
interface IListItem {
  key: string;
  icon: any;
  name: JSX.Element;
  price: number;
  float: string;
}
