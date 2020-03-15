//
//  XXEnum.h
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#ifndef XXEnum_h
#define XXEnum_h

static NSString * const KEY_INITIAL = @"initial";
static NSString * const KEY_GRIDSTYLE = @"gridStyle";
static NSString * const KEY_ANSWER = @"answer";

typedef NS_ENUM(NSUInteger, GridStyle) {
    GridStyleRow,
    GridStyleColumn,
    GridStyleBlock,
};


#endif /* XXEnum_h */
