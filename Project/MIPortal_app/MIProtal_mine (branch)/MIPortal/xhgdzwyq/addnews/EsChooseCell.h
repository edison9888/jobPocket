//
//  EsChooseCell.h
//  xhgdzwyq
//
//  Created by Hehx on 14-5-23.
//  Copyright (c) 2014年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickDeledate <NSObject>

-(void)clickBtn:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;

@end
@interface EsChooseCell : UITableViewCell

@property(nonatomic, copy)NSString      *title;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, assign)BOOL        isSelected;

@property(nonatomic, copy)id<clickDeledate> delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height;
@end
