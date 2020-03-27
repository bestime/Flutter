- `ListView` 被`Container`等容器包裹报错
  - 使用扩展小部件`Expanded`包裹`ListView`



### 打包
	- android
		- flutter build apk --release 
### 按钮
> MaterialButton 解决存在最小尺寸根据达到自适应

```
MaterialButton(
	materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
)
```

### 真机闪退
```
// 可能是打包混淆造成的，可尝试关闭混淆
// 修改`{{appPath}}/android/app/build.gradle` 文件
buildTypes {
	release {
		minifyEnabled false
		shrinkResources false
	}
}
```

#### 无缝滚动
![avatar](./images/scroll.gif)
```
// 导入类
import './BestimeDart/InfiniteScroll.dart';

// 使用
InfiniteScroll(
  maskLeft: '#444',
  maskRight: '#444',
  child: Text(
    '这是一个无限滚动公告，如果内容不超过父容器，将不会进行滚动......'
  ),
  size: 40,
  speed: 30,
  period: 1000
)
```