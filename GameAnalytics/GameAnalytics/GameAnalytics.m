//
//  GameAnalytics.m
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 2/2/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import "GameAnalytics.h"
#import "GARequest.h"
#import "GAAPIHelper.h"

@interface GameAnalytics ()

@property(nonatomic, strong) GARequest *gaRequest;

+(GAAPIHelper *)apiHelper;

@end

@implementation GameAnalytics

static GAAPIHelper *_apiHelper;

+(GAAPIHelper *)apiHelper
{
    return _apiHelper;
}

+ (void)setGameKey:(NSString *)gameKey secretKey:(NSString *)secretKey build:(NSString *)build
{
    _apiHelper = [[GAAPIHelper alloc] initWithHost:nil
                                        apiVersion:nil
                                           gameKey:gameKey
                                         secretKey:secretKey
                                             build:build];
}

+ (void)logUserDataWithParams:(NSDictionary *)params
{
    if([self.apiHelper isReachable])
    {
        NSURLRequest *urlRequest = [self.apiHelper urlRequestUserDataWithParams:params];

        GARequest *request = [[GARequest alloc] initWithURLRequest:urlRequest];
        
        [request start];
    }
}

+ (void)logGameDesignDataEvent:(NSString *)eventID withParams:(NSDictionary *)params
{
    if([self.apiHelper isReachable])
    {
        NSMutableDictionary *mutableParams = [params mutableCopy];
        [mutableParams setObject:eventID forKey:@"event_id"];

        NSURLRequest *urlRequest = [self.apiHelper urlRequestGameDesignDataWithParams:[mutableParams copy]];
        
        GARequest *request = [[GARequest alloc] initWithURLRequest:urlRequest];

        [request start];
    }
}

+ (void)logBusinessDataEvent:(NSString *)eventID withParams:(NSDictionary *)params
{
    if([self.apiHelper isReachable])
    {
        NSMutableDictionary *mutableParams = [params mutableCopy];
        [mutableParams setObject:eventID forKey:@"event_id"];

        NSURLRequest *urlRequest = [self.apiHelper urlRequestBusinessDataWithParams:[mutableParams copy]];
        
        GARequest *request = [[GARequest alloc] initWithURLRequest:urlRequest];

        [request start];
    }
}

+ (void)logQualityAssuranceDataEvent:(NSString *)eventID withParams:(NSDictionary *)params
{
    if([self.apiHelper isReachable])
    {
        NSMutableDictionary *mutableParams = [params mutableCopy];
        [mutableParams setObject:eventID forKey:@"event_id"];
        
        NSURLRequest *urlRequest = [self.apiHelper urlRequestQualityAssuranceDataWithParams:[mutableParams copy]];
        
        GARequest *request = [[GARequest alloc] initWithURLRequest:urlRequest];
        
        [request start];
    }
}

+ (void)updateSessionID
{
    [self.apiHelper updateSessionID];
}


#pragma mark - Custom options

+ (void)setCustomUserID:(NSString *)udid
{
    
}

+ (void)setDebugLogEnabled:(BOOL)value
{
    [GARequest setDebugLogEnabled:value];
}

+ (void)setArchiveDataEnabled:(BOOL)value
{
    [GARequest setArchiveDataEnabled:value];
}

@end
