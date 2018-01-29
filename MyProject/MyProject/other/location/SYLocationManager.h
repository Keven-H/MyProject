//
//  SYLocationManager.h
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZLocationConverter.h"
#import <MapKit/MapKit.h>
#import "SYlocationModel.h"
typedef enum
{
    SYLocationErrorType_none,//定位失败
    SYLocationErrorType_Denied//没权限
}SYLocationErrorType;
typedef void (^currentLocation)(CLLocationCoordinate2D currentPosition) ;
typedef void (^locatedError)(NSString *errorDescription, SYLocationErrorType errorType);
typedef void (^ConvertPosition)(NSString *firstPlace,SYlocationModel *model,CLPlacemark *placeMark) ;
typedef void (^ConvertPositonFailed) (NSString *failedDescription);

@interface SYLocationManager : NSObject

+ (id)Share;
- (void)currentLocationWithSucessCallBack:(currentLocation)currentLocation andLocatedFail:(locatedError)errorBlock;

- (void)ConvertPlaceWithLatitude:(double)latitude lontitude:(double)lontitude andresults:(ConvertPosition)place andFailed:(ConvertPositonFailed)failed;

//获取缓存数据 city
- (void)ConvertPlaceTempCityWithLatitude:(double)latitude lontitude:(double)lontitude andresults:(ConvertPosition)place andFailed:(ConvertPositonFailed)failed;



- (NSMutableArray *)CollectedMyApplicationMapWithStart:(CLLocationCoordinate2D)startcoor end:(CLLocationCoordinate2D )endcoor;

-(void)collectedMyApplicationOpen:(NSDictionary *)dic toName:(NSString *)toname;
@end
