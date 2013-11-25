//
//  GAIntegrationTests.h
//  GameAnalytics
//
//  Created by Aleksandras Smirnovas on 25/11/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

//#define kGameKey    @"__CHANGE_ME__"
//#define kSecretKey  @"__CHANGE_ME__"
//#define kBuild      @"__CHANGE_ME__"

#define kGameKey    @"39af7ee8e4a1f548e27107037cfd8d11"
#define kSecretKey  @"b2acb06fe166b28fdbd326ddd059d5d8f4a5b6bc"
#define kBuild      @"senTestBuild"

@interface GAIntegrationTests : SenTestCase


-(NSInteger)responseCodeForRequest:(NSURLRequest *)urlRequest;


@end
