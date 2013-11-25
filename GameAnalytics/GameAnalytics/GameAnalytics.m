//
//  GameAnalytics.m
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 2/2/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import "GameAnalytics.h"
#import "GAEngine.h"
#import "GASettings.h"

@interface GameAnalytics ()

@end

@implementation GameAnalytics

static GAEngine *_gaEngine;

+(GAEngine *)gaEngine
{
    return _gaEngine;
}

+ (void)setGameKey:(NSString *)gameKey
         secretKey:(NSString *)secretKey
             build:(NSString *)build
{
    _gaEngine = [[GAEngine alloc] initWithHGameKey:gameKey
                                         secretKey:secretKey
                                             build:build];
}

+ (void)logUserDataWithParams:(NSDictionary *)params
{
    [self.gaEngine logUserDataWithParams:params];
}

+ (void)logUserDataWithGender:(NSString *)gender
                    birthYear:(NSNumber *)birthYear
                  friendCount:(NSNumber *)friendCount
                     platform:(NSString *)platform
                       device:(NSString *)device
                      osMajor:(NSString *)osMajor
                      osMinor:(NSString *)osMinor
                   sdkVersion:(NSString *)sdkVersion
             installPublisher:(NSString *)installPublisher
                  installSite:(NSString *)installSite
              installCampaign:(NSString *)installCampaign
               installAdgroup:(NSString *)installAdgroup
                    installAd:(NSString *)installAd
               installKeyword:(NSString *)installKeyword
                        iosID:(NSString *)iosID
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (gender) {
        params[@"gender"] = gender;
    }
    if (birthYear) {
        params[@"birth_year"] = birthYear;
    }
    if (friendCount) {
        params[@"friend_count"] = friendCount;
    }
    if (platform) {
        params[@"platform"] = platform;
    }
    if (device) {
        params[@"device"] = device;
    }
    if (osMajor) {
        params[@"os_major"] = osMajor;
    }
    if (osMinor) {
        params[@"os_minor"] = osMinor;
    }
    if (sdkVersion) {
        params[@"sdk_version"] = sdkVersion;
    }
    if (installPublisher) {
        params[@"install_publisher"] = installPublisher;
    }
    if (installSite) {
        params[@"install_site"] = installSite;
    }
    if (installCampaign) {
        params[@"install_campaign"] = installCampaign;
    }
    if (installAdgroup) {
        params[@"install_adgroup"] = installAdgroup;
    }
    if (installAd) {
        params[@"install_ad"] = installAd;
    }
    if (installKeyword) {
        params[@"install_keyword"] = installKeyword;
    }
    if (iosID) {
        params[@"ios_id"] = iosID;
    }
    
    [self.gaEngine logUserDataWithParams:params];
}

+ (void)logUserDataWithGender:(NSString *)gender
                    birthYear:(NSNumber *)birthYear
                  friendCount:(NSNumber *)friendCount
{
    [GameAnalytics logUserDataWithGender:gender
                               birthYear:birthYear
                             friendCount:friendCount
                                platform:nil
                                  device:nil
                                 osMajor:nil
                                 osMinor:nil
                              sdkVersion:nil
                        installPublisher:nil
                             installSite:nil
                         installCampaign:nil
                          installAdgroup:nil
                               installAd:nil
                          installKeyword:nil
                                   iosID:nil];
}

+ (void)logGameDesignDataEvent:(NSString *)eventID
                    withParams:(NSDictionary *)params
{
    [self.gaEngine logGameDesignDataEvent:eventID
                               withParams:params];
}

+ (void)logGameDesignDataEvent:(NSString *)eventID
                         value:(NSNumber *)value
                          area:(NSString *)area
                             x:(NSNumber *)x
                             y:(NSNumber *)y
                             z:(NSNumber *)z
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (value) {
        params[@"value"] = value;
    }
    if (area) {
        params[@"area"] = area;
    }
    if (x) {
        params[@"x"] = x;
    }
    if (y) {
        params[@"y"] = y;
    }
    if (z) {
        params[@"z"] = z;
    }
    [self.gaEngine logGameDesignDataEvent:eventID
                               withParams:params];
}

+ (void)logGameDesignDataEvent:(NSString *)eventID
                         value:(NSNumber *)value
{
    [GameAnalytics logGameDesignDataEvent:eventID
                                    value:value
                                     area:nil
                                        x:nil
                                        y:nil
                                        z:nil];
}

+ (void)logGameDesignDataEvent:(NSString *)eventID
{
    [GameAnalytics logGameDesignDataEvent:eventID
                                    value:nil
                                     area:nil
                                        x:nil
                                        y:nil
                                        z:nil];
}


+ (void)logBusinessDataEvent:(NSString *)eventID
                  withParams:(NSDictionary *)params
{
    [self.gaEngine logBusinessDataEvent:eventID
                         currencyString:nil
                           amountNumber:nil
                             withParams:params];
}

+ (void)logBusinessDataEvent:(NSString *)eventID
              currencyString:(NSString *)currency
                amountNumber:(NSNumber *)amount
                        area:(NSString *)area
                           x:(NSNumber *)x
                           y:(NSNumber *)y
                           z:(NSNumber *)z
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (area) {
        params[@"area"] = area;
    }
    if (x) {
        params[@"x"] = x;
    }
    if (y) {
        params[@"y"] = y;
    }
    if (z) {
        params[@"z"] = z;
    }
    [self.gaEngine logBusinessDataEvent:eventID
                         currencyString:currency
                           amountNumber:amount
                             withParams:params];
}

+ (void)logBusinessDataEvent:(NSString *)eventID
              currencyString:(NSString *)currency
                amountNumber:(NSNumber *)amount
                  withParams:(NSDictionary *)params
{
    [GameAnalytics logBusinessDataEvent:eventID
                         currencyString:currency
                           amountNumber:amount
                                   area:nil
                                      x:nil
                                      y:nil
                                      z:nil];
}

+ (void)logQualityAssuranceDataEvent:(NSString *)eventID
                          withParams:(NSDictionary *)params
{
    [self.gaEngine logQualityAssuranceDataEvent:eventID
                                     withParams:params];
}

+ (void)logQualityAssuranceDataEvent:(NSString *)eventID
                             message:(NSString *)message
                                area:(NSString *)area
                                   x:(NSNumber *)x
                                   y:(NSNumber *)y
                                   z:(NSNumber *)z
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (message) {
        params[@"message"] = message;
    }
    if (area) {
        params[@"area"] = area;
    }
    if (x) {
        params[@"x"] = x;
    }
    if (y) {
        params[@"y"] = y;
    }
    if (z) {
        params[@"z"] = z;
    }
    [self.gaEngine logQualityAssuranceDataEvent:eventID
                                     withParams:params];
}

+ (void)logQualityAssuranceDataEvent:(NSString *)eventID
                             message:(NSString *)message
{
    [GameAnalytics logQualityAssuranceDataEvent:eventID
                                        message:message
                                           area:nil
                                              x:nil
                                              y:nil
                                              z:nil];
}

+ (void)updateSessionID
{
    [self.gaEngine updateSessionID];
}


#pragma mark - Custom options

+ (void)setCustomUserID:(NSString *)userID
{
    [GASettings setCustomUserID:userID];
}

+ (NSString *)getUserID
{
    return [self.gaEngine getUserID];
}

+ (void)setDebugLogEnabled:(BOOL)value
{
    [GASettings setDebugLogEnabled:value];
}

+ (void)setArchiveDataEnabled:(BOOL)value
{
    [GASettings setArchiveDataEnabled:value];
}

+ (void)setArchiveDataLimit:(NSInteger)limit
{
    [GASettings setArchiveDataLimit:limit];
}

+ (void)clearEvents
{
    [self.gaEngine clearEvents];
}

+ (void)setBatchRequestsEnabled:(BOOL)value
{
    [GASettings setBatchRequestsEnabled:value];
}

+ (BOOL)sendBatch
{
    return [self.gaEngine sendBatch];
}

+ (void)setSubmitWhileRoaming:(BOOL)value
{
    [GASettings setSubmitWhileRoaming:value];
}

@end
