//
//  BaiduMapViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/14.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaiduMapViewController.h"
@interface BaiduMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate>
/**地图 需引入头文件（<BaiduMapAPI_Map/BMKMapView.h>）*/
@property (nonatomic, strong)BMKMapView *mapView;
/**用户定位*/
@property (nonatomic, strong)BMKUserLocation *userLocation;
/**定位服务 需引入头文件（<BaiduMapAPI_Location/BMKLocationComponent.h>）*/
@property (nonatomic, strong)BMKLocationService *locationService;
/**POI搜索服务 需引入头文件（<BaiduMapAPI_Search/BMKPoiSearch.h>）*/
@property (nonatomic, strong)BMKPoiSearch *search;
/**地理搜索 需要引入头文件<BaiduMapAPI_Search/BMKGeocodeSearch.h>*/
@property (nonatomic, strong)BMKGeoCodeSearch *geoSearch;
/**搜索输入框*/
@property (nonatomic, strong)UITextField *textF;
@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSArray *results;
@end

@implementation BaiduMapViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locationService.delegate = nil;
    _search.delegate = nil;
    _geoSearch.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT / 2)];
    self.mapView.mapType = BMKMapTypeStandard;
    [self.view addSubview:self.mapView];
    
    //开始定位
    [self startLocation];
    
    //设置搜索输入框
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(0, self.mapView.maxY - HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, 40)];
    self.textF.backgroundColor = [UIColor whiteColor];
    self.textF.placeholder = @"请输入搜索内容";
    self.textF.delegate = self;
    [self.view addSubview:self.textF];
    //搜索结果列表
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, self.textF.maxY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT - self.textF.maxY)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    self.results = [NSArray array];
    //初始化搜索服务
    _search = [[BMKPoiSearch alloc]init];
    _search.delegate = self;
    //初始化地理搜索
    _geoSearch = [[BMKGeoCodeSearch alloc]init];
    _geoSearch.delegate = self;
    
}
#pragma mark - 添加大头针
- (void)addPointAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate Title:(NSString *)title subTitle:(NSString *)subTitle {
    BMKPointAnnotation *an = [[BMKPointAnnotation alloc]init];
    an.coordinate = coordinate;
    an.title = title;
    an.subtitle = subTitle;
    [_mapView addAnnotation:an];
}
#pragma mark - 大头针回调
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        BMKPinAnnotationView*annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        annotationView.canShowCallout= YES;      //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop=YES;         //设置标注动画显示，默认为NO
        annotationView.draggable = YES;          //设置标注可以拖动，默认为NO
        return annotationView;
    }
    return nil;
}
#pragma mark - 地图加载完毕
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self addPointAnnotationWithCoordinate:CLLocationCoordinate2DMake(30.28,120.15) Title:@"系统大头针" subTitle:@"系统大头针描述"];
}
#pragma mark - 获取定位城市
- (void)getLocationCity {
    BMKReverseGeoCodeSearchOption *op = [[BMKReverseGeoCodeSearchOption alloc]init];
    op.location = self.userLocation.location.coordinate;
    [self.geoSearch reverseGeoCode:op];
    
}
#pragma mark - 获取反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
       // 在此处理正常结果
        NSLog(@"%@",result.addressDetail.city);
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
#pragma mark - 开启定位服务
- (void)startLocation {
    //关闭定位图
    self.mapView.showsUserLocation = NO;
    //开启定位服务
    self.locationService = [[BMKLocationService alloc]init];
    [self.locationService startUserLocationService];
    //显示定位图
    self.mapView.showsUserLocation = YES;
    //设置定位状态
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self startSearchWithCity:@"杭州市" keywords:textField.text];
}
#pragma mark - 发起关键字搜索
- (void)startSearchWithCity:(NSString *)city keywords:(NSString *)keywords {
    BMKPOICitySearchOption *option = [[BMKPOICitySearchOption alloc]init];
    option.city = city;
    option.keyword = keywords;
    [self.search poiSearchInCity:option];
}
#pragma mark - 关键字搜索结果回调
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.results = poiResult.poiInfoList;
        [self.tab reloadData];
    }
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}
#pragma mark - poi搜索结果列表
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.results.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    BMKPoiInfo *poi = self.results[indexPath.row];
    cell.textLabel.text = poi.name;
    return cell;
}

#pragma mark - 地图将要启动定位
- (void)willStartLocatingUser {
    
}
#pragma mark - 用户定位方向变更回调
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    if (!userLocation) {
        return;
    }
    self.userLocation = userLocation;
    [self.mapView updateLocationData:userLocation];
    [self getLocationCity];
}
#pragma mark - 用户位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    if (!userLocation) {
        return;
    }
    self.userLocation = userLocation;
    [self.mapView updateLocationData:userLocation];
    [self getLocationCity];
}
#pragma mark - 定位失败
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"%@",error.description);
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
