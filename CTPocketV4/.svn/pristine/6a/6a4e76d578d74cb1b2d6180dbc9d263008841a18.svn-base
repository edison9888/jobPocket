//
//  ContractPhoneCell.m
//  CTPocketv3
//
//  Created by apple on 13-5-7.
//
//

#import "ContractPhoneCell.h"
#import "UIView+RoundRect.h"
#import "NSDataAdditions.h"
#import "Utils.h"

@interface ContractPhoneCell()
{
    UILabel *_PhoneNamelabel ;
    UILabel *_PhoneRomlable ;
    UILabel *_PhonePricelabel;
//    AsyncImageView *_asyncImg;
    
}

@property (nonatomic, strong)UIImageView *phoneImageView;




@end

@implementation ContractPhoneCell
@synthesize _contractDictionary;
@synthesize userIdentify;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 4S heigh = 180
        // Initialization code
        CGRect rect = self.frame;
        rect.size.height = 103;rect.size.width = 280;
        self.frame = rect;
        
        self.backgroundColor = [UIColor clearColor];
        {
            UIImageView *bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 10)];
            bgview.backgroundColor = [UIColor whiteColor];
            [bgview dwMakeRoundCornerWithRadius:5]; //圆角处理
            bgview.userInteractionEnabled = YES;
            [self addSubview:bgview];
            {
//                UIImageView *PopImageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, bgview.frame.size.width-20, bgview.frame.size.height-20)];
//                PopImageview.backgroundColor = [UIColor clearColor];
//                PopImageview.userInteractionEnabled = YES;
//                [bgview addSubview:PopImageview];
//                int originalX = 0 ;
//                {
//                    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(originalX, 0, 70, bgview.frame.size.height-20)];
//                    PopImageview.userInteractionEnabled = YES;
//                    [PopImageview addSubview:phoneImageView];
//                    self.phoneImageView = phoneImageView ;
//                    originalX = CGRectGetMaxX(_phoneImageView.frame);
//                }
                UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 70, CGRectGetHeight(bgview.frame)-20)];
                phoneImageView.userInteractionEnabled = YES;
                [bgview addSubview:phoneImageView];
                self.phoneImageView = phoneImageView ;
                
                int yOriginal = 0;
                {    
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneImageView.frame) + 5,20,150,40)];
                    lable.font = [UIFont systemFontOfSize:12];
                    lable.text = @"苹果(Apple)Iphone5";
                    lable.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                    lable.textAlignment = UITextAlignmentLeft;
                    lable.numberOfLines = 2;     // 不可少Label属性之一
                    lable.lineBreakMode = UIKeyboardAppearanceDefault;    // 不可少Label属性之二
                    _PhoneNamelabel = lable;
                    [bgview addSubview: lable];
                    yOriginal = CGRectGetMaxY(lable.frame);
                }
                yOriginal += 10;
                {
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneImageView.frame) + 5 , yOriginal-10, 75,12)];
                    lable.font = [UIFont systemFontOfSize:12];
                    lable.text = @"4588";
                    lable.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                    lable.textAlignment = UITextAlignmentCenter;
                    _PhonePricelabel = lable;
                    [bgview addSubview: lable];
                    yOriginal = CGRectGetMaxY(lable.frame);
                }
            }
        }
    }
    return self;
}

//设置信息
-(void)setInfo:(NSMutableDictionary *)phoneInfo
{
    if (phoneInfo && [phoneInfo respondsToSelector:@selector(objectForKey:)]) { //设置默认信息
        NSString *fixedStr = @"价格 : ";
        _contractDictionary = phoneInfo ; //设置属性信息
        id info = (id)[phoneInfo objectForKey:@"Price"];        //读取手机价格
        if(info && [info isKindOfClass:[NSString class]]){
            info = [[fixedStr stringByAppendingString:info]stringByAppendingString:@"元"];
            _PhonePricelabel.text = info;
        }else{
            
        }
        info = [phoneInfo objectForKey:@"Name"];                    //读取手机名称
        if(info && [info isKindOfClass:[NSString class]]){
//            CGRect rect = _PhoneNamelabel.frame;
//            CGSize labelSize = [info sizeWithFont:[UIFont boldSystemFontOfSize:12]
//                                constrainedToSize:CGSizeMake(150, 40)
//                                    lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符
//            rect.size = labelSize;
//            _PhoneNamelabel.frame = rect;
            _PhoneNamelabel.text = info;
            [_PhoneNamelabel sizeToFit];
            
        }else{
            
        }
        NSURL *url = [NSURL URLWithString:[phoneInfo objectForKey:@"IconUrl"]];
        [self.phoneImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loadingImage1.png"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
