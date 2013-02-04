//
//  GAAPIHelper.h
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 11/1/12.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability/Reachability.h"


typedef enum : NSInteger
{
    GAErrorBadRequest = 400,//Bad Request/Game not found/Data not found
    GAErrorUnauthorized = 401,//Unauthorized/Signature not found in request
    GAErrorForbidden = 403,
    GAErrorGameKeyNotFound = 404,//Game key not found/Method not found
    GAErrorInternalServerError = 500,
    GAErrorNotImplemented = 501
}GAError;

typedef enum : NSInteger
{
    GACategoryDesign = 0,//gameplay
    GACategoryQuality,//quality assurance
    GACategoryBusiness,//transactions
    GACategoryUser//player profiles
}GACategory;

@interface GAAPIHelper : NSObject

- (id)initWithHost:(NSString *)host
        apiVersion:(NSString *)apiVersion
           gameKey:(NSString *)gameKey
         secretKey:(NSString *)secretKey
             build:(NSString *)build;

@property (weak, nonatomic, readonly) NSString *host;
@property (weak, nonatomic, readonly) NSString *apiVersion;
@property (weak, nonatomic, readonly) NSString *gameKey;
@property (weak, nonatomic, readonly) NSString *secretKey;
@property (weak, nonatomic, readonly) NSString *build;

@property (weak, nonatomic, readonly) NSString *userID;
@property (strong, nonatomic) NSString *sessionID;//could be updated during game


-(void)updateSessionID;

/*!
 *  @abstract User data
 *
 *  @param params         NSDictionary
 *
 */
-(NSURLRequest *)urlRequestUserDataWithParams:(NSDictionary *)params;


/*!
 *  @abstract Game design data
 *
 *  @param params         NSDictionary
 *
 */
-(NSURLRequest *)urlRequestGameDesignDataWithParams:(NSDictionary *)params;

/*!
 *  @abstract Business data
 *
 *  @param params         NSDictionary
 *
 */
-(NSURLRequest *)urlRequestBusinessDataWithParams:(NSDictionary *)params;

/*!
 *  @abstract Quality Assurance data
 *
 *  @param params         NSDictionary
 *
 */
-(NSURLRequest *)urlRequestQualityAssuranceDataWithParams:(NSDictionary *)params;


/*!
 *  @abstract Handler that you implement to monitor reachability changes
 *  @property reachabilityChangedHandler
 *
 *  @discussion
 *	The framework calls this handler whenever the reachability of the host changes.
 *  The default implementation freezes the queued operations and stops network activity
 *  You normally don't have to implement this unless you need to show a HUD notifying the user of connectivity loss
 */
@property (copy, nonatomic) void (^reachabilityChangedHandler)(NetworkStatus ns);

/*!
 *  @abstract Checks current reachable status
 *
 *  @discussion
 *	This method is a handy helper that you can use to check for network reachability.
 */
-(BOOL) isReachable;

@end
