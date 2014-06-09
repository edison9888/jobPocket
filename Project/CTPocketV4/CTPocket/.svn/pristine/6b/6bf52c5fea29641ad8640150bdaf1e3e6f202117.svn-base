//
//  CTCircularProgressView.m
//  CTPocketV4
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCircularProgressView.h"

@interface CTCircularProgressView()
{
    CGFloat _r;
	CGFloat _g;
	CGFloat _b;
    CGFloat _rMid;
	CGFloat _gMid;
	CGFloat _bMid;
	
	CGFloat _progress;
    int     _circleWidth;
	
	CGRect _outerCircleRect;
	CGRect _innerCircleRect;
}

@end

@implementation CTCircularProgressView

@synthesize progress = _progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.hidden = NO;
		self.alpha = 1.0;
        self.userInteractionEnabled = NO;
		
		// set class variables to default values
        // 红色   浅色值#f06751  深色值#e53c2b
        _r    = 0xf0/255.; _g    = 0x67/255.; _b    = 0x51/255.;
        _rMid = 0xe5/255.; _gMid = 0x3c/255.; _bMid = 0x2b/255.;
		
		_progress = .01;
        
		// find the radius and position for the largest circle that fits in the UIView's frame.
		int radius, x, y;
        // in case the given frame is not square (oblong) we need to check and use the shortest side as our radius.
        radius = MIN(frame.size.width, frame.size.height);
        x = (frame.size.width - radius)/2;
        y = (frame.size.height - radius)/2;
        
		// store the largest circle's position and radius in class variable.
		_outerCircleRect = CGRectMake(x, y, radius, radius);
		// store the inner circles rect, this inner circle will have a radius 10pixels smaller than the outer circle.
		// we want to the inner circle to be in the middle of the outer circle.
        _circleWidth = 15;
		_innerCircleRect = CGRectMake(x+_circleWidth, y+_circleWidth, radius-2*_circleWidth , radius-2*_circleWidth );
		
        self.transform = CGAffineTransformMakeRotation(M_PI*(1+54.5/180.));
    }
    return self;
}

-(void) setProgress:(CGFloat)newProgress
{
    _progress = MIN(1, MAX(0.0, newProgress));
    if (_progress < 0.5)
    {
        // 红色   浅色值#f06751  深色值#e53c2b
        _r    = 0xe5/255.; _g    = 0x3c/255.; _b    = 0x2b/255.;
        _rMid = 0xf0/255.; _gMid = 0x67/255.; _bMid = 0x51/255.;
    }
    else if(_progress < 0.8)
    {
        // 橙色   浅色值#f4b152  深色值#d7873e
        _r    = 0xd7/255.; _g    = 0x87/255.; _b    = 0x3e/255.;
        _rMid = 0xf4/255.; _gMid = 0xb1/255.; _bMid = 0x52/255.;
    }
    else if(_progress <= 1)
    {
        // 绿色   浅色值#6fc537  深色值#4aa721
        _r    = 0x4a/255.; _g    = 0xa7/255.; _b    = 0x21/255.;
        _rMid = 0x6f/255.; _gMid = 0xc5/255.; _bMid = 0x37/255.;
    }
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
    
    // get the drawing canvas (CGContext):
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // save the context's previous state:
    CGContextSaveGState(context);
    
    // our custom drawing code will go here:
    
    // Draw the gray background for our progress view:
    
    // gradient properties:
    CGGradientRef myGradient;
    // You need tell Quartz your colour space (how you define colours), there are many colour spaces: RGBA, black&white...
    CGColorSpaceRef myColorspace;
    // the number of different colours
    size_t num_locations = 3;
    // the location of each colour change, these are between 0 and 1, zero is the first circle and 1 is the end circle, so 0.5 is in the middle.
    CGFloat locations[3] = { 0.0, 0.5 ,1.0 };
    // this is the colour components array, because we are using an RGBA system each colour has four components (four numbers associated with it).
    myColorspace = CGColorSpaceCreateDeviceRGB();
    
    // gradient start and end points
    CGPoint myStartPoint, myEndPoint;
    CGFloat myStartRadius, myEndRadius;
    
    // Draw the progress:
    CGFloat startAngle = -M_PI/2;
    CGFloat endAngle = startAngle + _progress*M_PI*250.5/180.;
    // First clip the drawing area:
    // save the context before clipping
    CGContextSaveGState(context);
    CGContextMoveToPoint(context,
                         _outerCircleRect.origin.x + _outerCircleRect.size.width/2, // move to the top center of the outer circle
                         _outerCircleRect.origin.y ); // the Y is one more because we want to draw inside the bigger circles.
    // add an arc relative to _progress
    CGContextAddArc(context,
                    _outerCircleRect.origin.x + _outerCircleRect.size.width/2,
                    _outerCircleRect.origin.y + _outerCircleRect.size.height/2,
                    _outerCircleRect.size.width/2,
                    startAngle,
                    endAngle, 0);
    CGContextAddArc(context,
                    _outerCircleRect.origin.x + _outerCircleRect.size.width/2,
                    _outerCircleRect.origin.y + _outerCircleRect.size.height/2,
                    _outerCircleRect.size.width/2 - _circleWidth,
                    endAngle,
                    startAngle, 1);
    // use clode path to connect the last point in the path with the first point (to create a closed path)
    CGContextClosePath(context);
    // clip to the path stored in context
    CGContextClip(context);
    
    // Progress drawing code comes here:
    
    // f4b152
    // set the gradient colours based on class variables.
    CGFloat components2[12] = {  _r, _g, _b, 1, // Start color
        _rMid , _gMid, _bMid, 1,    // middle color
        _r, _g, _b, 1 }; // End color
    
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components2,locations, num_locations);
    
    myStartPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width/2;
    myStartPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.height/2;
    myEndPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width/2;
    myEndPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.height/2;
    // set the radias for start and endpoints a bit smaller, because we want to draw inside the outer circles.
    myStartRadius = _innerCircleRect.size.width/2;
    myEndRadius = _outerCircleRect.size.width/2;
    
    CGContextDrawRadialGradient(context,
                                myGradient,
                                myStartPoint, myStartRadius, myEndPoint, myEndRadius, 0);
	
    // release myGradient and myColorSpace
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    
    
    // draw circle on the outline to smooth it out.
    
    CGContextSetRGBStrokeColor(context, _r,_g,_b,1);
    
    // draw an ellipse in the provided rectangle
    CGContextAddEllipseInRect(context, _outerCircleRect);
    CGContextStrokePath(context);
    
    CGContextAddEllipseInRect(context, _innerCircleRect);
    CGContextStrokePath(context);
    
    //restore the context and remove the clipping area.
    CGContextRestoreGState(context);
    
    // restore the context's state when we are done with it:
    CGContextRestoreGState(context);
}

@end
