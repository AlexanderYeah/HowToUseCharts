//
//  ViewController.m
//  SanDianDemo
//
//  Created by Alexander on 2018/4/7.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "SanDianDemo-Bridging-Header.h"
@interface ViewController ()<ChartViewDelegate>

@property(nonatomic,strong)ScatterChartView *chartView;



@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createUI];
	
	
}


- (void)createUI
{
	
	_chartView = [[ScatterChartView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 300)];
	_chartView.delegate = self;
    _chartView.chartDescription.enabled = NO;
	 _chartView.drawGridBackgroundEnabled = NO;
    _chartView.dragEnabled = YES;
 	[_chartView setScaleEnabled:YES];
	[self.view addSubview:_chartView];
	_chartView.maxVisibleCount = 200;
    _chartView.pinchZoomEnabled = YES;
	
	ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    l.xOffset = 5.0;
	
    ChartYAxis *yl = _chartView.leftAxis;
    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    yl.axisMinimum = 0.0; // this replaces startAtZero = YES
	
    _chartView.rightAxis.enabled = NO;
	
    ChartXAxis *xl = _chartView.xAxis;
    xl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    
    xl.drawGridLinesEnabled = NO;
    // label 的位置
	xl.labelPosition = 1;
	NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
	double range = 15000;
    for (int i = 0; i < 15; i++)
    {
        double val = (double) (arc4random_uniform(range)) + 3;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:(double)i y:val]];
		
        val = (double) (arc4random_uniform(range)) + 3;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.33 y:val]];
		
        val = (double) (arc4random_uniform(range)) + 3;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.66 y:val]];
    }
	
    ScatterChartDataSet *set1 = [[ScatterChartDataSet alloc] initWithValues:yVals1 label:@"DS 1"];
    [set1 setScatterShape:ScatterShapeSquare];
    [set1 setColor:ChartColorTemplates.colorful[0]];
    ScatterChartDataSet *set2 = [[ScatterChartDataSet alloc] initWithValues:yVals2 label:@"DS 2"];
    [set2 setScatterShape:ScatterShapeCircle];
    set2.scatterShapeHoleColor = ChartColorTemplates.colorful[3];
    set2.scatterShapeHoleRadius = 3.5f;
    [set2 setColor:ChartColorTemplates.colorful[1]];
    ScatterChartDataSet *set3 = [[ScatterChartDataSet alloc] initWithValues:yVals3 label:@"DS 3"];
    [set3 setScatterShape:ScatterShapeCross];
    [set3 setColor:ChartColorTemplates.colorful[2]];
	
    set1.scatterShapeSize = 8.0;
    set2.scatterShapeSize = 8.0;
    set3.scatterShapeSize = 8.0;
	
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
	
    ScatterChartData *data = [[ScatterChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
	
    _chartView.data = data;
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
