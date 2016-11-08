//
//  ViewController.m
//  RingViewUseDemo
//
//  Created by JayZY on 16/11/7.
//  Copyright © 2016年 MK INC. All rights reserved.
//

#import "ViewController.h"

#import "CBRectangleRound.h"

//屏幕尺寸
#define AppScreenHeight             [[UIScreen mainScreen] bounds].size.height
#define AppScreenWidth              [[UIScreen mainScreen] bounds].size.width

#define ROUND_VIEW_HEIGHT 120

#define Margin  (AppScreenWidth-2*ROUND_VIEW_HEIGHT)/3.0

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    //
//    [self addRingView];
    
    [self testBezierView];
    
}


#pragma mark -TEST
- (void)testBezierView
{
    CBRectangleRound *roundView = [[CBRectangleRound alloc] initWithFrame:CGRectMake(Margin, 200, ROUND_VIEW_HEIGHT, ROUND_VIEW_HEIGHT)];
    [self.view addSubview:roundView];
}

#pragma mark -
- (void)addRingView
{
    CBRectangleRound *roundView1 = [[CBRectangleRound alloc] initWithFrame:CGRectMake(Margin, 100, ROUND_VIEW_HEIGHT, ROUND_VIEW_HEIGHT)];
    [self.view addSubview:roundView1];
    [roundView1 setPoint:-12 Title:@"测试圆环1" withAnimation:YES];
    
    CBRectangleRound *roundView2 = [[CBRectangleRound alloc] initWithFrame:CGRectMake(Margin*2+ROUND_VIEW_HEIGHT, 100, ROUND_VIEW_HEIGHT, ROUND_VIEW_HEIGHT)];
    [self.view addSubview:roundView2];
    [roundView2 setPoint:+2.7 Title:@"测试圆环2" withAnimation:YES];
    
    CBRectangleRound *roundView3 = [[CBRectangleRound alloc] initWithFrame:CGRectMake(Margin, 250, ROUND_VIEW_HEIGHT, ROUND_VIEW_HEIGHT)];
    [self.view addSubview:roundView3];
    [roundView3 setPoint:-4.8 Title:@"测试圆环3" withAnimation:YES];
    
    CBRectangleRound *roundView = [[CBRectangleRound alloc] initWithFrame:CGRectMake(Margin*2+ROUND_VIEW_HEIGHT, 250, ROUND_VIEW_HEIGHT, ROUND_VIEW_HEIGHT)];
    [self.view addSubview:roundView];
    [roundView setPoint:+10 Title:@"测试圆环4" withAnimation:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
