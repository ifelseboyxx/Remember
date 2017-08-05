//
//  PPAddressModel.h
//  PPAddressBook
//
//  Created by AndyPang on 16/8/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPPersonModel : NSObject

/** 联系人姓名*/
@property (nonatomic, copy) NSString *name;
/** 联系人电话数组,因为一个联系人可能存储多个号码*/
@property (nonatomic, strong) NSMutableArray *mobileArray;
/** 联系人压缩头像*/
@property (nonatomic, strong) UIImage *thumbnailImage;
/** 联系人原始头像*/
@property (nonatomic, strong) UIImage *image;
/** 阳历生日*/
@property (copy, nullable, NS_NONATOMIC_IOSONLY) NSDateComponents *birthday;
/** 农历*/
@property (copy, nullable, NS_NONATOMIC_IOSONLY) NSDateComponents *nonGregorianBirthday;

@end

NS_ASSUME_NONNULL_END
