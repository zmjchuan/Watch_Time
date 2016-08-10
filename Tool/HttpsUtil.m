//
//  HttpsUtil.m
//  720
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 zmjkj. All rights reserved.
//

#import "HttpsUtil.h"

@implementation HttpsUtil


+ (NetStatus)checkNetworkState
{
    NetStatus status = NoNet;
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        status = UseWifi;
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        //status = useWifi;
        //v1.0.0版本useWifi下和useNet下没有本质区别。
        status = UseNet;
    } else { // 没有网络
        status = NoNet;
    }
    return status;
}

#pragma mark -- 请求成功
+ (void)sendAsynchronousRequest:(NSURLRequest*)request
          addOperationIfSuccess:(void (^)(NSDictionary *success))success
          addOperationIfFailure:(void (^)(int code))failure
          addOperationIfError:  (void (^)(id error))error{
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[json objectForKey:@"success"] boolValue]){
                    success(json);
                }
                else{
                  failure([[json objectForKey:@"code"] intValue]);
                }
            });
        }else{
           // 解析失败 没有网络时...
            dispatch_async(dispatch_get_main_queue(), ^{
                error(error);
            });
        }
    }];
}

#pragma mark -- 新建异步Get的request
+ (NSMutableURLRequest *)initGetRequest:(NSURL *)url isNeedToken:(BOOL)isNeed
{
    // 2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"iOS 1.0.1" forHTTPHeaderField:@"Weixue-Verson"];
    if(isNeed){
        [request setValue:[@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"发送的头文件:%@",[request allHTTPHeaderFields]);
    return request;
}

#pragma mark -- 新建异步Post的request
+ (NSMutableURLRequest *)initPostRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed
{
    //请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 请求方式为POST，默认是请求
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"iOS 1.0.1" forHTTPHeaderField:@"Weixue-Verson"];
    if(isNeed){
        [request setValue:[@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];}
    if(params!=nil){
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
    }
    return request;
}

#pragma mark -- 新建异步Put的request
+ (NSMutableURLRequest *)initPutRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"iOS 1.0.1" forHTTPHeaderField:@"Weixue-Verson"];
    
    if(isNeed){
        [request setValue:[@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    }
    if(params!=nil){
        
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
    }
    return request;
}

#pragma mark -- 新建异步Patch的request
+ (NSMutableURLRequest *)initPatchRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed
{
    //请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 请求方式为POST，默认是请求
    [request setHTTPMethod:@"PATCH"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"iOS 1.0.1" forHTTPHeaderField:@"Weixue-Verson"];
    if(isNeed){
        [request setValue:[@"Bearer " stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];}
    if(params!=nil){
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
    }
    return request;
}

#pragma mark -- 根据错误代码获取错误信息
+ (NSString *) getErrorMessage:(int)errorCode{
    NSString *errorMessage;
    switch (errorCode) {
        case 10000:
            errorMessage = @"正常";
            break;
        case 10001:
            errorMessage = @"未授权";
            break;
        case 10002:
            errorMessage = @"请求格式错误";
            break;
        default:
            break;
    }
    return errorMessage;
}

@end
