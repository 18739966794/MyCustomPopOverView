//
//  PopOverContainerView.m
//  MyCustomPopOverView
//
//  Created by WP_YK on 16/5/6.
//  Copyright © 2016年 WP_YK. All rights reserved.
//

#import "PopOverContainerView.h"

@implementation PopOverContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self addObserver:self forKeyPath:@"frame" options:0 context:nil];
    }
    return self;
}

- (CAShapeLayer *)popLayer {
    
    if(_popLayer == nil) {
        
        _popLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:_popLayer];
    }
    return _popLayer;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"frame"]) {
        
        CGRect newFrame = CGRectNull;
        if([object valueForKey:keyPath] != [NSNull null]) {
            
            newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            [self setLayerFrame:newFrame];
        }
    }
}

- (void)setLayerFrame:(CGRect)frame {
    
    float apexOfTriangleX;
    if(_apexOftriangelX == 0) {
        apexOfTriangleX = frame.size.width - 60;
    }
    else {
        apexOfTriangleX = _apexOftriangelX;
    }
    
    if(apexOfTriangleX > frame.size.width - kPopOverLayerCornerRadius) {
        
        apexOfTriangleX = frame.size.width - kPopOverLayerCornerRadius - 0.5 * kTriangleWidth;
    }
    else if(apexOfTriangleX < kPopOverLayerCornerRadius) {
        
        apexOfTriangleX = kPopOverLayerCornerRadius + 0.5 * kTriangleWidth;
    }
    
    // 找到绘制需要的关键点
    CGPoint point0 = CGPointMake(apexOfTriangleX, 0);
    CGPoint point1 = CGPointMake(apexOfTriangleX - 0.5 * kTriangleWidth, kTriangleHeight);
    CGPoint point2 = CGPointMake(kPopOverLayerCornerRadius, kTriangleHeight);
    CGPoint point2_center = CGPointMake(kPopOverLayerCornerRadius, kTriangleHeight + kPopOverLayerCornerRadius);
    
    CGPoint point3 = CGPointMake(0, frame.size.height - kPopOverLayerCornerRadius);
    CGPoint point3_center = CGPointMake(kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
    
    CGPoint point4 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, frame.size.height);
    CGPoint point4_center = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
    
    CGPoint point5 = CGPointMake(frame.size.width, kTriangleHeight + kPopOverLayerCornerRadius);
    CGPoint point5_center = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, kTriangleHeight + kPopOverLayerCornerRadius);
    
    CGPoint point6 = CGPointMake(apexOfTriangleX + 0.5 * kTriangleWidth, kTriangleHeight);
    
    // 开始绘制
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addArcWithCenter:point2_center radius:kPopOverLayerCornerRadius startAngle:3*M_PI_2 endAngle:M_PI clockwise:NO];
    
    [path addLineToPoint:point3];
    [path addArcWithCenter:point3_center radius:kPopOverLayerCornerRadius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point4];
    [path addArcWithCenter:point4_center radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    
    [path addLineToPoint:point5];
    [path addArcWithCenter:point5_center radius:kPopOverLayerCornerRadius startAngle:0 endAngle:3*M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point6];
    [path closePath];
    
    self.popLayer.path = path.CGPath;
    self.popLayer.fillColor = _layerColor?_layerColor.CGColor:[UIColor greenColor].CGColor;
}

- (void)setApexOftriangelX:(CGFloat)apexOftriangelX {
    _apexOftriangelX = apexOftriangelX;
    [self setLayerFrame:self.frame];
}

- (void)setLayerColor:(UIColor *)layerColor {
    _layerColor = layerColor;
    [self setLayerFrame:self.frame];
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"frame"];
}


@end
