//
//  BaseResponse.m
//
//  Created by Hussain Mansoor on 6/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseResponse.h"


NSString *const kBaseResponseD = @"d";


@interface BaseResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseResponse

@synthesize d = _d;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.d = [self objectOrNilForKey:kBaseResponseD fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForD = [NSMutableArray array];
    for (NSObject *subArrayObject in self.d) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForD addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForD addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForD] forKey:kBaseResponseD];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.d = [aDecoder decodeObjectForKey:kBaseResponseD];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_d forKey:kBaseResponseD];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseResponse *copy = [[BaseResponse alloc] init];
    
    if (copy) {

        copy.d = [self.d copyWithZone:zone];
    }
    
    return copy;
}


@end
