//
//  GAEngineTests.m
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 25/11/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import "GAEngineTests.h"
#import "GAEngine.h"

@implementation GAEngineTests
{
    GAEngine *gaEngine;
}

- (void)setUp
{
    [super setUp];
    gaEngine = [[GAEngine alloc] initWithHGameKey:kGameKey
                                        secretKey:kSecretKey
                                            build:kBuild];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testUserEventGenderField
{
    NSDictionary *params = [gaEngine mutableDictionaryFromRequiredFieldsWithEventID:nil
                                                                             params:@{@"gender": @"M"}];
    NSURLRequest *urlRequest = [gaEngine urlRequestForCategory:GACategoryUser
                                                    withParams:params];
    STAssertEquals(200, [self responseCodeForRequest:urlRequest], @"User Event with Gender field error");
}

-(void)testGameDesignEventIDField
{
    NSDictionary *params = [gaEngine mutableDictionaryFromRequiredFieldsWithEventID:@"SDKTestEvent"
                                                                             params:nil];
    NSURLRequest *urlRequest = [gaEngine urlRequestForCategory:GACategoryUser
                                                    withParams:params];
    STAssertEquals(200, [self responseCodeForRequest:urlRequest], @"Game Design request failed");
}

-(void)testBusinessData
{
    NSDictionary *params = [gaEngine mutableDictionaryFromRequiredFieldsWithEventID:@"SDKTestEvent"
                                                                             params:@{@"currency": @"LTL",
                                                                                      @"amount": @100}];
    NSURLRequest *urlRequest = [gaEngine urlRequestForCategory:GACategoryBusiness
                                                    withParams:params];
    STAssertEquals(200, [self responseCodeForRequest:urlRequest], @"Business Data request failed");
}

-(void)testBusinessDataWithoutCurrencyField
{
    NSDictionary *params = [gaEngine mutableDictionaryFromRequiredFieldsWithEventID:@"SDKTestEvent"
                                                                             params:nil];
    NSURLRequest *urlRequest = [gaEngine urlRequestForCategory:GACategoryBusiness
                                                    withParams:params];
    STAssertEquals(400, [self responseCodeForRequest:urlRequest], @"Game Design request Without required Currency field failed");
}

@end
