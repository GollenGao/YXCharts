//
//  ViewController.m
//  YXCharts
//
//  Created by lenwave_IOS02 on 16/11/16.
//  Copyright © 2016年 高砚祥. All rights reserved.
//

#import "ViewController.h"
#import "ChartView.h"



@interface ViewController ()<UIScrollViewDelegate>



@property (nonatomic, strong) ChartView *chartview;


@property (nonatomic, strong) NSMutableArray *pointYAry;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.pointYAry = [@[] mutableCopy];
    for (int i = 0; i<20; i++) {
        CGFloat sizeY = arc4random()%50+20;
      
        [self.pointYAry addObject:@(sizeY)];
    }
   
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 150)];
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.delegate = self;

    
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    [self.scrollView setContentSize:CGSizeMake(SpaceX*(self.pointYAry.count-1)+KScreenWidth, 0)];
    
        [self.scrollView setContentOffset:CGPointMake(SpaceX*(self.pointYAry.count-1), 0) animated:YES];


    self.chartview = [ChartView drawChartView:CGRectMake(0, 0, SpaceX*(self.pointYAry.count-1)+KScreenWidth, 150) pointYAry:self.pointYAry];
    self.chartview.backgroundColor = HomePage_Color;
    [self.scrollView addSubview:self.chartview];
    
    [self.view addSubview:self.scrollView];
  
}

- (IBAction)addData:(id)sender {
    
    for (int i = 0; i<20; i++) {
        CGFloat sizeY = arc4random()%50+20;
        [self.pointYAry insertObject:@(sizeY) atIndex:0];
    }
    
    self.chartview.pointYAry = self.pointYAry;
    [self.scrollView setContentSize:CGSizeMake(SpaceX*(self.pointYAry.count-1)+KScreenWidth, 0)];
    CGFloat offsetW = self.scrollView.contentOffset.x+SpaceX*20;

    [self.scrollView setContentOffset:CGPointMake(offsetW, 0)];
    self.chartview.frame = CGRectMake(0, 0, SpaceX*(self.pointYAry.count-1)+KScreenWidth, 150);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int count = scrollView.contentOffset.x/SpaceX;
    int offsetx = (int)scrollView.contentOffset.x%SpaceX;
    if (offsetx >  25) {
       count = scrollView.contentOffset.x/SpaceX+1;
    }
    offsetx = count*SpaceX;
    self.chartview.selectIndex = count;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
