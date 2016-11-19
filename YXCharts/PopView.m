//
//  PopView.m
//  YXCharts
//
//  Created by lenwave_IOS02 on 16/11/18.
//  Copyright © 2016年 高砚祥. All rights reserved.
//

#import "PopView.h"

@interface PopView ()





@end

@implementation PopView




- (void)setValueY:(NSNumber *)valueY{
    _valueY = valueY;
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect{
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat kArrorHeight = Triangle_W/2;
    //取出当前的图形大小
    
//    self.pointYAry[self.selectIndex
    NSString *title = [NSString stringWithFormat:@"%@", self.valueY];
    CGSize tSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    CGFloat rWidth = tSize.width+8;
    CGFloat rHigth = PopText_H;
    
//    CGFloat rRectX = self.selectIndex*SpaceX+KScreenWidth/2 - rWidth/2;

    CGFloat rRectX = (rect.size.width-rWidth)/2;
    
    CGFloat rRectY = 0;
//    CGFloat rRectY = [self getOffsetY:self.selectIndex]+Top_Block-rHigth-Triangle_W;
    
    
    
    CGRect rRect = CGRectMake(rRectX, rRectY, rWidth, rHigth);
    //设置园弧度
    
    //倒三角的角度
    
    CGFloat minx = CGRectGetMinX(rRect),//0
    //中点
    midx = CGRectGetMidX(rRect),//Top_Block0
    //最大的宽度的X
    maxx = CGRectGetMaxX(rRect);//200
    CGFloat miny = CGRectGetMinY(rRect),//0
    //最大的高度Y
    maxy = CGRectGetMaxY(rRect)-kArrorHeight;//60
    
    //1.画向下的三角形
    //2.设置起点三角形的右边点为起点
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    //3.连线 右边点  －>连最下面上下面的点
    CGContextAddLineToPoint(context, midx, maxy+kArrorHeight*tan(Triangle_A));//画直线
    //4.最下面的点连上  最左边的点。
    CGContextAddLineToPoint(context, midx-kArrorHeight, maxy);
    
    //画4个圆弧
    
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, Dog_R);//画完后 current point不在minx,miny，而是在圆弧结束的地方
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, Dog_R);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, Dog_R);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, Dog_R);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [title drawInRect:rRect withAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:HomePage_Color,NSParagraphStyleAttributeName:style}];
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    CGContextAddArc(context, midx, maxy+Triangle_W*2, Dog_R, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
}































@end
