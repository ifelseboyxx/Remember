//
//  RRAuthorizationCell.m
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRAuthorizationCell.h"
#import "RRAuthorization.h"

@interface RRAuthorizationCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *check;

@end

@implementation RRAuthorizationCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
  
}

- (void)setModel:(RRAuthorization *)model {
    
    if (!model) return;
    
    _model = model;
    
    self.lblTitle.text = model.title;
    self.check.image = model.granted ? [UIImage imageNamed:@"choose"] : [UIImage imageNamed:@"unchoose"];
    self.check.backgroundColor = model.granted ? [UIColor whiteColor] : [UIColor blackColor];
    
}

@end
