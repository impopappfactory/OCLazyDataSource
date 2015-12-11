//
//  BCLazyTableViewCellFactory.m
//
//  Created by Ivan Misuno on 09/12/15.
//  Copyright © 2015 Ivan Misuno. All rights reserved.
//

#import "BCLazyTableViewCellFactory.h"

typedef void(^RegisterBlockType)(UITableView * _Nonnull tableView);
typedef UITableViewCell * _Nonnull (^DequeueBlockType)(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath);

@interface BCLazyTableViewCellFactoryImpl : NSObject <BCLazyTableViewCellFactory>
@property (nonatomic, readonly) RegisterBlockType _Nonnull registerBlock;
@property (nonatomic, readonly) DequeueBlockType _Nonnull dequeueBlock;
@end

@implementation BCLazyTableViewCellFactoryImpl

@synthesize configureBlock;
@synthesize estimatedHeightBlock;
@synthesize heightBlock;

- (instancetype _Nullable)initWithRegisterBlock:(RegisterBlockType _Nonnull)registerBlock
                                   dequeueBlock:(DequeueBlockType _Nonnull)dequeueBlock
{
    self = [super init];
    if (self)
    {
        _registerBlock = registerBlock;
        _dequeueBlock = dequeueBlock;
    }
    return self;
}

- (void)registerWithTableView:(UITableView * _Nonnull)tableView
{
    self.registerBlock(tableView);
}
- (UITableViewCell * _Nonnull)dequeueTableViewCell:(UITableView * _Nonnull)tableView forIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    return self.dequeueBlock(tableView, indexPath);
}
@end

id<BCLazyTableViewCellFactory> _Nonnull lazyTableViewCellFactoryWithNib(UINib * _Nonnull nibForCell, NSString * _Nonnull reuseIdentifier)
{
    return [[BCLazyTableViewCellFactoryImpl alloc] initWithRegisterBlock:^(UITableView * _Nonnull tableView) {
        [tableView registerNib:nibForCell forCellReuseIdentifier:reuseIdentifier];
    } dequeueBlock:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    }];
}
id<BCLazyTableViewCellFactory> _Nonnull lazyTableViewCellFactoryWithClass(Class _Nonnull classForCell, NSString * _Nonnull reuseIdentifier)
{
    return [[BCLazyTableViewCellFactoryImpl alloc] initWithRegisterBlock:^(UITableView * _Nonnull tableView) {
        [tableView registerClass:classForCell forCellReuseIdentifier:reuseIdentifier];
    } dequeueBlock:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    }];
}
id<BCLazyTableViewCellFactory> _Nonnull lazyTableViewCellFactoryWithStyle(UITableViewCellStyle cellStyle, NSString * _Nonnull reuseIdentifier)
{
    return [[BCLazyTableViewCellFactoryImpl alloc] initWithRegisterBlock:^(UITableView * _Nonnull tableView) {
    } dequeueBlock:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:reuseIdentifier];
        }
        return cell;
    }];
}
