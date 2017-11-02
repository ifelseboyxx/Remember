//
//  RRAuthorizationCell.h
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RRAuthorization;

static NSString *const RRAuthorizationCellIdentifier = @"RRAuthorizationCell";

@interface RRAuthorizationCell : UITableViewCell

@property (strong, nonatomic) RRAuthorization *model;

@end
