//
//  BaseResponse.h
//
//  Created by Hussain Mansoor on 6/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *d;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
