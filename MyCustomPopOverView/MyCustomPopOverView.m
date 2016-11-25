//
//  MyCustomPopOverView.m
//  MyCustomPopOverView
//
//  Created by WP_YK on 16/5/6.
//  Copyright © 2016年 WP_YK. All rights reserved.
//

#import "MyCustomPopOverView.h"
#import "PopOverContainerView.h"

@interface MyCustomPopOverView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PopOverContainerView *containerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleMenus;

@end



@implementation MyCustomPopOverView

- (PopOverContainerView *)containerView {
    
    if(_containerView == nil) {
        
        _containerView = [[PopOverContainerView alloc] init];
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (UITableView *)tableView {
    
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (instancetype)initWithBounds:(CGRect)bounds titleMenus:(NSArray *)titles {
    
    if(self = [super initWithFrame:bounds]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.titleMenus = titles;
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds));
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        [self setContentView:self.tableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return self;
}

+ (instancetype)popOverView {
    
    return [[self alloc] init];
}

- (void)setContentView:(UIView *)contentView {
    
    _contentView = contentView;
    
    CGRect contentFrame = contentView.frame;
    
    contentFrame.origin.x = 5;
    contentFrame.origin.y = kTriangleHeight+5;
    contentView.frame = contentFrame;
    
    CGRect temp = self.contentView.frame;
    temp.size.width = CGRectGetMaxX(contentFrame) + 5;
    temp.size.height = CGRectGetMaxY(contentFrame) + 5;
    
    self.containerView.frame = temp;
    [self.containerView addSubview:contentView];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    
    _contentViewController = contentViewController;
    [self setContentView:_contentViewController.view];
}

- (void)setContainerBackgroundColor:(UIColor *)containerBackgroundColor {
    
    _containerBackgroundColor = containerBackgroundColor;
    self.containerView.layerColor = _containerBackgroundColor;
}

- (void)showFrom:(UIView *)fromView alignStrle:(AlignStyle)style didShow:(PopOverViewDidShowBlock)showBlock didDismiss:(PopOverViewDidDismissBlock)dismissBlock {
    
    self.didShowBlock = showBlock;
    self.didDismissBlock = dismissBlock;
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:self];
    
    self.frame = window.bounds;
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:window];
    
    // 改变位置
    CGRect containerViewFrame = self.containerView.frame;
    containerViewFrame.origin.y = CGRectGetMaxY(newFrame) + 5;
    self.containerView.frame = containerViewFrame;
    
    
    switch (style) {
        case AlignStyleCenter:
        {
            CGPoint center = self.containerView.center;
            center.x = CGRectGetMidX(newFrame);
            self.containerView.center = center;
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame)/2;
        }
            break;
        case AlignStyleLeft:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame);
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(fromView.frame)/2;
        }
            break;
        case AlignStyleRight:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame) - (fabs(frame.size.width - newFrame.size.width));
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame) - CGRectGetWidth(fromView.frame)/2;
        }
            break;
        default:
            break;
    }
    
    if(self.didShowBlock) {
        self.didShowBlock(self);
    }
}

- (void)dismiss {
    
    [self removeFromSuperview];
    
    if(self.didDismissBlock) {
        self.didDismissBlock(self);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleMenus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titleMenus[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.delegate respondsToSelector:@selector(popOverView:didClickMenuIndex:)]) {
        [self.delegate popOverView:self didClickMenuIndex:indexPath.row];
    }
}

@end
