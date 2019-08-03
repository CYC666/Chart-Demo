//
//  DemoViewController.m
//  AAChartKitDemo
//
//  Created by 曹老师 on 2019/8/3.
//  Copyright © 2019 Danny boy. All rights reserved.
//

#import "DemoViewController.h"
#import "AAChartKit.h"
#import "AAEasyTool.h"
#import "ChartPointModel.h"

@interface DemoViewController ()

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (strong, nonatomic) NSMutableArray *dataList;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Chart Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataList = [self getDataList];
    
    
    self.aaChartView = [self setUpAAChartView];
    self.aaChartModel = [self setUpAAChartModel];
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
}



- (AAChartView *)setUpAAChartView {
    CGRect chartViewFrame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width);
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:chartViewFrame];
    aaChartView.scrollEnabled = NO;
    [self.view addSubview:aaChartView];
    return aaChartView;
}










- (AAChartModel *)setUpAAChartModel  {
    
    
    NSMutableArray *categoriesSet = [NSMutableArray array];
    NSMutableArray *dataSet = [NSMutableArray array];
    for (ChartPointModel *model in self.dataList) {
        NSString *date = [model.operatedate substringWithRange:NSMakeRange(5, 5)];
        [categoriesSet addObject:date];
        
        [dataSet addObject:model.operatevalue];
    }
    
    
    NSDictionary *gradientColorDic1 =
    @{@"linearGradient": @{
              @"x1": @0.0,
              @"y1": @0.0,
              @"x2": @0.0,
              @"y2": @1.0
              },
      @"stops": @[@[@0.00, @"rgba(42,110,215,0.5)"],//#2A6ED7, alpha 透明度 1
                  @[@1.00, @"rgba(42,110,215,0.1)"],//#2A6ED7, alpha 透明度 0.1
                  ]//颜色字符串设置支持十六进制类型和 rgba 类型
      };
    
    return AAChartModel.new
    .chartTypeSet(AAChartTypeAreaspline)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(categoriesSet)
    .yAxisTitleSet(@"")
    .markerRadiusSet(@0)
    .tooltipEnabledSet(true)
    .tooltipValueSuffixSet(@"%")
    .markerSymbolStyleSet(AAChartSymbolStyleTypeDefault)
    .markerSymbolSet(AAChartSymbolTypeCircle)//marker点为圆形点○
    .yAxisGridLineWidthSet(@0.5)
    .xAxisGridLineWidthSet(@0.5)
    .legendEnabledSet(false)
    .easyGradientColorsSet(true)
    .seriesSet(@[
                 AASeriesElement.new
                 .nameSet(@"七日年化")
                 .lineWidthSet(@2.0)
                 .colorSet(@"rgba(42,110,215,1)")//#2A6ED7, alpha 透明度 1
                 .fillColorSet((id)gradientColorDic1)
                 .dataSet(dataSet),
                 ]
               );
}







- (NSMutableArray *)getDataList {
    
    NSDictionary *respond = @{@"Code": @(200),
                             @"Message": @"获取成功",
                             @"Data": @{
                                @"Characteristic": @"稳健收益，低风险",
                                @"RateList": @[
                                        @{
                                            @"operatevalue": @(0.039000),
                                            @"operatedate": @"2019-07-15 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.046000),
                                            @"operatedate": @"2019-07-20 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.046000),
                                            @"operatedate": @"2019-07-21 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.045000),
                                            @"operatedate": @"2019-07-22 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.043000),
                                            @"operatedate": @"2019-07-23 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.042000),
                                            @"operatedate": @"2019-07-24 00:00:00.000"
                                            },
                                        @{
                                            @"operatevalue": @(0.041000),
                                            @"operatedate": @"2019-07-29 00:00:00.000"
                                            }]
                                }
                             };
   
    
    NSMutableArray *dataList = [NSMutableArray array];
    
    NSString *code = [NSString stringWithFormat:@"%@", respond[@"Code"]];
    if ([code isEqualToString:@"200"]) {
        
        NSArray *list = respond[@"Data"][@"RateList"];
        for (NSDictionary *dic in list) {
            ChartPointModel *model = [[ChartPointModel alloc] init];
            model.operatevalue = dic[@"operatevalue"];
            model.operatedate = dic[@"operatedate"];
            [dataList addObject:model];
        }
        
    }
    
    return dataList;
    
}












@end
