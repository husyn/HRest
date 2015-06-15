//
//  NetworkManager.h
//  Communique
//
//  Created by Hussain Mansoor on 7/2/14.
//  Copyright (c) 2014 Foomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestProtocol.h"
#import "BaseBean.h"
#import "Constants.h"

@interface BaseNetworkRequest : NSObject <RequestProtocol> {

    BaseBean * baseRequestBean;
}

@property (nonatomic, weak) id request;

- (instancetype)initWithBaseBean:(BaseBean *) _baseRequestBean;

- (NSString *) url;

- (BOOL) haveGetData;
- (NSDictionary *) getData;

- (BOOL) havePostData;
- (NSDictionary *) postData;

- (BOOL) haveImageData;
- (UIImage*) imageData;

-(BOOL)haveFileData;
- (NSData *)fileData;

/**
 *  requestType is used to identify every request from each othe
 *
 *  @return should be unique integer value for all the requests
 */
- (NSInteger)requestType;

@end
