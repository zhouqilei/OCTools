//
//  TagsView.h
//  OCTools
//
//  Created by 周 on 2018/11/26.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TagsView;
@protocol TagsViewDelegate <NSObject>
@optional
- (void)tagsView:(TagsView *)view didSelectedTags:(NSArray *)tags;
@end

@interface TagsView : UIView
/**传入标签的名称*/
- (instancetype)initWithFrame:(CGRect)frame tagsArray:(NSArray *)tags;
/**能否多选*/
@property (nonatomic, assign)BOOL canMultipleSelection;
/**代理*/
@property (nonatomic, weak)id<TagsViewDelegate>delegate;
@end

@interface TagBtn : UIButton
+ (TagBtn*)tagBtnWithTagTitle:(NSString *)title;
@end
NS_ASSUME_NONNULL_END
