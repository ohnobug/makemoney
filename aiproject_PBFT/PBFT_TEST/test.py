import pandas as pd

l1 = [
    {'id': 1, 'other_field': 'a'},
    {'id': 2, 'other_field': 'b'},
    {'id': 3, 'other_field': 'c'},
    {'id': 4, 'other_field': 'd'},
    {'id': 5, 'other_field': 'e'},
    {'id': 6, 'other_field': 'f'},
    {'id': 6, 'other_field': 'g'},
    {'id': 6, 'other_field': 'g'}
]

# 将列表转换为 DataFrame
df = pd.DataFrame(l1)

# 根据 'id' 和 'other_field' 两列去重
unique_df = df.drop_duplicates(subset=['id', 'other_field'])

# 将去重后的 DataFrame 转换回列表形式
unique_l1 = unique_df.to_dict(orient='records')

print(unique_l1)