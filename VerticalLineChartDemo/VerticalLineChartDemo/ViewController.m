//
//  ViewController.m
//  VerticalLineChartDemo
//
//  Created by Alexander on 2018/4/7.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "VerticalLineChartDemo-Bridging-Header.h"

@interface ViewController ()<ChartViewDelegate>

@property (nonatomic, strong) HorizontalBarChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	// 水平的柱状图
	
	_chartView = [[HorizontalBarChartView alloc]initWithFrame:CGRectMake(0, 200,[UIScreen mainScreen].bounds.size.width, 300)];
	
	_chartView.delegate = self;
	
	_chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
	
    _chartView.maxVisibleCount = 60;
	
    [self.view addSubview:self.chartView];
	
    // x 轴
	ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 10.0;
	// y 轴
	ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.axisMinimum = 0.0;
	
	
	//
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0;
	
	ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;

    _chartView.fitBars = YES;
	
	
	[_chartView animateWithYAxisDuration:2.5];
	
	
	// 准备些许数据
	NSMutableArray *yVals = [[NSMutableArray alloc] init];
	double range = 15;
	double barWidth = 9.0;
    double spaceForBar = 10.0;
    for (int i = 0; i < 15; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:val icon: [UIImage imageNamed:@""]]];
    }
	
	BarChartDataSet *set1 = nil;
	set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
	set1.drawIconsEnabled = NO;
	NSMutableArray *dataSets = [[NSMutableArray alloc] init];
	[dataSets addObject:set1];
	BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
	[data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
	data.barWidth = barWidth;
	_chartView.data = data;
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
