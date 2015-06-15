//
//  ResponseProtocol.h
//  Communique
//
//  Created by Hussain Mansoor on 7/13/14.
//  Copyright (c) 2014 Foomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseProtocol <NSObject>

@optional

@required
- (void) responseWithError:(NSError *) error andRequestType:(NSInteger)requestType;
- (void) successWithData:(id) data andRequestType:(NSInteger)requestType;

@end
