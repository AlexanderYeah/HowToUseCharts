//
//  ViewController.m
//  EmptyPieDemo
//
//  Created by Alexander on 2018/4/8.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "EmptyPieDemo-Bridging-Header.h"
@interface ViewController ()<ChartViewDelegate>


@property (nonatomic,strong)PieChartView *pieChartView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createUI];
	
}

- (void)createUI
{
	CGFloat w = [UIScreen mainScreen].bounds.size.width;
	self.pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 200, w, 300)];
	self.pieChartView.delegate = self;
	[self.view addSubview:self.pieChartView];


	[self.pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
	self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
	self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
	self.pieChartView.drawCenterTextEnabled = YES;//是否显示区块文本

	self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
	self.pieChartView.holeRadiusPercent = 0.6;//空心半径占比
	self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
	self.pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
	self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
	
	// 饼状图是空心样式的时候 设置对应的文本
	if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
       self.pieChartView.centerText = @"老子是个老子是个饼状图老子是个饼状图饼状图";//中间文字
		
        //富文本
//        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
//        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
//                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
//                            range:NSMakeRange(0, centerText.length)];
//        self.pieChartView.centerAttributedText = centerText;
}
	
	// 饼状图的描述
	self.pieChartView.chartDescription.text = @"";
	self.pieChartView.chartDescription.font = [UIFont systemFontOfSize:10];
	self.pieChartView.chartDescription.textColor = [UIColor grayColor];
	
	// 设置饼状图的样式
	self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
	self.pieChartView.legend.formToTextSpace = 5;//文本间隔
	self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
	self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
	//图例在饼状图中的位置
	self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
	self.pieChartView.legend.formSize = 12;//图示大小
	
	
 	double mult = 100;
    int count = 2;//饼状图总共有几块组成

	//每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        double randomVal = arc4random_uniform(mult + 1);
        PieChartDataEntry *entry = [[PieChartDataEntry alloc]initWithValue:randomVal label:@"工资"];
        [yVals addObject:entry];
    }
	
	
	
	
    PieChartDataSet *dataSet = [[PieChartDataSet alloc]initWithValues:yVals label:@""];
	dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
 	[colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
	
    dataSet.colors = colors;//区块颜色
    dataSet.sliceSpace = 0;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
	dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色

	
	 //data
    PieChartData *data = [[PieChartData alloc]initWithDataSets:@[dataSet]];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterPercentStyle;
//    formatter.maximumFractionDigits = 0;//小数位数
//    formatter.multiplier = @1.f;
//    [data setValueFormatter:formatter];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
	
	self.pieChartView.data = data;

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
