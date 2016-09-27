//
//  TodayViewController.h
//  Test6_extension
//
//  Created by Mohammed Abushawish on 2014-11-16.
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Quote.h"
#import "Networking.h"
#import <QuartzCore/QuartzCore.h>

@interface TodayViewController : NSViewController

@property (nonatomic, copy) Quote *quoteToDisplay;
@property (weak) IBOutlet NSTextField *quoteText_Label;
@property (weak) IBOutlet NSTextField *quoteAuthor_Label;
@property (weak) IBOutlet NSButton *refresh_Button;
@property (weak) IBOutlet NSImageView *imageToDisplay;

- (IBAction)refreshButtonClick:(id)sender;
- (NSImage *)imageResize:(NSImage*)anImage;

@end
