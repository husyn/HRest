//
//  NetworkManager.m
//  Communique
//
//  Created by Hussain Mansoor on 7/2/14.
//  Copyright (c) 2014 Foomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkRequest.h"

@implementation BaseNetworkRequest

- (instancetype)initWithBaseBean:(BaseBean *) _baseRequestBean
{
    self = [super init];
    
    if (self) {
        
        baseRequestBean = _baseRequestBean;
        
    }
    return self;
}

- (NSString *) url {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                 userInfo:nil];
}

- (BOOL) haveGetData {
    return NO;
}

- (NSDictionary *) getData {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                          reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                        userInfo:nil];
}

- (BOOL) havePostData {
    return NO;
}

- (NSDictionary *) postData {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                 userInfo:nil];
}

- (BOOL) haveImageData {
    return NO;
}

- (UIImage*) imageData {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                 userInfo:nil];
}

-(BOOL)haveFileData {
    return NO;
}

- (NSData *)fileData {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                 userInfo:nil];
}

- (NSInteger)requestType {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override method '%@' in %@", NSStringFromSelector(_cmd),NSStringFromClass([self class])]
                                 userInfo:nil];
}

@end
