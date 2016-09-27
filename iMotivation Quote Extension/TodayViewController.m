//
//  TodayViewController.m
//  Test6_extension
//
//  Created by Mohammed Abushawish on 2014-11-16.
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController
@synthesize quoteToDisplay, quoteText_Label, quoteAuthor_Label, imageToDisplay;

- (NSImage *)imageResize:(NSImage*)anImage {
    NSImage *sourceImage = anImage;
    //[sourceImage setScalesWhenResized:YES];
    float oldWidth = sourceImage.size.width+20;
    float scaleFactor = self.view.frame.size.width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    NSSize newSize = NSMakeSize (newWidth+20, newHeight);
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid]){
        NSLog(@"Invalid Image");
    } else {
        NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
        [smallImage lockFocus];
        [sourceImage setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositeCopy fraction:1.0];
        [smallImage unlockFocus];
        return smallImage;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [imageToDisplay setImageScaling:NSImageScaleNone];
    imageToDisplay.image = [self imageResize:[NSImage imageNamed:@"XhGsjTN.jpg"]];
    
    
    [self refresh];
}

- (IBAction)refreshButtonClick:(id)sender {
    [self refresh];
}

- (void)refresh {
    Networking *network       = [[Networking alloc] init];
    NSInteger networkResponse = [network retrieveAndParseJson];
    
    //Checking the response of the server after it has been created
    switch (networkResponse) {
        case 0: {
            quoteToDisplay = [network getFetchedQuote];
            NSString *quoteText   = quoteToDisplay.quoteText;
            NSString *quoteAuthor = quoteToDisplay.quoteAuthor;
            
            if ([quoteText length] && [quoteAuthor length] > 0 ) {
                //If the quote has a trailing space at the end, remove it
                if ([quoteText characterAtIndex: [quoteText length] - 1] == ' ') {
                    quoteText = [quoteText substringToIndex:[quoteText length] - 1];
                }
                self.quoteText_Label.stringValue   = [NSString stringWithFormat:
                                                      @"\"%@\"", quoteText];
                self.quoteAuthor_Label.stringValue = [NSString stringWithFormat:
                                                      @"-%@", quoteAuthor];
                NSLog(@"%@", [quoteText_Label string]);
                
//                
//                NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"String" attributes:@{ NSStrokeColorAttributeName : [CIColor blackColor], NSForegroundColorAttributeName : [CIColor blackColor], NSStrokeWidthAttributeName : @-1.0 }];
//                
//                [quoteText_Label setEditable:YES];
//                [quoteText_Label insertText: string];
//                [quoteText_Label setEditable:NO];
            } else {
                [self refresh];
            }
        }
            break;
        case 1: {
            self.quoteText_Label.stringValue = @"Failed to retreive quote from server.";
            self.quoteAuthor_Label.stringValue = @"Error 1.";
        }
            break;
        case 2: {
            self.quoteText_Label.stringValue = @"Failed to connect to server. Make sure you are connected to the internet.";
            self.quoteAuthor_Label.stringValue = @"Error 2.";
        }
            break;
        default:
            self.quoteText_Label.stringValue = @"Unkown error.";
            self.quoteAuthor_Label.stringValue = @"Error Unknown.";
            break;
    }
}

-(NSEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(NSEdgeInsets)defaultMarginInsets {
    return NSEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    [self refresh];
    completionHandler(NCUpdateResultNewData);
}

@end

