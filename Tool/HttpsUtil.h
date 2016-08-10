//
//  HttpsUtil.h
//  720
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 zmjkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef NS_ENUM(NSInteger, NetStatus) {
    UseWifi = 100,
    UseNet = 101,
    NoNet = 102
};

@interface HttpsUtil : NSObject

// 网络判断
+ (NetStatus)checkNetworkState;

// 新建异步Get的request
+ (NSMutableURLRequest *)initGetRequest:(NSURL *)url isNeedToken:(BOOL)isNeed;


// 新建异步Post的request
+ (NSMutableURLRequest *)initPostRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed;

// 新建异步Put的request
+ (NSMutableURLRequest *)initPutRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed;

// 新建异步Patch的request
+ (NSMutableURLRequest *)initPatchRequest:(NSURL *)url setParams:(NSDictionary *)params isNeedToken:(BOOL)isNeed;

// 请求成功
+ (void)sendAsynchronousRequest:(NSURLRequest*)request
          addOperationIfSuccess:(void (^)(NSDictionary *success))success
          addOperationIfFailure:(void (^)(int code))failure
            addOperationIfError:  (void (^)(id error))error;

// 根据错误代码获取错误信息
+ (NSString *) getErrorMessage:(int)errorCode;


@end
