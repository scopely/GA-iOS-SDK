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

+ (void)logGameDesignDataEvent:(NSString *)eventID
                    withParams:(NSDictionary *)params
{
    [self.gaEngine logGameDesignDataEvent:eventID withParams:params];
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
                  withParams:(NSDictionary *)params
{
    [self.gaEngine logBusinessDataEvent:eventID
                         currencyString:currency
                           amountNumber:amount
                             withParams:params];
}

+ (void)logQualityAssuranceDataEvent:(NSString *)eventID
                          withParams:(NSDictionary *)params
{
    [self.gaEngine logQualityAssuranceDataEvent:eventID
                                     withParams:params];
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
