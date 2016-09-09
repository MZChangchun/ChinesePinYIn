# ChinesePinYIn
今天遇到了这样一个需求，需要对请求获取的数组按数组中字典的某个键值排序并分组，这些键值是中文的，并且还不能丢失原数组元素中的键值对
想了一天，决定自己动手写一个类，今天终于写好了我的这个类；
得出一个体会：苹果`Foundation`框架是非常强大的。我了解的太少了。

优点：这个方法返回的数据中，你传入的数据没有任何丢失。

你只需要在你的代码中需要的地方，添加 `#import "MZPinYIn.h"`
在你需要排序的数组中这样写 NSArray * arrayResult = [MZPinYIn chinesePinYinGroupUp:array];//array是一个NSArray
你就会获取到一个已经排好顺序的数组。此时，已经把你的数组分组排列好了。

如果你想获取这个数组，这也很简单：
for (int i = 0; i < arrayResult.count ; i++) {
        MyJSON * jsonc = (MyJSON *)arrayResult[i];
        NSLog(@"--------%@--------", jsonc.initial);
        for (NSDictionary *dic in jsonc.array) {
            NSLog(@"\t%@",dic);
        }
    }
这就是你的数据


使用过程中遇到任何问题请联系我，如有bug，欢迎修改
