//
//  ViewController.m
//  MyCustomPopOverView
//
//  Created by WP_YK on 16/5/6.
//  Copyright © 2016年 WP_YK. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomPopOverView.h"

@interface ViewController () <MyCustomPopOverViewDelegate>
{
    NSArray *_titles;
}
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)leftItemAction:(id)sender {
    
    MyCustomPopOverView *customView = [MyCustomPopOverView popOverView];
    customView.contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    customView.containerBackgroundColor = [UIColor blueColor];
    
    [customView showFrom:_leftBtn alignStrle:AlignStyleLeft didShow:^(MyCustomPopOverView *pView) {
        
        NSLog(@"didShowBlock");
    } didDismiss:^(MyCustomPopOverView *pView) {
        
        NSLog(@"didDismissBlock");
    }];
}
- (IBAction)rightItemAction:(id)sender {
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    vc1.view.frame = CGRectMake(0, 0, 200, 200);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    label.center = vc1.view.center;
    label.text = @"viewController view";
    label.numberOfLines = 0;
    [vc1.view addSubview:label];
    
    MyCustomPopOverView *myView = [[MyCustomPopOverView alloc] init];
    myView.contentViewController = vc1;
    [myView showFrom:_rightBtn alignStrle:AlignStyleRight didShow:^(MyCustomPopOverView *pView) {
        NSLog(@"didShowBlock");
    } didDismiss:^(MyCustomPopOverView *pView) {
        NSLog(@"didDismissBlock");
    }];
}
- (IBAction)centerBtnAction:(id)sender {
    
    _titles = @[@"菜单项1",@"菜单项2",@"菜单项3",@"菜单项4"];
    MyCustomPopOverView *view = [[MyCustomPopOverView alloc] initWithBounds:CGRectMake(0, 0, 200, 44*4) titleMenus:_titles];
    view.containerBackgroundColor = [UIColor blueColor];
    view.delegate = self;
    [view showFrom:sender alignStrle:AlignStyleCenter didShow:^(MyCustomPopOverView *pView) {
        NSLog(@"didShowBlock");
    } didDismiss:^(MyCustomPopOverView *pView) {
        NSLog(@"didDismissBlock");
    }];
}
- (IBAction)menuBtnAction:(id)sender {
    
    MyCustomPopOverView *view = [MyCustomPopOverView popOverView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn.bounds = CGRectMake(0, 0, 60, 40);
    view.contentView = btn;
    [view showFrom:sender alignStrle:AlignStyleRight didShow:^(MyCustomPopOverView *pView) {
        NSLog(@"didShowBlock");
    } didDismiss:^(MyCustomPopOverView *pView) {
        NSLog(@"didDismissBlock");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyCustomPopOverViewDelegate
- (void)popOverView:(MyCustomPopOverView *)pView didClickMenuIndex:(NSInteger)index {
    
    NSLog(@"点击了第%d项",(int)index);
}

@end
