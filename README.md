# PasswordView
模仿支付宝的密码输入效果，你可以快速的引入到自己项目并且支持修改UI显示效果。


###效果

![效果](http://7u2lyw.com1.z0.glb.clouddn.com/sampleDemo.gif)

###引入项目

![](http://7u2lyw.com1.z0.glb.clouddn.com/pwview.png)
把文件夹直接拖入项目中即可
###使用
+ 默认使用
```Swift
let v = SetPassWordView(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
//完成输入的回调
v.doneAction = {(text) -> () in
    print(text)
    //to do something
}
self.view.addSubview(v)
```
+ 自定义显示样式
```Swift
let v = SetPassWordView(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
//设置密码数量
v.count = 4
//设置线条颜色
v.lineColor = UIColor.blueColor()
//设置密码点颜色
v.dotColor = UIColor.redColor()
//设置半径大小
v.dotRadius = 20
//完成输入的回调
v.doneAction = {(text) -> () in
    print(text)
    //to do something
}
self.view.addSubview(v)
```
+ xib中使用
在xib中直接修改类名即可
![xib中使用](http://7u2lyw.com1.z0.glb.clouddn.com/xib使用.png)
