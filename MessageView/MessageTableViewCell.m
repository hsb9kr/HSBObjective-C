//
//  MessageTableViewCell.m
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MSGContent.h"
#import "MSGLabel.h"

static NSString *BalloonImageName = @"Balloon.png";
static CGFloat ImageViewAddWidth = 50.f;
static CGFloat ImageViewAddHeight = 30.f;
static CGFloat ImageViewAddPostionX = 50.f;
static CGFloat ImageViewAddPostionY = 2.f;

static CGFloat LabelAddWidth = 18.f;
static CGFloat LabelSubMaxWidth = 180.f;
static CGFloat LabelAddHeight = 5.f;
static CGFloat LabelAddPositionX = 40.f;
static CGFloat LabelAddPositionY = 18.f;

static CGFloat ImageLeftCapWith = 28.f;
static CGFloat ImageTopCapHeight = 24.f;

@implementation MessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        _msgLabel = [[MSGLabel alloc] init];
        _imgView = [[UIImageView alloc] init];
        _msgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ];

        [_msgView addSubview:_imgView];
        [_msgView addSubview:_msgLabel];
        
        _msgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_msgView];
        [self setMessageSize];
        return self;
    }
    return nil;
}

-(instancetype)init{
    self = [super init];
    
    if (self) {
        _msgLabel = [[MSGLabel alloc] init];
        _imgView = [[UIImageView alloc] init];
        _msgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ];
        
        [_msgView addSubview:_imgView];
        [_msgView addSubview:_msgLabel];
        
        _msgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_msgView];
        return self;
    }
    return nil;
}

-(void) setOtherContent: (MSGContent *)content{
    _msgLabel.text = content.msg;
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - LabelSubMaxWidth, CGFLOAT_MAX);
    CGSize size = [_msgLabel sizeThatFits:maximumLabelSize];
    UIImage *image = nil;
    
    _imgView.frame = CGRectMake(0, ImageViewAddPostionY, size.width + ImageViewAddWidth, size.height + ImageViewAddHeight);
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    UIImage *tempImage = [UIImage imageNamed:BalloonImageName];
    UIImage *covertImage = [UIImage imageWithCGImage:(CGImageRef)tempImage.CGImage
                                               scale:1.0f
                                         orientation:UIImageOrientationUpMirrored];
    image = [covertImage stretchableImageWithLeftCapWidth:ImageLeftCapWith
                                             topCapHeight:ImageTopCapHeight];
    
    _msgLabel.frame = CGRectMake(18.f, LabelAddPositionY, size.width + LabelAddWidth, size.height + LabelAddHeight);
    _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    _imgView.image = image;
}

-(void) setMineContent: (MSGContent *)content{
    _msgLabel.text = content.msg;
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - LabelSubMaxWidth, CGFLOAT_MAX);
    CGSize size = [_msgLabel sizeThatFits:maximumLabelSize];
//    NSLog(@"height : %f", size.height);
    UIImage *image = nil;
    
    _imgView.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - (size.width + ImageViewAddPostionX), ImageViewAddPostionY, size.width + ImageViewAddWidth, size.height + ImageViewAddHeight);
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    image = [[UIImage imageNamed:BalloonImageName] stretchableImageWithLeftCapWidth:ImageLeftCapWith
                                                                          topCapHeight:ImageTopCapHeight];
    
    _msgLabel.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - (size.width + LabelAddPositionX), LabelAddPositionY, size.width + LabelAddWidth, size.height + LabelAddHeight);

    _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _imgView.image = image;
}

-(void) setMessageSize{
//    NSLog(@"%f", [[UIScreen mainScreen] bounds].size.width);
//    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
//    if (width == 375) {
//        LabelAddPositionX = 100.f;
//    }else if (width == 414){
//        LabelAddPositionX = 140.f;
//    }

    ImageViewAddPostionX = LabelAddPositionX + 10.f;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
