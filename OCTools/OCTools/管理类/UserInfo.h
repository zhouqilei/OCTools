//
//  UserInfo.h
//
//  Created by xgy on 2017/3/28.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfo : JSONModel

@property (nonatomic, copy)NSString<Optional> * id;

@property (nonatomic, copy)NSString<Optional> * telphone;

@property (nonatomic, copy)NSString<Optional> * username;

@property (nonatomic, copy)NSArray<Optional> * email_verified_at;

@end
