//
//  SFSegmentedView.h
//  Congress
//
//  Created by Daniel Cloud on 2/1/13.
//  Copyright (c) 2013 Sunlight Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCongressView.h"

@interface SFSegmentedView : SFCongressView

@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIView *contentView;

@end
