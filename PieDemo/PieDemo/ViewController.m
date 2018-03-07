//
//  ViewController.m
//  PieDemo
//
//  Created by Alexander on 2018/3/6.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "PieDemo-Bridging-Header.h"
@interface ViewController ()<ChartViewDelegate>

@property (nonatomic,strong)PieChartView *chartView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createUI];
}

- (void)createUI
{
	// 设置代理
	self.chartView.delegate = self;
	// 0 初始化
	self.chartView = [[PieChartView alloc]init];
	self.chartView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.chartView];
	self.chartView.frame = CGRectMake(40, 200, 300, 300);
	
	// 1 基本样式
	// 饼状图距上下左右的边距
	[self.chartView setExtraOffsetsWithLeft:30 top:0 right:0 bottom:0];
	// 是否根据所提供的数据转化为百分比
	self.chartView.usePercentValuesEnabled = YES;
	// 拖拽图之后是否有惯性效果
	self.chartView.dragDecelerationEnabled = YES;
	// 是否显示区块文本
	
	// 设置为空心样式
	self.chartView.drawHoleEnabled = NO;
	
	// 如果是空心样式的
	// 空心半径占比
	//self.chartView.holeRadiusPercent = 0.5;
	// 空心的颜色
	//self.chartView.holeColor = [UIColor whiteColor];
	// 半透明空心半径占比
	//self.chartView.transparentCircleRadiusPercent = 0.52;
	// 颜色
	// self.chartView.transparentCircleColor = [UIColor whiteColor];
	
	
	
	
	
	// 设置legend 就是数据的指示标志
	self.chartView.legend.maxSizePercent = 1;
	// 文本间隔
	self.chartView.legend.formToTextSpace = 5;
	// 字体大小
	self.chartView.legend.font = [UIFont systemFontOfSize:10.0f];
	// 字体颜色
	self.chartView.legend.textColor = [UIColor grayColor];
	// 图例方形 线条
	self.chartView.legend.form = ChartLegendFormCircle;
	// 大小
	self.chartView.legend.formSize = 12;
	
	
	// 提供数据供表格显示
	NSMutableArray * values = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0 ; i < 5 ; i ++) {
		// 每一个的显示数据
		PieChartDataEntry *entry = [[PieChartDataEntry alloc]initWithValue:arc4random_uniform(43) label:@"城乡结合部门面试部分"];
		[values addObject:entry];
	}
	
	
	// 数据集合
	PieChartDataSet *dataSet = [[PieChartDataSet alloc]initWithValues:values label:@"饼状图示例"];
	// 相邻区块之间的距离
	dataSet.sliceSpace = 2.0f;
	// 选中的时候放大的半径
	dataSet.selectionShift = 5.0f;
	// 一旦位置不一致 就进行一折线的形式显示
	// 名称的位置
	dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
	// 数据的位置
	dataSet.yValuePosition = PieChartValuePositionInsideSlice;
	// 数据与区块之间用于折线形式设置
	// 折线中第一段的占比 与  第二段的占比
	dataSet.valueLinePart1Length = 0.2;
	dataSet.valueLinePart2Length = 0.8;
	// 折线的粗细
	dataSet.valueLineWidth = 1;
	// 折线的颜色
	dataSet.valueLineColor = [UIColor brownColor];
	
	
	
	
	// 给dataset 添加颜色 设置对应的颜色
	NSMutableArray *colors = [[NSMutableArray alloc]initWithCapacity:0];
	
	
	[colors addObjectsFromArray:ChartColorTemplates.vordiplom];
	[colors addObjectsFromArray:ChartColorTemplates.colorful];
	[colors addObjectsFromArray:ChartColorTemplates.pastel];
	[colors addObjectsFromArray:ChartColorTemplates.liberty];
	[colors addObjectsFromArray:ChartColorTemplates.joyful];
	
	dataSet.colors = colors;
	
	// 实例化PieChartData
	PieChartData *data = [[PieChartData alloc]initWithDataSet:dataSet];
	
	
	// 数据的显示格式
	NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc]init];
	// 百分比的形式
	pFormatter.numberStyle = NSNumberFormatterPercentStyle;
	// 小数的位数
	pFormatter.maximumFractionDigits = 1;
	//
	pFormatter.multiplier = @1.0f;
	//
	pFormatter.percentSymbol = @" %";

	[data setValueFormatter:[[ChartDefaultValueFormatter alloc]initWithFormatter:pFormatter]];
	[data setValueTextColor:[UIColor redColor]];

	
	_chartView.data = data;
	[_chartView highlightValue:nil];
	
	
	
	
	

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
