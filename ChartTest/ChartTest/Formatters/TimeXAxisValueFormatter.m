//
//  TimeXAxisValueFormatter.m
//  ChartTest
//
//  Created by Alexander on 2018/1/30.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "TimeXAxisValueFormatter.h"

@implementation TimeXAxisValueFormatter

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{

	// 此处自定义要返回的X轴标题
	NSString *val = [NSString stringWithFormat:@"第%.0f日",value];
    return val;
	
}

@end
