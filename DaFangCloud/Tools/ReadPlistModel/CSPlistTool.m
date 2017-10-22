//
//  CSPlistTool.m
//  CSReadPlistDemo
//
//  Created by Shaochong Du on 16/5/12.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import "CSPlistTool.h"
#import "CSPlistModel.h"
#import "CSPlistItemModel.h"

#define kIsUsed @"isUse"
#define kHeaderDes @"headerDes"
#define kFooterDes @"footerDes"
#define kSectionArray @"dataArray"

#define kItemId @"itemId"
#define kItemTitle @"moduleName"
#define kItemIcon @"moduleIcon"
#define kItemRequired @"isRequired"


@implementation CSPlistTool

+ (NSMutableArray *)loadGroupPlistFile:(NSString *)plistName
{
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",plistName]];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:str];
    
    NSMutableArray *outArray = [NSMutableArray array];
    for (NSDictionary *sectionDic in plistArray) {
        NSMutableArray *inArray = [NSMutableArray array];
        BOOL sectionIsUse = [sectionDic[kIsUsed] boolValue];
        if (sectionIsUse) {
            CSPlistModel *plistModel = [[CSPlistModel alloc] init];
            plistModel.itemArray = [NSMutableArray array];
            
            plistModel.isUsed = sectionIsUse;
            plistModel.headerDes = sectionDic[kHeaderDes];
            plistModel.footerDes = sectionDic[kFooterDes];
            
            NSArray *dataArray = sectionDic[kSectionArray];
            for (NSDictionary *itemDic in dataArray) {
                BOOL isUse = [itemDic[kIsUsed] boolValue];
                if (isUse) {
                    CSPlistItemModel *itemModel = [[CSPlistItemModel alloc] init];
                    itemModel.isUsed = isUse;
                    itemModel.itemId = itemDic[kItemId];
                    itemModel.itemTitle = itemDic[kItemTitle];
                    itemModel.itemIcon = itemDic[kItemIcon];
                    itemModel.isRequired = [itemDic[kItemRequired] boolValue];
                    [inArray addObject:itemModel];
                }
            }
            plistModel.itemArray = inArray;
            [outArray addObject:plistModel];
        }
    }
    return outArray;
}

+ (NSMutableArray *)loadItemPlistFile:(NSString *)plistName
{
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",plistName]];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:str];
    
    NSMutableArray *outArray = [NSMutableArray array];
    for (NSDictionary *itemDic in plistArray) {
        BOOL sectionIsUse = [itemDic[kIsUsed] boolValue];
        if (sectionIsUse) {
            CSPlistItemModel *itemModel = [[CSPlistItemModel alloc] init];
            itemModel.isUsed = sectionIsUse;
            itemModel.itemId = itemDic[kItemId];
            itemModel.itemTitle = itemDic[kItemTitle];
            itemModel.itemIcon = itemDic[kItemIcon];
            [outArray addObject:itemModel];
        }
    }
    return outArray;
}

+ (NSMutableArray *)loadSimplePlistFile:(NSString *)plistName {
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",plistName]];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:str];

    NSMutableArray *outArray = [NSMutableArray array];
    for (NSDictionary *itemDic in plistArray) {
        CSPlistItemModel *itemModel = [[CSPlistItemModel alloc] init];
        itemModel.itemId = itemDic[kItemId];
        itemModel.itemTitle = itemDic[kItemTitle];
        [outArray addObject:itemModel];
    }
    return outArray;

}


@end
