//
//  DLGMemUIViewCell.h
//  memui
//
//  Created by Liu Junqi on 4/24/18.
//  Copyright © 2018 DeviLeo. All rights reserved.
//

#import <UIKit/UIKit.h>



#define DLGMemUIViewCellID      @"DLGMemUIViewCell"
#define DLGMemUIViewCellHeight  32

@protocol DLGMemUIViewCellDelegate <NSObject>

- (void)DLGMemUIViewCellModify:(NSString *)address value:(NSString *)value type:(int)type;
- (void)DLGMemUIViewCellViewMemory:(NSString *)address;

@end

@interface DLGMemUIViewCell : UITableViewCell

@property (nonatomic, weak) id<DLGMemUIViewCellDelegate> delegate;
@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *value;
@property (nonatomic) int Type;
@property (nonatomic) BOOL modifying;

@end
