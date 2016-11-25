//
//  PopOverContainerView.h
//  MyCustomPopOverView
//
//  Created by WP_YK on 16/5/6.
//  Copyright © 2016年 WP_YK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomPopOverView.h"

@interface PopOverContainerView : UIView

@property (nonatomic, strong)CAShapeLayer *popLayer;

@property (nonatomic, assign) CGFloat apexOftriangelX;

@property (nonatomic, strong) UIColor *layerColor;

@end
