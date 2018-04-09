//
//  ViewController.m
//  RadarDemo
//
//  Created by Alexander on 2018/4/8.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "RadarDemo-Bridging-Header.h"

@interface ViewController ()<ChartViewDelegate,IChartAxisValueFormatter>


/**
 雷达图
 */
@property (nonatomic,strong)RadarChartView *radarChartView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.radarChartView = [[RadarChartView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
	self.radarChartView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.radarChartView];
	
	self.radarChartView.delegate = self;
	self.radarChartView.noDataText = @"暂无数据";
	self.radarChartView.rotationEnabled = NO;//是否允许转动
	self.radarChartView.highlightPerTapEnabled = NO;//是否能被选中
	
	
	// 雷达图的线条有两部分构成, 一部分是由中心向外辐射的主干线, 一部分是环绕中心的边线. 代码如下:
	self.radarChartView.webLineWidth = 0.5;//主干线线宽
	self.radarChartView.webColor = [UIColor redColor];//主干线线宽
	self.radarChartView.innerWebLineWidth = 0.375;//边线宽度
	self.radarChartView.innerWebColor = [UIColor greenColor];//边线颜色
	self.radarChartView.webAlpha = 1;//透明度
	
	
	//设置X轴label样式
	
	ChartXAxis *xAxis = self.radarChartView.xAxis;
	xAxis.labelFont = [UIFont systemFontOfSize:15];//字体
	xAxis.labelTextColor = [UIColor blueColor];
	// 自定义X轴的标题
	xAxis.valueFormatter = self;
	
	
	
	
	// 设置Y轴label样式
	ChartYAxis *yAxis = self.radarChartView.yAxis;
	yAxis.axisMinimum = 0.0;//最小值
	yAxis.axisMaximum = 150.0;//最大值
	yAxis.drawLabelsEnabled = NO;//是否显示 label
	yAxis.labelCount = 5;// label 个数
	yAxis.labelFont = [UIFont systemFontOfSize:9];// label 字体
	yAxis.labelTextColor = [UIColor lightGrayColor];// label 颜色
	
	double mult = 100;
    int count = 5;//维度的个数
	
	//每个维度的名称或描述
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d 月", i+1]];
    }
	
	//每个维度的数据
	NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
	 for (int i = 0; i < count; i++) {
	 	 double randomVal = arc4random_uniform(mult) + mult / 2;//产生 50~150 的随机数
		 RadarChartDataEntry *entry = [[RadarChartDataEntry alloc]initWithValue:randomVal];
		 
		 [yVals1 addObject:entry];
	 
	}
	// dataSet
	RadarChartDataSet *set1 = [[RadarChartDataSet alloc]initWithValues:yVals1 label:@"dataSet"];
	set1.lineWidth = 0.5;//数据折线线宽
	[set1 setColor:[UIColor cyanColor]];
	set1.drawFilledEnabled = YES;//是否填充颜色
	set1.fillColor = [UIColor cyanColor];//填充颜色
	set1.fillAlpha = 0.25;//填充透明度
	set1.drawValuesEnabled = NO;//是否绘制显示数据
	set1.valueFont = [UIFont systemFontOfSize:9];//字体
	set1.valueTextColor = [UIColor grayColor];//颜色

	
	NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
	 for (int i = 0; i < count; i++) {
	 	 double randomVal = arc4random_uniform(mult) + mult / 2;//产生 50~150 的随机数
		 RadarChartDataEntry *entry = [[RadarChartDataEntry alloc]initWithValue:randomVal];
		 [yVals2 addObject:entry];
	 
	}
	
	RadarChartDataSet *set2 = [[RadarChartDataSet alloc]initWithValues:yVals2 label:@"dataSet2"];
	set2.lineWidth = 0.5;//数据折线线宽
	[set2 setColor:[UIColor redColor]];
	set2.drawFilledEnabled = YES;//是否填充颜色
	set2.fillColor = [UIColor redColor];//填充颜色
	set2.fillAlpha = 0.25;//填充透明度
	set2.drawValuesEnabled = NO;//是否绘制显示数据
	set2.valueFont = [UIFont systemFontOfSize:9];//字体
	set2.valueTextColor = [UIColor grayColor];//颜色
	
	// set1
	RadarChartData *data = [[RadarChartData alloc]initWithDataSets:@[set1,set2]];
	self.radarChartView.data = data;
	
	
}


//  x 轴的标题
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
	
	int idx = (int)value;
	NSLog(@"%d",idx);
	
	switch (idx) {
  case 0:
    return @"打野";
    break;
  case 1:
    return @"上单";
    break;
  case 2:
    return @"中路";
    break;
  case 3:
    return @"下路";
    break;
  case 4:
    return @"辅助";
    break;
  default:
    break;
}
	
	return @"nil";

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
