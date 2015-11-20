//
//  SGIImageSearchManager.h
//  SampleGoogleImages
//
//  Created by Ivan Misuno on 20-11-2015.
//  Copyright © 2015 Ivan Misuno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGINetworkManager.h"

@class SGIImageSearchResults;

@interface SGIImageSearchManager : SGINetworkManager

// overrides SGINetworkManager's property
@property (nonatomic, readonly) NSURLSessionConfiguration *defaultConfiguration;

- (NSURLSessionTask *)searchWithSearch:(NSString *)search
                            startIndex:(NSInteger)startIndex
                              callback:(void(^)(SGIImageSearchResults *results, NSError *error))callback;

- (NSURLSessionTask *)getImageWithURL:(NSURL *)imageUrl
                             callback:(void(^)(UIImage *image, NSError *error))callback;

@end
