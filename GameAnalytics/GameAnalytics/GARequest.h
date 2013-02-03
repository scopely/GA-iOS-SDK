//
//  GARequest.h
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 2/2/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    GARequestStatusNotStarted = 0,
    GARequestStatusStarted,
    GARequestStatusCompleted,
    GARequestStatusFailed,
    GARequestStatusCancelled
}GARequestStatus;

@interface GARequest : NSObject

@property (nonatomic, readonly) NSURLRequest *urlRequest;
@property (nonatomic, readonly) GARequestStatus requestStatus;

-(id)initWithURLRequest:(NSURLRequest *)urlRequest;

-(NSURLConnection *)urlConnectionForURLRequest:(NSURLRequest *)request;

-(void)start;

-(void)cancel;

+(void)setDebugLogEnabled:(BOOL)value;
+(void)setArchiveDataEnabled:(BOOL)value;

@end
