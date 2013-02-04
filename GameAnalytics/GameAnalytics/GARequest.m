//
//  GARequest.m
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 2/2/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import "GARequest.h"

@interface GARequest () <NSURLConnectionDataDelegate>

@end

@implementation GARequest
{
    NSURLConnection *urlConnection;
    NSMutableData *connectionMutableData;
}

static NSMutableSet *inProgressRequestsMutableSet;
static dispatch_queue_t inProgressRequestsMutableSetAccessQueue;

static BOOL debugLogEnabled = NO;
static BOOL archiveDataEnabled = NO;

+(void)initialize
{
    if(debugLogEnabled)
    {
        NSLog(@"GA initialize");
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        inProgressRequestsMutableSet = [NSMutableSet set];
        inProgressRequestsMutableSetAccessQueue = dispatch_queue_create("com.inProgressRequestsMutableSetSetAccessQueue", DISPATCH_QUEUE_SERIAL);
    });
}

#pragma mark - Private Instance Methods

-(id)initWithURLRequest:(NSURLRequest *)urlRequest
{
    if (!(self = [super init])) return nil;
    
    _urlRequest = urlRequest;
    _requestStatus = GARequestStatusNotStarted;
    
    return self;
}

-(NSURLConnection *)urlConnectionForURLRequest:(NSURLRequest *)request
{
    return [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - Public Instance Methods

-(void)start
{
    if (self.requestStatus != GARequestStatusNotStarted && debugLogEnabled)
    {
        NSLog(@"Attempt to start existing request. Ignoring.");
    }
    
    _requestStatus = GARequestStatusStarted;
    
    connectionMutableData = [NSMutableData data];

    urlConnection = [self urlConnectionForURLRequest:self.urlRequest];
    [urlConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                             forMode:NSDefaultRunLoopMode];
    
    [urlConnection start];
    
    [GARequest addRequestToInProgressMutableSet:self];
}

-(void)cancel
{
    [urlConnection cancel];
    _requestStatus = GARequestStatusCancelled;
    
    [GARequest removeRequestFromInProgressMutableSet:self];
}

+(void)setDebugLogEnabled:(BOOL)value
{
    debugLogEnabled = value;
}

+(void)setArchiveDataEnabled:(BOOL)value
{
    archiveDataEnabled = value;
}

#pragma mark - Private class methods

+(void)addRequestToInProgressMutableSet:(GARequest *)request
{
    dispatch_sync(inProgressRequestsMutableSetAccessQueue, ^{
        [inProgressRequestsMutableSet addObject:request];
    });
}

+(void)removeRequestFromInProgressMutableSet:(GARequest *)request
{
    dispatch_sync(inProgressRequestsMutableSetAccessQueue, ^{
        if ([inProgressRequestsMutableSet containsObject:request])
        {
            [inProgressRequestsMutableSet removeObject:request];
        }
    });
}

#pragma mark - NSURLConnectionDelegate Methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(debugLogEnabled)
    {
        NSLog(@"GARequest to %@ failed with error: %@", self.urlRequest.URL, error.localizedDescription);
    }

    _requestStatus = GARequestStatusFailed;
    
    [GARequest removeRequestFromInProgressMutableSet:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    if(debugLogEnabled)
    {
        NSLog(@"GA response with statusCode: %d", httpResponse.statusCode);
    }
    
    if (httpResponse.statusCode != 202)//Accepted
    {
        [connection cancel];
        _requestStatus = GARequestStatusFailed;
        
        [GARequest removeRequestFromInProgressMutableSet:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [connectionMutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _requestStatus = GARequestStatusCompleted;
    
    //NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:connectionMutableData options:0 error:nil];
    //NSLog(@"response: %@", responseDictionary);
    
    [GARequest removeRequestFromInProgressMutableSet:self];
}

@end
