//
//  ChartView.h
//  YXCharts
//
//  Created by lenwave_IOS02 on 16/11/16.
//  Copyright © 2016年 高砚祥. All rights reserved.
//

#import <UIKit/UIKit.h>




//#define Space

@interface ChartView : UIView



@property (nonatomic, copy) NSArray *pointYAry;

@property (nonatomic, assign) NSInteger selectIndex;


+ (instancetype)drawChartView:(CGRect)rect pointYAry:(NSArray *)pointAry;















@end
