//
//  ViewController.m
//  SingLineDemo
//
//  Created by Alexander on 2018/4/12.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "SingLineDemo-Bridging-Header.h"
@interface ViewController ()<ChartViewDelegate>

// 折线图
@property (nonatomic, strong) LineChartView *chartView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createUI];
}


#pragma mark -  创建UI
- (void)createUI
{

	_chartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 200,self.view.frame.size.width , 350)];
	_chartView.delegate = self;
	
	_chartView.chartDescription.enabled = NO;
	[self.view addSubview:self.chartView];
	_chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = YES;
	
	_chartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
	
	
	ChartLegend *l = _chartView.legend;
    l.form = ChartLegendFormLine;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.textColor = UIColor.whiteColor;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
	
	ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = UIColor.whiteColor;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;
	
	
	ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = 0.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
	
	ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.labelTextColor = UIColor.redColor;
    rightAxis.axisMaximum = 900.0;
    rightAxis.axisMinimum = -200.0;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = NO;
	
    [_chartView animateWithXAxisDuration:2.5];
	
	NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
	int count = 6;
	int range = 15;
    for (int i = 0; i < count; i++)
    {
        double mult = range / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
	
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 450;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
	
    for (int i = 0; i < count; i++)
    {
        double mult = range;
        double val = (double) (arc4random_uniform(mult)) + 500;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
	
    LineChartDataSet *set1 = nil, *set2 = nil, *set3 = nil;
	
	
            set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
	
        set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:UIColor.redColor];
        [set2 setCircleColor:UIColor.whiteColor];
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 65/255.0;
        set2.fillColor = UIColor.redColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
	
        set3 = [[LineChartDataSet alloc] initWithValues:yVals3 label:@"DataSet 3"];
        set3.axisDependency = AxisDependencyRight;
        [set3 setColor:UIColor.yellowColor];
        [set3 setCircleColor:UIColor.whiteColor];
        set3.lineWidth = 2.0;
        set3.circleRadius = 3.0;
        set3.fillAlpha = 65/255.0;
        set3.fillColor = [UIColor.yellowColor colorWithAlphaComponent:200/255.f];
        set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set3.drawCircleHoleEnabled = NO;
	
		// 是否填充内部
		set1.drawFilledEnabled = NO;
		set2.drawFilledEnabled = NO;
		set3.drawFilledEnabled = NO;
	
		// 是否画关键的节点为原点
		set1.drawCirclesEnabled = YES;
		set2.drawCirclesEnabled = NO;
		set3.drawCirclesEnabled = YES;
	
	
		// 划线为平滑的曲线或者有坡度的线
		set1.mode = LineChartModeCubicBezier;
		set2.mode = LineChartModeLinear;
		set3.mode = LineChartModeLinear;
	
		// 是否显示值
		set1.drawValuesEnabled = NO;
		set2.drawValuesEnabled = YES;
		set3.drawValuesEnabled = YES;
	
	
	
	
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
	
	
	
		LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
	
        _chartView.data = data;

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
