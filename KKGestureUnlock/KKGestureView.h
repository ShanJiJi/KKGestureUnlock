//
//  KKGestureView.h
//  KKGestureLock
//
//  Created by 珍玮 on 16/4/15.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GetUnlockStringDelegate <NSObject>

-(void)GetGestureUnlockString:(NSString *)string;

@end

@interface KKGestureView : UIView


@property(nonatomic,weak)id <GetUnlockStringDelegate> delegate;


@end
