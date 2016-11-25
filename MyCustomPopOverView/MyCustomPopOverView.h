//
//  MyCustomPopOverView.h
//  MyCustomPopOverView
//
//  Created by WP_YK on 16/5/6.
//  Copyright © 2016年 WP_YK. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 对齐方式 */
typedef NS_ENUM(NSUInteger,AlignStyle) {
    
    AlignStyleCenter,
    AlignStyleLeft,
    AlignStyleRight,
};
@class MyCustomPopOverView;

/** 回调block */
typedef void (^PopOverViewDidShowBlock)(MyCustomPopOverView *pView);
typedef void (^PopOverViewDidDismissBlock)(MyCustomPopOverView *pView);

#define kTriangleHeight 8.0
#define kTriangleWidth 10.0
#define kPopOverLayerCornerRadius 5.0

/** 代理协议 */
@protocol MyCustomPopOverViewDelegate <NSObject>

- (void)popOverView:(MyCustomPopOverView *)pView didClickMenuIndex:(NSInteger)index;

@end


@interface MyCustomPopOverView : UIView

@property (nonatomic, copy) PopOverViewDidShowBlock didShowBlock;

@property (nonatomic, copy) PopOverViewDidDismissBlock didDismissBlock;


@property (nonatomic, weak) id<MyCustomPopOverViewDelegate> delegate;


//视图相关
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, strong) UIColor *containerBackgroundColor;

/** 公共初始化方法 */
+ (instancetype)popOverView;
/** 菜单项类型初始化方法 */
- (instancetype)initWithBounds:(CGRect)bounds titleMenus:(NSArray *)titles;

- (void)showFrom:(UIView *)fromView alignStrle:(AlignStyle)style didShow:(PopOverViewDidShowBlock)showBlock didDismiss:(PopOverViewDidDismissBlock)dismissBlock;

- (void)dismiss;

@end
