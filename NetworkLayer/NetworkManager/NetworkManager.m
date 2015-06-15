//
//  NetworkFactory.m
//  Communique
//
//  Created by Hussain Mansoor on 7/2/14.
//  Copyright (c) 2014 Foomo. All rights reserved.
//

#import "NetworkManager.h"
#import "FLSingleton.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"
#import "ResponseProtocol.h"

@interface NetworkManager ()

- (void) respondto:(id<ResponseProtocol>)delegate WithError:(NSError *)error requestType:(NSInteger) type;
- (void) respondto:(id<ResponseProtocol>)delegate WithData:(id)data requestType:(NSInteger) type;

@end

#pragma mark - Network Constants
NSString *const kNetworkManagerKey_RequestType                   = @"requestType";
NSString *const kNetworkManagerKey_Delegate                      = @"delegate";

@implementation NetworkManager

_FL_MAKE_SINGLETON(NetworkManager);

- (void) executeRequest:(BaseNetworkRequest *)request withDelegate:(id<ResponseProtocol>)delegate requestType:(NSInteger)requestType {
    
    if (nil == request) {
        [self respondto:delegate WithError:nil requestType:requestType];
    }
//    
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//        [self respondto:delegate WithError:[NSError errorWithDomain:@"local" code:kApp_ErrorInternetNotAvailable userInfo:nil] requestType:requestType];
//        return;
//    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation = nil;
    
    if ([request havePostData]) {
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];

        manager.securityPolicy.allowInvalidCertificates = YES;
        
        operation = [manager POST:[request url] parameters:[request postData]
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self handleSuccess:operation responseObject:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleFailure:operation withError:error];
        }];
    }
    else if ([request haveGetData]) {
        operation = [manager GET:[request url] parameters:[request getData]
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            [self handleSuccess:operation responseObject:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleFailure:operation withError:error];
        }];
    }
    else if ([request haveFileData]) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        operation = [manager POST:[request url] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:[request fileData] name:@"images" fileName:@"video.mp4" mimeType:@"*/*"];
            [formData appendPartWithFileData:UIImagePNGRepresentation([request imageData]) name:@"images" fileName:@"image.png" mimeType:@"*/*"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleSuccess:operation responseObject:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleFailure:operation withError:error];
        }];
    }
    else if ([request haveImageData]) {

        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        operation = [manager POST:[request url] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

            [formData appendPartWithFileData:UIImagePNGRepresentation([request imageData]) name:@"images" fileName:@"image.png" mimeType:@"*/*"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self handleSuccess:operation responseObject:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleFailure:operation withError:error];
        }];
    }
    else {
        operation = [manager GET:[request url] parameters:nil
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             [self handleSuccess:operation responseObject:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleFailure:operation withError:error];
        }];
    }
    operation.userInfo = @{kNetworkManagerKey_RequestType:[NSNumber numberWithInteger:requestType]
                           ,kNetworkManagerKey_Delegate:delegate};
    request.request = operation;
}

- (void) cancelRequest:(BaseNetworkRequest *)request {
    if (nil != request) {
        AFHTTPRequestOperation *operation = request.request;
        [operation cancel];
    }
}

- (void)handleSuccess:(AFHTTPRequestOperation*) operation responseObject:(id)obj {
    if (nil != operation) {
        NSInteger requestType = [[operation.userInfo objectForKey:kNetworkManagerKey_RequestType] integerValue];
        id delegate = [operation.userInfo objectForKey:kNetworkManagerKey_Delegate];
        [self respondto:delegate WithData:obj requestType:requestType];
    }
}

- (void)handleFailure:(AFHTTPRequestOperation*) operation withError:(NSError*)error {
    NSLog(@"Error: %@", error);
    NSInteger requestType = [[operation.userInfo objectForKey:kNetworkManagerKey_RequestType] integerValue];
    id delegate = [operation.userInfo objectForKey:kNetworkManagerKey_Delegate];
    [self respondto:delegate WithError:error requestType:requestType];
}

- (void) respondto:(id<ResponseProtocol>)delegate WithError:(NSError *) error requestType:(NSInteger) type {
    if (nil != delegate && [delegate respondsToSelector:@selector(responseWithError:andRequestType:)]) {
        [delegate responseWithError:error andRequestType:type];
    }
}

- (void) respondto:(id<ResponseProtocol>)delegate WithData:(id)data requestType:(NSInteger) type {
    if (nil != delegate && [delegate respondsToSelector:@selector(successWithData:andRequestType:)]) {
        [delegate successWithData:data andRequestType:type];
    }
}

@end
