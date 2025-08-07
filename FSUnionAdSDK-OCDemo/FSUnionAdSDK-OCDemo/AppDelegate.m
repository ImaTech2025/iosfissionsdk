//
//  AppDelegate.m
//  FSUnionAdSDK-OCDemo
//
//  Created by 吴启晗 on 2024/9/15.
//

#import "AppDelegate.h"

#ifdef FSUnionAdSDK_WK_OCDemo
#import <FSUnionAdSDK_WK/FSUnionAdSDK_WK-Swift.h>
#else
#import <FSUnionAdSDK/FSUnionAdSDK-Swift.h>
#endif

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

#if __has_include(<FSAdEnvironment/FSAdEnvironment.h>)
#import <FSAdEnvironment/FSAdEnvironment.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // initialize AD SDK
    [self setupFSAdSDK];
    
    // fetch IDFA
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestIDFATracking];
    });
    
    return YES;
}

- (void)setupFSAdSDK {
    [FSAdSDKManager logEnable:YES];
    
    FSAdSDKConfiguration *configuration = FSAdSDKConfiguration.configuration;
    // TODO: to replace
    configuration.appID = @"xxxxx";
    configuration.appToken = @"xxxxx";
    /*
     集成方是否支持微信 api，以及小程序跳转
     默认为 NO，当YES时，飞梭服务端可能会下发小程序跳转
     */
    configuration.supportWXApi = NO;
    
    [FSAdSDKManager startWithCompletionHandler:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"检查是否正确传入appID");
        }
    }];
}

- (void)requestIDFATracking {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            NSLog(@"%@",idfa);
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
