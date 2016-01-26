//
//  OCLazyDataSourceBridge.h
//  OCLazyDataSource
//
//  Created by Ivan Misuno on 22/12/15.
//  Copyright © 2015 Ivan Misuno. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCLazySectionBridge;

@protocol OCLazyDataSourceBridge <NSObject>

@property (nonatomic) NSArray<id<OCLazySectionBridge>> * _Nonnull combinedDataSource;

- (void)setScrollViewDidScrollHandler:(void(^ _Nullable)(UIScrollView * _Nonnull scrollView))scrollViewDidScrollHandler;

@end
