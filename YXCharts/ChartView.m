//
//  ChartView.m
//  YXCharts
//
//  Created by lenwave_IOS02 on 16/11/16.
//  Copyright © 2016年 高砚祥. All rights reserved.
//

#import "ChartView.h"
#import "PopView.h"





@interface ChartView ()


@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, strong) PopView *pop;



@end


@implementation ChartView



- (PopView *)pop{
    if (!_pop) {
        self.pop = [[PopView alloc] initWithFrame:CGRectMake(0, 0, Pop_W, Pop_H)];
        self.pop.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.pop];
    }
    return _pop;
}


+ (instancetype)drawChartView:(CGRect)rect pointYAry:(NSArray *)pointAry{
    
    ChartView *chartView = [[ChartView alloc] initWithFrame:rect];
    chartView.pointYAry = pointAry;
    chartView.selectIndex = pointAry.count-1;
    return chartView;
}



- (void)setSelectIndex:(NSInteger)selectIndex{
    
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        self.pop.center = CGPointMake(selectIndex*SpaceX+KScreenWidth/2, [self getOffsetY:selectIndex]+(Pop_H-Dog_R)/2);
        self.pop.valueY = self.pointYAry[selectIndex];
    }
}



- (void)setPointYAry:(NSArray *)pointYAry{
    _pointYAry = pointYAry;
    self.maxY = [[pointYAry valueForKeyPath:@"@max.floatValue"] floatValue];
    self.minY = [[pointYAry valueForKeyPath:@"@min.floatValue"] floatValue];
    
        [self setNeedsDisplay];
}









- (void)drawRect:(CGRect)rect{
    
    

        
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(context, CGSizeMake(0, 4.5), 9, TEXT_COLOR_BLACK_30.CGColor);
    CGContextBeginPath(context);
    if (self.pointYAry.count==0) {
        return ;
    }
   
    for (int i = 0; i< self.pointYAry.count-1; i++) {
        //        CGFloat sizeY = [self.pointYAry[i] floatValue];
        CGFloat sizeY = [self getOffsetY:i];
        
        CGFloat  currentPointX = KScreenWidth/2+SpaceX*i;
        CGFloat currentPointY = sizeY+Top_Block;
        
        CGFloat nextPointX = KScreenWidth/2+SpaceX*(i+1);
        //        CGFloat nextPointY = [self.pointYAry[i+1] floatValue]/self.offsetY+Top_Block;
        CGFloat nextPointY = [self getOffsetY:i+1] + Top_Block;
        
        
        
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        
        CGContextSetLineWidth(context, 2.0);
        if (i==0) {
            CGContextMoveToPoint(context, KScreenWidth/2+SpaceX*i, sizeY+Top_Block);
            
        }
        CGFloat firstControlPointX = currentPointX + (nextPointX - currentPointX) / 2;
        CGFloat firstControlPointY = currentPointY;
        CGFloat secondControlPointX = currentPointX + (nextPointX - currentPointX) / 2;
        CGFloat secondControlPointY = nextPointY;
        CGContextAddCurveToPoint(context,firstControlPointX, firstControlPointY, secondControlPointX, secondControlPointY, nextPointX, nextPointY);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    }
            CGContextStrokePath(context);
 
    
    CGContextSetLineWidth(context, 2.0);//线的宽度
    
    
    
    
    for (int i = 0; i<self.pointYAry.count; i++) {
        //        CGFloat sizeY = [self.pointYAry[i] floatValue]/self.offsetY;
        CGFloat sizeY = [self getOffsetY:i];
        
        
        CGFloat  currentPointX = KScreenWidth/2+SpaceX*i;
        CGFloat currentPointY = sizeY+Top_Block;
        
        //画圆
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    
            CGContextSetFillColorWithColor(context, HomePage_Color.CGColor);//填充颜色
    
        
        
        CGContextSetShadowWithColor(context, CGSizeMake(0, 4.5), 9, TEXT_COLOR_BLACK_30.CGColor);
        
        CGContextAddArc(context, currentPointX, currentPointY, Dog_R, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    }
    
    
    
}






- (CGFloat)getOffsetY:(NSInteger)index
{
    return Total_Hight*(self.maxY-[self.pointYAry[index] floatValue])/(self.maxY-self.minY);
}

























@end
