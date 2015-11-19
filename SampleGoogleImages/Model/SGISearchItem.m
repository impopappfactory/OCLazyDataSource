//
//  SGISearchItem.m
//  SampleGoogleImages
//
//  Created by Ivan Misuno on 18/11/15.
//  Copyright © 2015 Ivan Misuno. All rights reserved.
//

#import "SGISearchItem.h"
#import "NSDictionary+SGITypedDictionary.h"

@implementation SGISearchItem

+ (long long)newSearchId
{
    NSAssert([NSThread isMainThread], @"Multithreading not supported");
    static long long __prevSearchId;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __prevSearchId = [NSDate timeIntervalSinceReferenceDate] * 1000;
    });
    return __prevSearchId++;
}

+ (instancetype _Nonnull)createSearchItemWithSearch:(NSString * _Nonnull)search
{
    long long newSearchId = [self newSearchId];
    return [[self alloc] initWithSearchId:newSearchId
                                   search:search];
}
- (instancetype _Nonnull)initWithSearchId:(long long)searchId
                                   search:(NSString * _Nonnull)search
{
    self = [super init];
    if (self)
    {
        _searchId = searchId;
        _search = search;
    }
    return self;
}

#pragma mark - SGIJSONConvertibleProtocol conformance

// For an indie project, better use JSONModel or similar 3-rd party object/property mapping framework,
// for an enterprise app, develop one internally,
// for this example just write some boilerplate code
- (NSDictionary * _Nonnull)toJson
{
    return @
    {
        @keypath(self, searchId) : @(self.searchId),
        @keypath(self, search) : self.search
    };
}

+ (id _Nullable)fromJson:(NSDictionary * _Nonnull)json
{
    if (![json isKindOfClass:[NSDictionary class]]) return nil;
    NSNumber *searchId = [json sgi_numberForKey:@keypath([SGISearchItem new], searchId)];
    NSString *search = [json sgi_stringForKey:@keypath([SGISearchItem new], search)];
    if (!searchId
        || !search)
    {
        return nil;
    }
    return [[self alloc] initWithSearchId:[searchId longLongValue]
                                   search:search];
}

+ (NSArray<NSDictionary *> * _Nonnull)toJsonArray:(NSArray<SGISearchItem *> * _Nonnull)itemArray
{
    NSMutableArray<NSDictionary *> *result = [NSMutableArray new];
    [itemArray enumerateObjectsUsingBlock:^(SGISearchItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *json = obj.toJson;
        [result addObject:json];
    }];
    return [result copy];
}
+ (NSArray<SGISearchItem *> * _Nonnull)fromJsonArray:(NSArray<NSDictionary *> * _Nonnull)jsonArray
{
    NSMutableArray<SGISearchItem *> *result = [NSMutableArray new];
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SGISearchItem *item = [SGISearchItem fromJson:obj];
        if (item)
        {
            [result addObject:item];
        }
    }];
    return [result copy];
}

@end
