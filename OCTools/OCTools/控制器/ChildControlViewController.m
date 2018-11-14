//
//  ChildControlViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import "ChildControlViewController.h"
#import "CustomLabel.h"
#import "CustomTextField.h"
#import "CustomTextView.h"
@interface ChildControlViewController ()
@property (nonatomic, strong)UIScrollView *scrollV;
@end

@implementation ChildControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT)];
    [self.view addSubview:self.scrollV];
    /**实现UILabel边距控制*/
    CustomLabel *label = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"左边距为30的文字";
    label.textColor = [UIColor whiteColor];
    label.textInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [self.scrollV addSubview:label];
    /**实现UITextField起始文字控制*/
    CustomTextField *textF = [[CustomTextField alloc]initWithFrame:CGRectMake(0, label.maxY, UI_SCREEN_WIDTH, 40) text:nil textColor:[UIColor whiteColor] font:nil placeholder:@"左边距为20的文字"];
    textF.backgroundColor = [UIColor greenColor];
    textF.startPoint = CGPointMake(20, 0);
    [self.scrollV addSubview:textF];
    /**实现UITextView占位*/
    CustomTextView *textV = [[CustomTextView alloc]initWithFrame:CGRectMake(0, textF.maxY, UI_SCREEN_WIDTH, 80) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] placeholder:@"左边距为30的文字"];
    textV.backgroundColor = [UIColor blueColor];
    textV.textContainerInset = UIEdgeInsetsMake(0, 25, 0, 0);
    [self.scrollV addSubview:textV];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
