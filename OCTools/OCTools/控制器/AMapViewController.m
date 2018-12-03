
//
//  AMapViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/13.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AMapViewController.h"

@interface AMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)AMapSearchAPI *search;

@property (nonatomic, strong)UITextField *searchT;
@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSArray *results;
@end

@implementation AMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT / 2)];
    self.mapView.mapType = MAMapTypeStandard;
    [self.view addSubview:self.mapView];
    //比例尺不显示
    self.mapView.showsScale = NO;
    //指南针不显示
    self.mapView.showsCompass = NO;
    //代理
    self.mapView.delegate = self;
    
    [self showUserLocation];
    [self addPointAnnotationWithCoordinate:CLLocationCoordinate2DMake(30.28,120.15) Title:@"系统大头针" subTitle:@"系统大头针描述"];
    //初始化搜索API
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    //设置搜索
    self.searchT = [[UITextField alloc]initWithFrame:CGRectMake(0, self.mapView.maxY, UI_SCREEN_WIDTH, 40)];
    self.searchT.backgroundColor = [UIColor whiteColor];
    self.searchT.placeholder = @"请输入搜索内容";
    self.searchT.delegate = self;
    [self.view addSubview:self.searchT];
    //搜索结果列表
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchT.maxY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT  - HOME_INDICATOR_HEIGHT - self.searchT.maxY)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    self.results = [NSArray array];
    
}
#pragma mark - 获取当前定位城市
- (void)getLocationCity {
    //地图中心经纬度
    CLLocationCoordinate2D center = self.mapView.region.center;
    //创建反地理编码搜索
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc]init];
    regeo.location = [AMapGeoPoint locationWithLatitude:center.latitude longitude:center.longitude];
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
    
}
#pragma mark - 定位更新
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    [self getLocationCity];
}
#pragma mark - 结束定位
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView {
    [self getLocationCity];
}

#pragma mark - 启动地图定位蓝点
- (void)showUserLocation {
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
//    //自定义定位点
//    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc]init];
//    //定位自定义图片
//    r.image = nil;
//    r.showsHeadingIndicator = YES;
//    [self.mapView updateUserLocationRepresentation:r];
    
}
#pragma mark - 使用大头针
- (void)addPointAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate Title:(NSString *)title subTitle:(NSString *)subTitle {
    MAPointAnnotation *po = [[MAPointAnnotation alloc]init];
    po.coordinate = coordinate;
    po.title = title;
    po.subtitle = subTitle;
    [self.mapView addAnnotation:po];
}

#pragma mark 设置大头针样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        //设置大头针图片
//        annotationView.image = [UIImage imageNamed:@""];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark - 搜索
- (void)searchPOIWithCity:(NSString *)city keywords:(NSString *)keywords types:(NSString *)types{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc]init];
    //关键字
    request.keywords = keywords;
    //相关城市
    request.city = city;
    //相关类型 多类型用 | 分开
    request.types = types;
    //扩展信息
    request.requireExtension = YES;
    
    //限制城市
    request.cityLimit = NO;
    //子POI
    request.requireSubPOIs = YES;
    //发起搜索
    [self.search AMapPOIKeywordsSearch:request];
}
#pragma mark - 搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    self.results = response.pois;
    [self.tab reloadData];
}
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        NSLog(@"当前定位城市为：%@",response.regeocode.addressComponent.city);
    }
}
#pragma mark - 结果列表
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AMapPOI *poi = self.results[indexPath.row];
    cell.textLabel.text = poi.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMapPOI *poi = self.results[indexPath.row];
    NSLog(@"%@",poi.location);
}
#pragma mark - UITextViewDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self searchPOIWithCity:@"杭州" keywords:textField.text types:nil];
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
