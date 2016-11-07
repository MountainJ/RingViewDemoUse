//
//  CBRectangleRound.m
//  KKOL
//
//  Created by CB on 16/10/21.
//  Copyright © 2016年 KKZX. All rights reserved.
//  创建一个圆环

#import "CBRectangleRound.h"

#define CB_COLOR_0_5 [UIColor colorWithRed:248/255.0 green:153/255.0 blue:93/255.0 alpha:1]
#define CB_COLOR_5_10 [UIColor colorWithRed:243/255.0 green:111/255.0 blue:33/255.0 alpha:1]
#define CB_COLOR_10_15 [UIColor colorWithRed:239/255.0 green:65/255.0 blue:54/255.0 alpha:1]
#define CB_COLOR_0_F5 [UIColor colorWithRed:78/255.0 green:201/255.0 blue:245/255.0 alpha:1]
#define CB_COLOR_F5_F10 [UIColor colorWithRed:0/255.0 green:174/255.0 blue:239/255.0 alpha:1]
#define CB_COLOR_F10_F15 [UIColor colorWithRed:0/255.0 green:146/255.0 blue:215/255.0 alpha:1]
#define CB_COLOR_GRAY [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]

@interface CBRectangleRound()
{
    BOOL isAnimating;
}
//得分 -15 到 15
@property (nonatomic, assign) int  point;

@property (nonatomic, assign) double  realPoint;

@property (nonatomic, assign) int  currentPoint;//用于计时器

@property (nonatomic, strong) UIColor * topicColor;

@property (nonatomic, copy) NSString * mainTitle;

@property (nonatomic, copy) NSString * subTitle;

@property (nonatomic, assign) BOOL  isClockwise;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * subTitleLabel;

@property (nonatomic, strong) UILabel * leftLabel;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation CBRectangleRound

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initUI];
        
    }
    return self;
}

-(UIColor *)topicColor{
    if(!_topicColor){
        _topicColor = CB_COLOR_GRAY;

    }
    return _topicColor;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.isClockwise = YES;
}

-(void)drawRect:(CGRect)rect{
    
    //背景留白
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    //
    CGFloat startAngle;
    CGFloat endAngle;
    CGFloat centerX = self.frame.size.width/2;
    CGFloat centerY = self.frame.size.height/2;
    
        for(int i=0; i<15; i++){
            UIBezierPath *beizerPath = [UIBezierPath bezierPath];
            //设置绘制线条的颜色及宽度
            [[UIColor whiteColor] setStroke];
            beizerPath.lineWidth = 3;
            //设置填充的颜色
            if(self.currentPoint == 0){
                 [CB_COLOR_GRAY setFill];
            }else{
                if(self.isClockwise){
                    if(i < self.currentPoint){
                        [self.topicColor setFill];
                    }else{
                        [CB_COLOR_GRAY setFill];
                    }
                }else{
                    if(i < self.currentPoint + 15){
                        [CB_COLOR_GRAY setFill];
                    }else{
                        [self.topicColor setFill];
                    }
                }
            }
            CGFloat r = self.frame.size.height/2;
            startAngle = -M_PI/2   + M_PI/15.0 * i *2;
            endAngle = -M_PI/2 +M_PI /15.0 * 2 + M_PI/15.0 * i * 2;
            [beizerPath addArcWithCenter:CGPointMake(centerX, centerY) radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
            [beizerPath addLineToPoint:CGPointMake(centerX, centerY)];
            [beizerPath closePath];
            
            [beizerPath stroke];
            [beizerPath fill];
            
            
            //画出白色的圆环遮挡
            UIBezierPath *beizerPath2 = [UIBezierPath bezierPath];
            CGFloat r2 = self.frame.size.height*5/12;
            [[UIColor whiteColor] set];
            beizerPath2.lineWidth = 3;
            [beizerPath2 addArcWithCenter:CGPointMake(centerX, centerY) radius:r2 startAngle:startAngle endAngle:endAngle clockwise:YES];
            [beizerPath2 addLineToPoint:CGPointMake(centerX, centerY)];
            [beizerPath2 closePath];
            [beizerPath2 stroke];
            [beizerPath2 fill];
        }

    
    //中间的圆环
    CGFloat r = self.frame.size.height/3;
    UIBezierPath *beizerPath = [UIBezierPath bezierPath];
    if(self.point == 0){
        [CB_COLOR_GRAY setFill];
    }else{
         [self.topicColor setFill];
    }
    [beizerPath addArcWithCenter:CGPointMake(centerX, centerY) radius:r startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [beizerPath fill];
    
    
    if(!self.titleLabel){
        self.titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, r*9/10 * 2, 20)];
        [self addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if(!self.subTitleLabel){
        self.subTitleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, r*4/5, 30)];
        [self addSubview:self.subTitleLabel];
        self.subTitleLabel.textColor = [UIColor whiteColor];
        self.subTitleLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:27];
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if(!self.leftLabel){
        self.leftLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self addSubview:self.leftLabel];
        self.leftLabel.textColor = [UIColor whiteColor];
        self.leftLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:20];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    
    self.titleLabel.center = CGPointMake(centerX, centerY  - r /4);
    self.subTitleLabel.center = CGPointMake(centerX, centerY + r/4);
    self.leftLabel.center = CGPointMake(self.frame.size.height/2 -  self.frame.size.height/3 +  self.frame.size.height/3/3, centerY + r/6);
    
    self.titleLabel.text = self.mainTitle;
    self.subTitleLabel.text = self.subTitle;
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
     [self.subTitleLabel
      setAdjustsFontSizeToFitWidth:YES];
   
    
    if(self.realPoint >0){
        self.leftLabel.text = @"+";
    }else if(self.realPoint < 0){
        self.leftLabel.text = @"-";
    }else{
        self.leftLabel.text = @"";
    }

}


/**
 设置属性

point    得分 -15到15 用来确定颜色区域
 title    主标题例如   （血压年龄）
 subTitle 副标题例如  （+ 12.2）
 */
-(void)setPoint:(CGFloat)point Title:(NSString *)title{
    self.mainTitle = title;
    self.point = round(point);
    self.currentPoint = round(point);
    if(self.point > 0){
        self.subTitle =  [NSString stringWithFormat:@"%.1f",point];
    }else if(self.point< 0){
        self.subTitle =  [NSString stringWithFormat:@"%.1f",-point];
    }else{
        self.subTitle = @"0.0";
    }

    if(point >0 && point <= 5){
        self.topicColor = CB_COLOR_0_5;
    }else if(point >5 && point <= 10){
        self.topicColor = CB_COLOR_5_10;
    }else if(point >10 && point <= 15){
        self.topicColor = CB_COLOR_10_15;
    }else if(point >=-5 && point < 0){
        self.topicColor = CB_COLOR_0_F5;
    }else if(point >=-10 && point < -5){
        self.topicColor = CB_COLOR_F5_F10;
    }else if(point >= -15 && point < -10){
        self.topicColor = CB_COLOR_F10_F15;
    }
    
    if(point > 0){
        self.isClockwise = YES;
    }else if(point <0){
        self.isClockwise = NO;
    }
    
    self.realPoint = point;
    
    [self setNeedsDisplay];
}


-(void)setPoint:(CGFloat)point Title:(NSString *)title withAnimation:(BOOL)isAnimated{
    if(!isAnimated){
        [self setPoint:point Title:title];
    }else{
        self.mainTitle = title;
        self.point = round(point);
        self.realPoint = point;
        if(point > 0){
            self.subTitle =  [NSString stringWithFormat:@"%.1f",point];
        }else if(point  < 0){
            self.subTitle =  [NSString stringWithFormat:@"%.1f",-point];
        }else{
            self.subTitle = @"0.0";
        }

        if(!self.timer){
            self.currentPoint = 0;
            isAnimating = YES;
            self.timer =[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        }
       
    }
}


/**
 定时器调用方法

 @param currentPoint 当前点数
 */
-(void)setCurrPoint:(int)currentPoint{
    self.currentPoint = currentPoint;
    
    if(self.currentPoint >0 && self.currentPoint <= 5){
        self.topicColor = CB_COLOR_0_5;
    }else if(self.currentPoint >5 && self.currentPoint <= 10){
        self.topicColor = CB_COLOR_5_10;
    }else if(self.currentPoint >10 && self.currentPoint <= 15){
        self.topicColor = CB_COLOR_10_15;
    }else if(self.currentPoint >=-5 && self.currentPoint < 0){
        self.topicColor = CB_COLOR_0_F5;
    }else if(self.currentPoint >=-10 && self.currentPoint < -5){
        self.topicColor = CB_COLOR_F5_F10;
    }else if(self.currentPoint >= -15 && self.currentPoint < -10){
        self.topicColor = CB_COLOR_F10_F15;
    }
    
    if(self.realPoint > 0){
        self.isClockwise = YES;
    }else if(self.realPoint <0){
        self.isClockwise = NO;
    }
    
    
    [self setNeedsDisplay];
}



/**
 定时器方法
 */
-(void)timerTick{
    if(self.point == 0){
        [self setCurrPoint:0];
        [self destroyTimer];
        return;
    }
    if(self.realPoint<1.5&&self.realPoint >0){
        [self setCurrPoint:1];
        [self destroyTimer];
        return;
    }else if(self.realPoint <0 && self.realPoint >-1.5){
        [self setCurrPoint:-1];
        [self destroyTimer];
        return;
    }
    
    if(self.realPoint >= 1.5){
        if(self.currentPoint < self.point){
            [self setCurrPoint:self.currentPoint];
            self.currentPoint ++;
        }else{
            [self destroyTimer];
        }
    }else if(self.realPoint <= -1.5){
        if(self.currentPoint > self.point){
            [self setCurrPoint:self.currentPoint];
            self.currentPoint --;
        }else{
            [self destroyTimer];
        }
    }
    
}

-(void)destroyTimer{
    if([self.timer isValid]){
        [self.timer invalidate];
        self.timer =  nil;
    }
}

-(void)dealloc{
    [self destroyTimer];
}

@end
