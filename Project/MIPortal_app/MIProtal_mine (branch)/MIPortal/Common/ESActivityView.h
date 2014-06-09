//
//  ESActivityView.h
//  
//
//  Created by Felix on 11-11-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ESActivityView : UIAlertView {
	UILabel *messageLab;
	UIActivityIndicatorView *aiView;
}
- (id)initWithMessage:(NSString *)message_;
- (void)setTheMessage:(NSString*)message_;
- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
