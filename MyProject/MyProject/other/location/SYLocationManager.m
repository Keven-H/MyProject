//
//  SYLocationManager.m
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYLocationManager.h"
#import "SYlocationModel.h"
#define kUserLocation_userSavelocation_since 10*60//秒//坐标缓存时间
#define kUserLocation_userSavelocation_since_city 60*60//城市缓存时间

#define kUserLocation_map_apple @"使用苹果自带地图导航"
#define kUserLocation_map_gaode @"使用高德地图导航"
#define kUserLocation_map_baidu @"使用百度地图导航"


@interface SYLocationManager()<CLLocationManagerDelegate>
{
    currentLocation _currentLocationBlock;
    locatedError _locatedErrorBlock;
}
PROPERTY_STRONG CLLocationManager *locationManager;
PROPERTY_ASSIGN CLLocationCoordinate2D currentLocation;
@end
@implementation SYLocationManager
+ (id)Share
{
    static SYLocationManager *MapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MapManager = [[SYLocationManager alloc]init];
    });
    return MapManager;
}
- (id)init
{
    self = [super init];
    if (self)
    {
//        [self setupGeocoder];
    }
    return self;
}

#pragma mark initGeocoder
- (void)setupGeocoder
{
    if (_locationManager) {
        return;
    }
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    [self requestAuthorization];
}
-(void)requestAuthorization
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if (IOS_VERSION_8_0_LATER) {
        [_locationManager requestWhenInUseAuthorization];
    }
#endif

}
#pragma mark initLocationManager
- (void)startLocationManager
{
    [self setupGeocoder];
    [_locationManager startUpdatingLocation];
}

- (void)saveLocation:(CLLocation *)userLocation
{
    SYlocationModel *model =[self locationModel];
    if (!model) {
        model=[[SYlocationModel alloc]init];
    }
    model.lat=userLocation.coordinate.latitude;
    model.lng=userLocation.coordinate.longitude;
    model.time=[NSString  Currentmillisecond ] ;
    [[HCXDateManager  shareDataManager]saveModel:model];
}
-(void)saveLocationCity:(NSString *)city  cityCode:(NSString *)cityCode
{
    SYlocationModel *model=  [self locationModel];
    model.city=city;
    model.cityCode=cityCode;
    model.citiTime=[NSString Currentmillisecond];
    [[HCXDateManager shareDataManager] saveModel:model];
}
-(void)removeOldLocation
{
    [[HCXDateManager shareDataManager]clearModel:[SYlocationModel class]];
}


-(BOOL)userSaveLocation
{
    if ([SYClusterManager locationPermissionisStatus]==ClusterAuthorizationStatusDenied) {
        return NO;
    }

    SYlocationModel *model =[self locationModel];
    if (!model) {
        return NO;;
    }
    NSString *oldTime=model.time;
    if (!SYStringisEmpty(oldTime)&&([[NSString Currentmillisecond]integerValue]-[oldTime integerValue])<kUserLocation_userSavelocation_since) {
        return YES;
    }
    return NO;
}
-(BOOL)useSaveCity
{
    if ([SYClusterManager locationPermissionisStatus]==ClusterAuthorizationStatusDenied) {
        return NO;
    }
    SYlocationModel *model =[self locationModel];
    if (!model) {
        return NO;;
    }
    NSString *oldTime=model.citiTime;
    if (!SYStringisEmpty(oldTime)&&([[NSString Currentmillisecond]integerValue]-[oldTime integerValue])<kUserLocation_userSavelocation_since_city) {
        return YES;
    }
    return NO;
}
-(SYlocationModel *)locationModel
{
    SYlocationModel *model =(SYlocationModel *) [[HCXDateManager  shareDataManager]getModel:[SYlocationModel class]];
    return model;
}
-(CLLocationCoordinate2D)saveLocationCorrdinate
{
    SYlocationModel *model =(SYlocationModel *) [[HCXDateManager  shareDataManager]getModel:[SYlocationModel class]];
    return CLLocationCoordinate2DMake(model.lat, model.lng);
}
-(void)locationSucessWith:(CLLocationCoordinate2D)currentLocation
{
    _currentLocation=currentLocation;
    if (_currentLocationBlock) {
        _currentLocationBlock (currentLocation);
    }
    _currentLocationBlock=nil;
    _locatedErrorBlock=nil;
}
-(void)locationErrorWithWaring:(NSString *)errorStr type:(SYLocationErrorType )errorType
{
    if (_locatedErrorBlock) {
        _locatedErrorBlock (errorStr,errorType);
    }
    _currentLocationBlock=nil;
    _locatedErrorBlock=nil;
}
- (void)currentLocationWithSucessCallBack:(currentLocation)currentLocation andLocatedFail:(locatedError)errorBlock;
{
    _currentLocationBlock = [currentLocation copy];
    _locatedErrorBlock = [errorBlock copy];
    if ([self userSaveLocation]) {
        [self locationSucessWith:[self saveLocationCorrdinate]];
    }else
    {
        [self startLocationManager];
    }
}
- (void)ConvertPlaceWithLatitude:(double)latitude lontitude:(double)lontitude andresults:(ConvertPosition)place andFailed:(ConvertPositonFailed)failed;
{
    CLLocationCoordinate2D position;
    position.latitude = latitude;
    position.longitude = lontitude;
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:position.latitude longitude:position.longitude];
    CLGeocoder *myGecoder = [[CLGeocoder alloc] init];
    [myGecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(!error)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
              [self saveLocationCity:placemark.locality cityCode:placemark.postalCode];
             if (place)
             {
                 place (placemark.locality,[self locationModel],placemark);
             }

         }else
         {
             if (failed) {
                 failed(error.domain);
             }
         }
     }];
    
}
- (void)ConvertPlaceTempCityWithLatitude:(double)latitude lontitude:(double)lontitude andresults:(ConvertPosition)place andFailed:(ConvertPositonFailed)failed
{
    if ([self useSaveCity]) {
        SYlocationModel *model=[self locationModel];
        if (place) {
            place(model.city,model,nil);
        }
    }else
    {
        [self ConvertPlaceWithLatitude:latitude lontitude:lontitude andresults:place andFailed:failed];
    }
}
#pragma mark CLLocationManagerDeleagte
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self requestAuthorization];
            }
            break;
        default:
            break;
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [_locationManager stopUpdatingLocation];
    [self saveLocation:newLocation];
    [self locationSucessWith:[self zzTransGPS:newLocation.coordinate ]];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_locationManager stopUpdatingLocation];
    NSString *errorDescription = nil;
    SYLocationErrorType errorType=SYLocationErrorType_none;
    if ([error domain] == kCLErrorDomain)
    {
        switch ([error code])
        {
            case kCLErrorDenied:
            {
                errorDescription = @"定位失败,请在设置-隐私里开启定位服务";
                errorType=SYLocationErrorType_Denied;
            }
                break;
        }
    }

        if (!errorDescription) {
            errorDescription=@"定位失败";
        }
        [self locationErrorWithWaring:errorDescription type:errorType];
}
-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
//    return yGps;
    return [JZLocationConverter wgs84ToGcj02:yGps];
}











-(NSString *)doubleStringWith:(double)numD
{
    NSNumber *num  = [NSNumber numberWithDouble:numD];
    return [num stringValue];
}

- (NSMutableArray *)CollectedMyApplicationMapWithStart:(CLLocationCoordinate2D)startcoor end:(CLLocationCoordinate2D )endcoor
{
    NSMutableArray *list=[[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D myStartLocation =startcoor;
    CLLocationCoordinate2D myEndLocation = endcoor;
    NSMutableDictionary *appleMapDic = [NSMutableDictionary dictionary];
    [appleMapDic setObject:[NSNumber numberWithDouble:myStartLocation.latitude] forKey:@"start_lat"];
    [appleMapDic setObject:[NSNumber numberWithDouble:myStartLocation.longitude] forKey:@"start_lng"];
    [appleMapDic setObject:[NSNumber numberWithDouble:myEndLocation.latitude] forKey:@"end_lat"];
    [appleMapDic setObject:[NSNumber numberWithDouble:myEndLocation.longitude] forKey:@"end_lng"];
    [appleMapDic setObject:kUserLocation_map_apple forKey:@"mapName"];
    [list addObject:appleMapDic];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        NSString *urlString = [[NSString alloc] initWithFormat:@"iosamap://path?sourceApplication=smallyellow&sid=BGVIS1&did=BGVIS2&dlat=%@&dlon=%@&dev=0&m=0&t=0",[self doubleStringWith:myEndLocation.latitude],[self doubleStringWith:myEndLocation.longitude]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:kUserLocation_map_gaode forKey:@"mapName"];
        [dic setObject:urlString forKey:@"mapUrl"];
        [list addObject:dic];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]])
    {
        myStartLocation=[JZLocationConverter wgs84ToGcj02:myStartLocation];
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=%@,%@&destination=%@,%@&mode=driving&src=smallyellow&coord_type=gcj02",[self doubleStringWith:myStartLocation.latitude],[self doubleStringWith:myStartLocation.longitude],[self doubleStringWith:myEndLocation.latitude],[self doubleStringWith:myEndLocation.longitude]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:kUserLocation_map_baidu forKey:@"mapName"];
        [dic setObject:urlString forKey:@"mapUrl"];
        [list addObject:dic];
    }
    
 
//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"qqmap://map"]]) {
//        NSString *urlString=[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=%f,%f&tocoord=%f,%f&policy=1",myStartLocation.latitude,myStartLocation.longitude,myEndLocation.latitude,myEndLocation.longitude];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"腾讯地图" forKey:@"mapName"];
//        [dic setObject:urlString forKey:@"mapUrl"];
//        [list addObject:dic];
//    }
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
//        NSString *urlString = [[NSString alloc] initWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%f,%f&directionsmode=driving",myEndLocation.latitude,myEndLocation.longitude,myStartLocation.latitude,myStartLocation.longitude];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:@"谷歌地图" forKey:@"mapName"];
//        [dic setObject:urlString forKey:@"mapUrl"];
//        [list addObject:dic];
//    }
    return list;
}
-(void)collectedMyApplicationOpen:(NSDictionary *)dic toName:(NSString *)toname
{
    NSString *mapName=[dic objectForKey:@"mapName"];
    if ([mapName isEqualToString:kUserLocation_map_apple]) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        CLLocationCoordinate2D destinationLocation=CLLocationCoordinate2DMake([[dic objectForKey:@"end_lat"]doubleValue], [[dic objectForKey:@"end_lng"]doubleValue]);
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate: destinationLocation addressDictionary:nil]];
        toLocation.name = toname;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];

    }else
    {
        NSString *urlString = [dic objectForKey:@"mapUrl"];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
@end
