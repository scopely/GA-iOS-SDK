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
 User data
 Field          Type        Required	Description
 gender         char        No          The gender of the user (M/F).
 birth_year     integer     No          The year the user was born.
 country        string      No          The ISO2 country code the user is playing from.
 state          string      No          The code of the country state the user is playing from.
 friend_count	integer     No          The number of friends in the users network.
 */
-(NSURLRequest *)urlRequestUserDataWithParams:(NSDictionary *)params;


/*!
 In addition, the design, business, and quality categories share these five fields:
 
 Field      Type	Required	Description
 event_id	string	Yes         Identifies the event. This field can be sub-categorized by using ":" notation. For example, an event_id could be: "PickedUpAmmo:Shotgun" (for design), "Purchase:RocketLauncher" (for business), or "Exception:NullReference" (for quality).
 area       string	No          Indicates the area or game level where the event occurred.
 x          float	No          X-position where the event occurred.
 y          float	No          Y-position where the event occurred.
 z          float	No          Z-position where the event occurred.
 */


/*!
 Game design data
 Field	Type	Required	Description
 value	float	No          Numeric value which may be used to enhance the event_id. For example, if the event_id is "PickedUpAmmo:Shotgun", the value could indicate the number of shotgun shells gained.
 */
-(NSURLRequest *)urlRequestGameDesignDataWithParams:(NSDictionary *)params;

/*!
 Business data
 Field      Type        Required	Description
 currency	string      No          A custom string for identifying the currency. For example "USD", "US Dollars" or "GA Dollars". Conversion between different real currencies should be done before sending the amount to the API.
 amount     integer     No          Numeric value which corresponds to the cost of the purchase in the monetary unit divided by 100. For example, if the currency is "USD", the amount should be specified in cents.
 */
-(NSURLRequest *)urlRequestBusinessDataWithParams:(NSDictionary *)params;

/*!
 *  @abstract Quality Assurance data
 Field      Type	Required	Description
 message	string	No          Used to describe the event in further detail. For example, in the case of an exception the message could contain the stack trace.
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
