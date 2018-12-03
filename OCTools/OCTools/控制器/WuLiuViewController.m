//
//  WuLiuViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/23.
//  Copyright © 2018年 周. All rights reserved.
//

#import "WuLiuViewController.h"

@interface WuLiuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)UITableView *tableV;
@end

@implementation WuLiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WuLiuInfo *wuliu1 = [[WuLiuInfo alloc]initWithMessage:@"【温州市】苍南派件员：刘收 13033609872正在为您派件" time:@"2018-11-16 13:45" position:WuLiuPositionTop];
    
    WuLiuInfo *wuliu2 = [[WuLiuInfo alloc]initWithMessage:@"【温州市】快件已到达温州转运中心" time:@"2018-11-16 05:32" position:WuLiuPositionMid];
    WuLiuInfo *wuliu3 = [[WuLiuInfo alloc]initWithMessage:@"【金华市】快件已从金华转运中心发出，准备发往温州转运中心" time:@"2018-11-15 22:21" position:WuLiuPositionBottom];
    self.data = @[wuliu1,wuliu2,wuliu3];
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableV];
}
#pragma mark -UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WuLiuInfo *wuliu = self.data[indexPath.row];
    return [wuliu getCellMessageHeightWithMessageWidth:UI_SCREEN_WIDTH - 50 MessageFont:[UIFont systemFontOfSize:15]] + [wuliu getCellTimeHeightWithWidth:UI_SCREEN_WIDTH - 50 TimeFont:[UIFont systemFontOfSize:15]] + 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WuLiuInfo *wuliu = self.data[indexPath.row];
    WuLiuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[WuLiuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.wuliu = wuliu;
    return cell;
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

@implementation WuLiuInfo
- (instancetype)initWithMessage:(NSString *)message time:(NSString *)time position:(WuLiuPosition)position{
    if ([super init]) {
        _message = message;
        _time = time;
        _position = position;
    }
    return self;
}

- (CGFloat)getCellMessageHeightWithMessageWidth:(CGFloat)width MessageFont:(UIFont *)font {
    //计算物流信息的高度
    CGRect rect = [self.message boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}
- (CGFloat)getCellTimeHeightWithWidth:(CGFloat)width TimeFont:(UIFont *)font {
    //计算时间戳的高度
    CGRect rect = [self.time boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}
@end
//物流信息距左边的尺寸
#define StepSpaceLeft 40.0
//物流信息距上边的尺寸
#define StepSpaceTop 10.0
//物流信息距右边的尺寸
#define StepSpaceRight 10.0
//物流信息距下边的尺寸
#define StepSpaceBottom 10.0
//圆点的半径
#define PointRadius 3.0
//竖线的宽度
#define LineWidth 2.0
@implementation WuLiuCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.messageL = [[UILabel alloc]init];
        self.messageL.font = [UIFont systemFontOfSize:15];
        self.messageL.textColor = [UIColor blackColor];
        self.messageL.numberOfLines = 0;
        self.messageL.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.messageL];
        
        self.timeL = [[UILabel alloc]init];
        self.timeL.font = [UIFont systemFontOfSize:15];
        self.timeL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeL];
        
        self.point = [[UIView alloc]init];
        self.point.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.point];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (void)setWuliu:(WuLiuInfo *)wuliu {
    _wuliu = wuliu;
    
    self.messageL.text = _wuliu.message;
    self.messageL.frame = CGRectMake(StepSpaceLeft, StepSpaceTop, UI_SCREEN_WIDTH - StepSpaceLeft - StepSpaceRight, [_wuliu getCellMessageHeightWithMessageWidth:UI_SCREEN_WIDTH - StepSpaceLeft - StepSpaceRight MessageFont:[UIFont systemFontOfSize:15]]);
    
    self.timeL.text = _wuliu.time;
    self.timeL.frame = CGRectMake(StepSpaceLeft, self.messageL.maxY, UI_SCREEN_WIDTH - StepSpaceLeft - StepSpaceRight, [_wuliu getCellTimeHeightWithWidth:UI_SCREEN_WIDTH - StepSpaceLeft - StepSpaceRight TimeFont:[UIFont systemFontOfSize:15]]);
    
    //把圆点放在中间
    self.point.frame = CGRectMake(StepSpaceLeft / 2 - PointRadius, (StepSpaceTop + self.timeL.maxY) / 2 - PointRadius, 2 * PointRadius, 2 * PointRadius);
    self.point.layer.cornerRadius = PointRadius;
    self.point.layer.masksToBounds = YES;
    //根据物流信息的位置绘制
    switch (_wuliu.position) {
        case WuLiuPositionTop:
        {
            self.line.frame = CGRectMake((StepSpaceLeft - LineWidth) / 2, self.point.maxY, LineWidth, self.point.y);
        }
            break;
        case WuLiuPositionMid:
        {
            self.line.frame = CGRectMake((StepSpaceLeft - LineWidth) / 2, 0, LineWidth, self.timeL.maxY + StepSpaceBottom);
        }
            break;
        case WuLiuPositionBottom:
        {
            self.line.frame = CGRectMake((StepSpaceLeft - LineWidth) / 2, 0, LineWidth, self.point.y);
        }
            break;
        default:
            break;
    }
}
@end
