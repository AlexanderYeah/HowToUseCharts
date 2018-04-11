//
//  ViewController.m
//  MultibarDemo
//
//  Created by Alexander on 2018/4/10.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "MultibarDemo-Bridging-Header.h"

@interface ViewController ()<ChartViewDelegate>

@property (nonatomic, strong) BarChartView *chartView;



@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createUI];
	
	
}

- (void)createUI
{
	
	_chartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 200,[UIScreen mainScreen].bounds.size.width, 300)];
	
	_chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.maxVisibleCount = 40;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = NO;
    _chartView.highlightFullBarEnabled = NO;
	
	[self.view addSubview:self.chartView];
	
	NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
	
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    _chartView.rightAxis.enabled = NO;
	
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTop;
	
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.formToTextSpace = 4.0;
    l.xEntrySpace = 6.0;
	
	
	
    // 数据源
	NSMutableArray *yVals = [[NSMutableArray alloc] init];
	
	int count = 8;
	int range = 15;
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val1 = (double) (arc4random_uniform(mult) + mult / 3);
        double val2 = (double) (arc4random_uniform(mult) + mult / 3);
        double val3 = (double) (arc4random_uniform(mult) + mult / 3);
		
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(val1), @(val2), @(val3)] icon: [UIImage imageNamed:@"icon"]]];
    }
	
	BarChartDataSet *set1 = nil;
	set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Statistics Vienna 2014"];
	
	set1.drawIconsEnabled = NO;
	
	set1.colors = @[ChartColorTemplates.material[0], ChartColorTemplates.material[1], ChartColorTemplates.material[2]];
	set1.stackLabels = @[@"Births", @"Divorces", @"Marriages"];
	
	NSMutableArray *dataSets = [[NSMutableArray alloc] init];
	[dataSets addObject:set1];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.maximumFractionDigits = 1;
	formatter.negativeSuffix = @" $";
	formatter.positiveSuffix = @" $";
	
	BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
	[data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
	[data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
	[data setValueTextColor:UIColor.whiteColor];
	
	_chartView.fitBars = YES;
	_chartView.data = data;
	

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
