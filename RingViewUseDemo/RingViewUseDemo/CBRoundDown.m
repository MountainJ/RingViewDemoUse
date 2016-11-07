//
//  CBRoundDown.m
//  KKOL
//
//  Created by CB on 16/10/24.
//  Copyright © 2016年 KKZX. All rights reserved.
//

#import "CBRoundDown.h"

@interface CBRoundDown()
{
    CGFloat totalWidth;
    CGFloat totalHeight;
    UIColor *bColor;
}

@end

@implementation CBRoundDown

-(void)setColor:(UIColor *)color{
    bColor = color;
    [self setNeedsDisplay];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        totalWidth = self.frame.size.width;
        totalHeight = self.frame.size.height;
        bColor = [UIColor colorWithRed:247/255.0 green:191/255.0 blue:149/255.0 alpha:1];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *beizerPath = [UIBezierPath bezierPath];
    [bColor setFill];
    
    CGFloat pointX = totalWidth/2;
    CGFloat pointY = 0;
    [beizerPath moveToPoint:CGPointMake(pointX, pointY)];
    pointX = 0;
    pointY = totalHeight/5;
    [beizerPath addLineToPoint:CGPointMake(pointX, pointY)];
    pointX = totalWidth;
    pointY = totalHeight/5;
    [beizerPath addLineToPoint:CGPointMake(pointX, pointY)];
    [beizerPath closePath];
    [beizerPath fill];
}



@end
