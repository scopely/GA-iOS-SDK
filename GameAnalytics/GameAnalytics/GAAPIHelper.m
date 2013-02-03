//
//  GAAPIHelper.m
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 2/2/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "GAAPIHelper.h"
#import "OpenUDID.h"
#import "NSString+md5.h"

@interface GAAPIHelper ()

@property (strong, nonatomic) Reachability *reachability;

- (void)commonInit;
-(NSString *)stringForCategory:(GACategory)category;
-(NSMutableDictionary *) mutableDictionaryFromRequiredFieldsWithParams:(NSDictionary *)params;
-(NSURLRequest *)urlRequestForCategory:(GACategory)category
                            withParams:(NSMutableDictionary *)params;
-(NSString *)getGUID;

@end

@implementation GAAPIHelper

- (id)initWithHost:(NSString *)host
        apiVersion:(NSString *)apiVersion
           gameKey:(NSString *)gameKey
         secretKey:(NSString *)secretKey
             build:(NSString *)build
{
    self = [super init];
    if (self) {
        _host = host;
        _apiVersion = apiVersion;
        _gameKey = gameKey;
        _secretKey = secretKey;
        _build = build;
        _userID = [OpenUDID value];
        _sessionID = [self getGUID];
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if (!self.host) {
        _host = @"http://api.gameanalytics.com";
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];

        self.reachability = [Reachability reachabilityWithHostname:self.host];
        [self.reachability startNotifier];
        
    }
    if (!self.apiVersion) {
        _apiVersion = @"1";
    }
}

#pragma mark - Private Methods

-(NSString *)stringForCategory:(GACategory)category
{
    NSString *categoryString;
    
    switch (category) {
        case GACategoryDesign:
            categoryString = @"design";
            break;
        case GACategoryQuality:
            categoryString = @"quality";
            break;
        case GACategoryBusiness:
            categoryString = @"business";
            break;
        case GACategoryUser:
            categoryString = @"user";
            break;
    }

    return categoryString;
}


-(NSMutableDictionary *) mutableDictionaryFromRequiredFieldsWithParams:(NSDictionary *)params
{
    NSMutableDictionary *mutableParams = [params mutableCopy];
    
    //required params:
    [mutableParams setObject:self.userID forKey:@"user_id"];
    [mutableParams setObject:self.sessionID forKey:@"session_id"];
    [mutableParams setObject:self.build forKey:@"build"];
    
    return mutableParams;
}

-(NSURLRequest *)urlRequestForCategory:(GACategory)category
                            withParams:(NSMutableDictionary *)params
{
    NSMutableURLRequest *mutableRequest;
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@/%@", self.host, self.apiVersion, self.gameKey, [self stringForCategory:category]];
    
    //NSLog(@"urlString: %@", urlString);
    
    mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [mutableRequest setHTTPMethod:@"POST"];
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&jsonError];
    if(jsonError) {
        NSLog(@"JSON error: %@", jsonError.localizedDescription);
    }
    
    NSString* jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    jsonDataString = [NSString stringWithFormat:@"[%@]", jsonDataString];
    
    NSString *authorizationHeader = [[NSString stringWithFormat:@"%@%@", jsonDataString, self.secretKey] md5];
    
    [mutableRequest setValue:authorizationHeader forHTTPHeaderField:@"Authorization"];
    
    [mutableRequest setHTTPBody:[jsonDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return mutableRequest;
}


/*
 https://developer.apple.com/library/mac/#documentation/CoreFoundation/Reference/CFUUIDRef/Reference/reference.html
 */
-(NSString *)getGUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    return uuidString;
}


-(void)updateSessionID {
    self.sessionID = [self getGUID];
}


#pragma mark - User data

-(NSURLRequest *)urlRequestUserDataWithParams:(NSDictionary *)params
{
    
    NSMutableDictionary *mutableParams = [self mutableDictionaryFromRequiredFieldsWithParams:params];
    
    return [self urlRequestForCategory:GACategoryUser
                            withParams:[mutableParams copy]];
}


#pragma mark - Game design data

-(NSURLRequest *)urlRequestGameDesignDataWithParams:(NSDictionary *)params
{
    
    NSMutableDictionary *mutableParams = [self mutableDictionaryFromRequiredFieldsWithParams:params];
    
    return [self urlRequestForCategory:GACategoryDesign
                            withParams:[mutableParams copy]];
}

#pragma mark - Business data
-(NSURLRequest *)urlRequestBusinessDataWithParams:(NSDictionary *)params
{
    NSMutableDictionary *mutableParams = [self mutableDictionaryFromRequiredFieldsWithParams:params];

    return [self urlRequestForCategory:GACategoryBusiness
                            withParams:[mutableParams copy]];
    
}

#pragma mark - Quality Assurance data
-(NSURLRequest *)urlRequestQualityAssuranceDataWithParams:(NSDictionary *)params
{
    NSMutableDictionary *mutableParams = [self mutableDictionaryFromRequiredFieldsWithParams:params];
    
    return [self urlRequestForCategory:GACategoryQuality
                            withParams:[mutableParams copy]];
    
}

#pragma mark -

#pragma mark Reachability related

-(void) reachabilityChanged:(NSNotification*) notification
{
    if([self.reachability currentReachabilityStatus] == ReachableViaWiFi)
    {
        NSLog(@"Server [%@] is reachable via Wifi", self.host);
        //[_sharedNetworkQueue setMaxConcurrentOperationCount:6];
        
        //[self checkAndRestoreFrozenOperations];
    }
    else if([self.reachability currentReachabilityStatus] == ReachableViaWWAN)
    {
        NSLog(@"Server [%@] is reachable only via cellular data", self.host);
        //[_sharedNetworkQueue setMaxConcurrentOperationCount:2];
        //[self checkAndRestoreFrozenOperations];
    }
    else if([self.reachability currentReachabilityStatus] == NotReachable)
    {
        NSLog(@"Server [%@] is not reachable", self.host);
        //[self freezeOperations];
    }
    
    if(self.reachabilityChangedHandler) {
        self.reachabilityChangedHandler([self.reachability currentReachabilityStatus]);
    }
}

-(BOOL) isReachable {
    
    return ([self.reachability currentReachabilityStatus] != NotReachable);
}

#pragma mark Memory Mangement

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end

