//
//  ImagePageControl.m
//  CTPocketv3
//
//  Created by apple on 13-5-16.
//
//

#import "ImagePageControl.h"
#import "UIView+RoundRect.h"

@implementation ImagePageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        activeImage = [[UIImage imageNamed:@"contract_Greenpos.png"] retain];
        inactiveImage = [[UIImage imageNamed:@"contract_WhitePos.png"] retain];
    }
    return self;
}
-(void)updataDots
{
    for (int i = 0; i<self.subviews.count; i++) {
       UIView *dot = [self.subviews objectAtIndex:i];
        dot.layer.cornerRadius = 4;
//        [dot dwMakeRoundCornerWithRadius:5];
        if (i==self.currentPage) {
//            dot.image = activeImage;
//            [dot removeFromSuperview];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -2, dot.frame.size.width+4, dot.frame.size.height+4)];
            imageView.image = activeImage ;
            [dot addSubview:imageView];
//            dot.backgroundColor = [UIColor colorWithPatternImage:activeImage];
        }else{
//            dot.image = inactiveImage;
//            [dot removeFromSuperview];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -2, dot.frame.size.width+4, dot.frame.size.height+4)];
            imageView.image = inactiveImage ;
            [dot addSubview:imageView];
//            dot.backgroundColor = [UIColor colorWithPatternImage:inactiveImage];
        }
    }
    
}
-(void)dealloc
{
    [activeImage release];
    [inactiveImage release];
    [super dealloc];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updataDots];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
