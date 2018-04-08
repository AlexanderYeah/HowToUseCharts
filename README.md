# HowToUseCharts
由于 iOS-charts 是 swift库 ，charts 集成到OC项目中去  
# 最近在使用频繁的使用表格 索性就记录下
* 简书链接如何使用 https://www.jianshu.com/p/2d7f64011dca  
* CSDN 连接 如何使用 http://blog.csdn.net/u010498323/article/details/52217676?locationNum=3

Charts以一款用于绘制图表的框架，可以绘制柱状图、折线图、K线图、饼状图等. 由于Charts只有Swift版本
所以在这里详细的讲一下在OC项目中怎么导入Charts框架，下面开始一步一步做！  

Demo 中的代码是示例的代码  
Tips：  
1 自定义X轴的标题，创建一个TimeXAxisValueFormatter.h 继承于 NSObject<IChartAxisValueFormatter>     
  ```  
  #import <Foundation/Foundation.h>
#import "ChartTest-Bridging-Header.h"
@interface TimeXAxisValueFormatter : NSObject<IChartAxisValueFormatter>

@end
  ```
  
   然后在m文件中实现对应的方法 自定义标题  
 
```   
 - (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{

	// 此处自定义要返回的X轴标题
	NSString *val = [NSString stringWithFormat:@"第%.0f日",value];
    return val;
	
}
```



![image](https://github.com/AlexanderYeah/HowToUseCharts/blob/master/ChartTest/bar_img.png)




# PieDemo 饼状图的使用 其实就看Demo 中给出的示例就好了
![](https://github.com/AlexanderYeah/HowToUseCharts/blob/master/PieDemo/demo1.png)

# SanDianDemo 散点图的使用
![](https://github.com/AlexanderYeah/HowToUseCharts/blob/master/SanDianDemo/sandian.png)

