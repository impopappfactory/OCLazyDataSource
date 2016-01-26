//
//  OCLazyDataSourceBridge.h
//  OCLazyDataSource
//
//  Created by Ivan Misuno on 22/12/15.
//  Copyright © 2015 Ivan Misuno. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCLazySectionBridge;
@protocol OCLazyDataSourceSection;
@protocol OCLazyDataSourceItem;

@protocol OCLazyDataSourceBridge <NSObject>

@property (nonatomic) NSArray<id<OCLazySectionBridge>> * _Nonnull combinedDataSource;

// provide access to internal mapping
- (id<OCLazyDataSourceSection> _Nullable)sectionWithIndex:(NSInteger)sectionIndex;
- (id<OCLazyDataSourceItem> _Nullable)itemForIndexPath:(NSIndexPath * _Nonnull)indexPath;

// optional scrollview delegate handler
- (void)setScrollViewDidScrollHandler:(void(^ _Nullable)(UIScrollView * _Nonnull scrollView))scrollViewDidScrollHandler;

@end
