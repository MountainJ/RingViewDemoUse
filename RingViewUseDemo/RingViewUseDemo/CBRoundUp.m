//
//  CBRoundUp.m
//  KKOL
//
//  Created by CB on 16/10/24.
//  Copyright © 2016年 KKZX. All rights reserved.
//   

#import "CBRoundUp.h"
#import "CBRoundDown.h"

#define CB_COLOR_0_5 [UIColor colorWithRed:248/255.0 green:153/255.0 blue:93/255.0 alpha:1]
#define CB_COLOR_5_10 [UIColor colorWithRed:243/255.0 green:111/255.0 blue:33/255.0 alpha:1]
#define CB_COLOR_10_15 [UIColor colorWithRed:239/255.0 green:65/255.0 blue:54/255.0 alpha:1]
#define CB_COLOR_0_F5 [UIColor colorWithRed:78/255.0 green:201/255.0 blue:245/255.0 alpha:1]
#define CB_COLOR_F5_F10 [UIColor colorWithRed:0/255.0 green:174/255.0 blue:239/255.0 alpha:1]
#define CB_COLOR_F10_F15 [UIColor colorWithRed:0/255.0 green:146/255.0 blue:215/255.0 alpha:1]
#define CB_COLOR_GRAY [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]

@interface CBRoundUp()
{
    BOOL isFirstInit;
    
    UIColor *bColor;
}

@property (nonatomic, strong) UIImageView * upImageView;

@property (nonatomic, strong) UIImageView * downImageView;

@property (nonatomic, strong) UIImageView * pointFlagImageView;

@property (nonatomic, strong) UILabel * minAgeLabel;

@property (nonatomic, strong) UILabel * cuAgeLabel;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * subTitleLabel;

@property (nonatomic, strong) UILabel * subValueLabel;

@property (nonatomic, strong) CBRoundDown * roundDown;

@property (nonatomic, assign) CGFloat  age;

@property (nonatomic, assign) CGFloat  realAge;

@end

@implementation CBRoundUp

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    isFirstInit = YES;
    bColor = CB_COLOR_0_5;
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat totalWidth = self.frame.size.width;
    CGFloat totalHeight = self.frame.size.height;
    CGFloat upImageHeight = totalHeight * 2 / 3;
    CGFloat downImageHeight = totalHeight / 3;
    CGFloat downImageWidth = totalWidth *10/18;
    CGPoint downImageCenter = CGPointMake(self.frame.size.width/2, upImageHeight+downImageHeight/2 -3);
    
    [self addSubview:self.upImageView];
    self.upImageView.frame = CGRectMake(0, 0, totalWidth, upImageHeight);
    
    [self addSubview:self.downImageView];
    self.downImageView.frame = CGRectMake(0, 0, downImageWidth, downImageHeight);
    self.downImageView.center = downImageCenter;
    
  [self addSubview:self.pointFlagImageView];
  [self addSubview:self.roundDown];
}

#pragma mark - 懒加载

-(UIImageView *)upImageView{
    if(!_upImageView){
        _upImageView = [UIImageView new];
        _upImageView.image = [UIImage imageNamed:@"big_outside_circle"];
    }
    return _upImageView;
}

-(UIImageView *)downImageView{
    if(!_downImageView){
        _downImageView = [UIImageView new];
        _downImageView.image = [UIImage imageNamed:@"inside_down_circle"];
    }
    return _downImageView;
}

-(UIImageView *)pointFlagImageView{
    if(!_pointFlagImageView){
        _pointFlagImageView = [UIImageView new];
        _pointFlagImageView.image = [UIImage imageNamed:@"point_flag"];
    }
    return _pointFlagImageView;
}

-(CBRoundDown *)roundDown{
    if(!_roundDown){
                CGFloat roundWidth = self.frame.size.width/20;
                _roundDown = [[CBRoundDown alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - roundWidth/2, self.frame.size.height *2/3 -self.frame.size.width *35 / 265 -3, roundWidth, self.frame.size.width *7 / 32 *6/5)];
        _roundDown.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return _roundDown;
}


-(void)drawRect:(CGRect)rect{

     UIBezierPath *beizerPath = [UIBezierPath bezierPath];
    [bColor setFill];
    
    CGFloat startAngle = -M_PI;
    CGFloat endAngle = 0;
    CGFloat centerX = self.frame.size.width / 2;
    CGFloat centerY = self.frame.size.height* 2 / 3 - 3;
    CGFloat r = self.frame.size.width *7 / 32;
    [beizerPath addArcWithCenter:CGPointMake(centerX, centerY) radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
    [beizerPath closePath];
    [beizerPath fill];
    
    if(!_minAgeLabel){
        _minAgeLabel = [[UILabel alloc] init];
        _minAgeLabel.textColor = [UIColor whiteColor];
        _minAgeLabel.font = [UIFont systemFontOfSize:27];
        _minAgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    [self addSubview:_minAgeLabel];
    _minAgeLabel.frame = CGRectMake(0, 0, self.frame.size.width/4, 27)
    ;
    _minAgeLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height *2/3 - self.frame.size.width *7 / 32 /2);
    
    if(!_cuAgeLabel){
        _cuAgeLabel = [[UILabel alloc] init];
        _cuAgeLabel.textColor = [UIColor colorWithRed:13/255.0 green:13/255.0  blue:13/255.0  alpha:1];
        _cuAgeLabel.font = [UIFont systemFontOfSize:27];
        _cuAgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    [self addSubview:_cuAgeLabel];
    _cuAgeLabel.frame = CGRectMake(0, 0, self.frame.size.width/4, 27)
    ;
    _cuAgeLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.frame.size.width *1/9 - self.frame.size.width *1/32);

    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:13/255.0 green:13/255.0  blue:13/255.0  alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    [self addSubview:_titleLabel];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width/2, 20)
    ;
    if([UIScreen mainScreen].bounds.size.width ==320){
        _titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.frame.size.width *1/9 - self.frame.size.width *1/32-27 + 5);
    }else{
        _titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.frame.size.width *1/9 - self.frame.size.width *1/32-27 + 5);
    }
    

    CGFloat minY = CGRectGetMinY(_cuAgeLabel.frame);

    
    self.pointFlagImageView.frame = CGRectMake(self.frame.size.width *6/40, minY , 60, 30);
    
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:9];
    }
    [self.pointFlagImageView addSubview:_subTitleLabel];
    _subTitleLabel.frame = CGRectMake(0, 0, 52, 15);
    
    if(!_subValueLabel){
        _subValueLabel = [[UILabel alloc] init];
        _subValueLabel.textColor = [UIColor whiteColor];
        _subValueLabel.font = [UIFont systemFontOfSize:13];
        _subValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    [self.pointFlagImageView addSubview:_subValueLabel];
    _subValueLabel.frame = CGRectMake(0, 10, 52, 20);
    
    if(_age > 0){
        _minAgeLabel.text = [NSString stringWithFormat:@"+%.1f",_age];
    }else if(_age < 0){
        _minAgeLabel.text = [NSString stringWithFormat:@"%.1f",_age];
    }else{
        _minAgeLabel.text = @"0";
    }
    _cuAgeLabel.text = [NSString stringWithFormat:@"%.1f",_realAge + _age];
    _titleLabel.text = @"代谢症候群生理年龄";
    _subTitleLabel.text = @" 身份证年龄";
    _subValueLabel.text = [NSString stringWithFormat:@"%.1f",_realAge];
    
}


-(void)setDifAge:(CGFloat)age  realAge:(CGFloat)realAge{

    if(age >0 && age <= 5){
        [self.roundDown setColor:CB_COLOR_0_5];
        bColor = CB_COLOR_0_5;
    }else if(age >5 && age <= 10){
        [self.roundDown setColor:CB_COLOR_5_10];
        bColor = CB_COLOR_5_10;
    }else if(age >10 && age <= 15){
        [self.roundDown setColor:CB_COLOR_10_15];
        bColor = CB_COLOR_10_15;
    }else if(age >=-5 && age < 0){
        [self.roundDown setColor:CB_COLOR_0_F5];
        bColor = CB_COLOR_0_F5;
    }else if(age >=-10 && age < -5){
        [self.roundDown setColor:CB_COLOR_F5_F10];
        bColor = CB_COLOR_F5_F10;
    }else if(age >= -15 && age < -10){
        [self.roundDown setColor:CB_COLOR_F10_F15];
        bColor = CB_COLOR_F10_F15;
    }

    
    if(age > 15){
        age = 15;
    }else if(age < -15){
        age = -15;
    }
    _age = age;
    _realAge = realAge;
    self.roundDown.transform = CGAffineTransformIdentity;
    CGFloat angle = 0;
        angle = M_PI/2 *age/15.0;
    [UIView animateWithDuration:1.0f animations:^{
       self.roundDown.transform = CGAffineTransformRotate(self.roundDown.transform, angle);
        self.downImageView.backgroundColor = [UIColor whiteColor];
        [self bringSubviewToFront:self.downImageView];
        [self bringSubviewToFront:self.pointFlagImageView];
    } completion:nil];
    
    [self setNeedsDisplay];
}


@end
