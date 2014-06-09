//
//  ESActivityView.m
//  
//
//  Created by Felix on 11-11-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ESActivityView.h"

#define AlertViewFrame CGRectMake(5, 0, 275, 0)
@implementation ESActivityView
- (void)setTheMessage:(NSString*)message_ {
	messageLab.text = message_;
}

- (void)startAnimating {
	[self show];
}

- (void)stopAnimating {
	[self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:YES];
}

- (BOOL)isAnimating {
	return aiView.isAnimating;
}

#pragma mark -
#pragma mark init
- (id)initWithMessage:(NSString *)message_ {
	self = [super initWithTitle:@"\r\n" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	if (self) {
		// Initialization code.
		//self.clipsToBounds = YES;	
		aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[aiView setHidesWhenStopped:YES];
		[aiView setFrame:CGRectMake(AlertViewFrame.origin.x+(AlertViewFrame.size.width-aiView.frame.size.width)/2, 10, aiView.frame.size.width, aiView.frame.size.height)];
		[self addSubview:aiView];
		[aiView startAnimating];
		
		messageLab = [[UILabel alloc] initWithFrame:CGRectMake(AlertViewFrame.origin.x, aiView.frame.origin.y+aiView.frame.size.height+10, AlertViewFrame.size.width, 40)];
		messageLab.text = message_;
		//messageLab.font = [UIFont systemFontOfSize:20];
		messageLab.textColor = [UIColor whiteColor];
		messageLab.backgroundColor = [UIColor clearColor];
		messageLab.textAlignment = UITextAlignmentCenter;
		messageLab.lineBreakMode = UILineBreakModeWordWrap;
		messageLab.numberOfLines = 0;
		[self addSubview:messageLab];
		
	}
	return self;
}


//- (id)initWithFrame:(CGRect)frame {
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code.
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

//- (void)dealloc {
//	[messageLab release];
//	[aiView release];
//    [super dealloc];
//}


@end
