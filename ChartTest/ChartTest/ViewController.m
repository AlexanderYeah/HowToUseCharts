//
//  ViewController.m
//  ChartTest
//
//  Created by Alexander on 2018/1/29.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "ChartTest-Bridging-Header.h"
#import "DayAxisValueFormatter.h"
#import "DateValueFormatter.h"
#import "TimeXAxisValueFormatter.h"
@interface ViewController ()<ChartViewDelegate>

/** 折线图的使用 */
@property(nonatomic,strong)LineChartView *chartView;
@property(nonatomic,retain)LineChartData *lineChartData;

/** 柱状图的使用*/
@property (nonatomic,strong)BarChartView *barChartView;
@property (nonatomic,strong)BarChartData *barChartData;



@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// [self showBarChart];
	[self showLineChart];

}

#pragma mark -  柱状图部分
- (void)showBarChart
{
	_barChartView = [[BarChartView alloc]init];
	
	
	
	[self.view addSubview:_barChartView];
	_barChartView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
	_barChartView.noDataText = @"没有数据";
    _barChartView.dragEnabled = YES;//设置图表里能不能被拖动
    [_barChartView setScaleEnabled:YES];//设置图表能不能被放大
    _barChartView.pinchZoomEnabled = YES;
    _barChartView.drawGridBackgroundEnabled = YES;
    _barChartView.delegate = self;
    _barChartView.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x轴在下面显示，默认是在上面
    _barChartView.data = self.barChartData;//设置数据
	
	// 设置X 轴标题是如何显示的
	ChartXAxis *xAxis = _barChartView.xAxis;
	// 标题的位置
    xAxis.labelPosition = XAxisLabelPositionBottom;
    // 字体的代销
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    // 是否画栅格
    xAxis.drawGridLinesEnabled = NO;
    // 每隔几个显示一个标题
    xAxis.granularity = 0; // only intervals of 1 day
    // 标题的数量
    xAxis.labelCount = 4;
	// 自定义X轴的标题
	xAxis.valueFormatter = [[TimeXAxisValueFormatter alloc]init];
	
	
	
}


- (BarChartData *)barChartData
{
	NSMutableArray *xVals = [[NSMutableArray alloc]initWithCapacity:12];
    for (int i = 0; i < 12; i++)
    {
        [xVals addObject:[NSString stringWithFormat:@"%d月",i+1]];
    }

    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++)
    {
        double mult = (12 + 1);
        double val = (double) (arc4random_uniform(mult)) + 3;
        [yVals addObject:[[BarChartDataEntry alloc]initWithX:i y:val]];
    }

	BarChartDataSet *set1 = nil;
	set1 = [[BarChartDataSet alloc]initWithValues:yVals];
	set1.barBorderColor = [UIColor blueColor];
	set1.barBorderWidth = 0.1;
	set1.barShadowColor = [UIColor yellowColor];
	NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
	_barChartData = [[BarChartData alloc] initWithDataSets:dataSets];
	return _barChartData;
}

#pragma mark -  折线图部分
/** 折线图的使用 */
- (void)showLineChart
{
    _chartView = [[LineChartView alloc]init];
    [self.view addSubview:_chartView];
    _chartView.frame = CGRectMake(0, 200, self.view.frame.size.width, 300);
    _chartView.noDataText = @"没有数据";
    _chartView.dragEnabled = YES;//设置图表里能不能被拖动
    [_chartView setScaleEnabled:YES];//设置图表能不能被放大
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = YES;
    _chartView.delegate = self;
    _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x轴在下面显示，默认是在上面
    _chartView.data = self.lineChartData;//设置数据
}

-(LineChartData *)lineChartData{
    NSMutableArray *xVals = [[NSMutableArray alloc]initWithCapacity:12];
    for (int i = 0; i < 12; i++)
    {
        [xVals addObject:[NSString stringWithFormat:@"%d月",i+1]];
    }

    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++)
    {
        double mult = (1200 + 1);
        double val = (double) (arc4random_uniform(mult)) + 3;
        [yVals addObject:[[ChartDataEntry alloc]initWithX:i y:val]];
    }
    LineChartDataSet *set1 = nil;
    LineChartDataSet *set2 = nil;
	
	set1 = [[LineChartDataSet alloc]initWithValues:yVals label:@"lineChartData 1"];
	
	[set1 setColor:UIColor.blackColor];
	[set1 setCircleColor:UIColor.blackColor];
	set1.lineWidth = 1.0;
	set1.circleRadius = 3.0;
	set1.drawCircleHoleEnabled = NO;
	NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
	
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;

        CGGradientRelease(gradient);
	
	
		_lineChartData = [[LineChartData alloc]initWithDataSet:set1];
//    if (_chartView.data.dataSetCount > 0)
//    {
//        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
//        set1.yVals = yVals;
//        _chartView.data.xValsObjc = xVals;
//        [_chartView notifyDataSetChanged];
//    }
//    else
//    {
//        set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"lineChartData 1"];
//        //set1.lineDashLengths = @[@5.f, @2.5f];
//        //set1.highlightLineDashLengths = @[@5.f, @2.5f];
//        [set1 setColor:UIColor.blackColor];
//        [set1 setCircleColor:UIColor.blackColor];
//        set1.lineWidth = 1.0;
//        set1.circleRadius = 3.0;
//        set1.drawCircleHoleEnabled = NO;
//        set1.valueFont = [UIFont systemFontOfSize:9.f];
//        //set1.fillAlpha = 65/255.0;
//        //set1.fillColor = UIColor.blackColor;
//
//        NSArray *gradientColors = @[
//                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
//                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
//                                    ];
//        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
//
//        set1.fillAlpha = 1.f;
//        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
//        set1.drawFilledEnabled = YES;
//
//        CGGradientRelease(gradient);
//
//        set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@"lineChartData 2"];
//        //        set2.lineDashLengths = @[@5.f, @2.5f];
//        //        set2.highlightLineDashLengths = @[@5.f, @2.5f];
//        [set2 setColor:UIColor.yellowColor];//设置set2线条的颜色
//        [set2 setCircleColor:UIColor.purpleColor];//设置set2的小圆圈的颜色
//        set2.lineWidth = 1.0;
//        set2.circleRadius = 3.0;
//        set2.drawCircleHoleEnabled = NO;
//        set2.valueFont = [UIFont systemFontOfSize:9.f];
//
//        _lineChartData = [[LineChartData alloc] initWithXVals:xVals dataSets:@[set1,set2]];
//    }

    return _lineChartData;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
