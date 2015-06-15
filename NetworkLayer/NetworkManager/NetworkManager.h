//
//  NetworkFactory.h
//  Communique
//
//  Created by Hussain Mansoor on 7/2/14.
//  Copyright (c) 2014 Foomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkRequest.h"
#import "ResponseProtocol.h"

#pragma mark - Network Constants
extern NSString *const kNetworkManagerKey_RequestType;
extern NSString *const kNetworkManagerKey_Delegate;

@interface NetworkManager : NSObject

+ (NetworkManager *) sharedInstance;

- (void) executeRequest:(BaseNetworkRequest *)request withDelegate:(id<ResponseProtocol>)delegate requestType:(NSInteger)requestType;
- (void) cancelRequest:(BaseNetworkRequest *)request;

@end
