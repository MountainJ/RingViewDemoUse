//
//  CBRectangleRound.h
//  KKOL
//
//  Created by CB on 16/10/21.
//  Copyright © 2016年 KKZX. All rights reserved.
//   这是一个圆环绘制的效果图

#import <UIKit/UIKit.h>

@interface CBRectangleRound : UIView


-(void)setPoint:(CGFloat)point Title:(NSString *)title;

-(void)setPoint:(CGFloat)point Title:(NSString *)title withAnimation:(BOOL)isAnimated;
@end
