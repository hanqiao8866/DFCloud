//
//  DXLaunchActivityDescTableViewCell.m
//  DXDesign
//
//  Created by Caxa on 15/8/3.
//  Copyright (c) 2015年 mlf. All rights reserved.
//

#import "DXLaunchActivityDescTableViewCell.h"
#define DESCTEXTMAXLENGTH 20000 //  描述文字限制数目


@implementation DXLaunchActivityDescTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.descTextView = [[DXCustomerTextView alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        self.descTextView.delegate = self;
        self.descTextView.returnKeyType = UIReturnKeyDone;
        self.descTextView.placeholderTextColor = [UIColor colorWithHexString:@"#999999"];
        self.descTextView.placeHolderFont = Font_Size_System(30);
        self.descTextView.textColor = [UIColor colorWithHexString:@"#333333"];
        self.descTextView.font = Font_Size_System(30);
        self.descTextView.layer.masksToBounds = YES;
        self.descTextView.layer.cornerRadius = 3.0;
        self.descTextView.layer.borderWidth = 1.0;
        self.descTextView.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0].CGColor;
        [self.contentView addSubview:self.descTextView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.descTextView.height = self.height-10*2;
    self.descTextView.width = self.width - 10*2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextView delegate
-(void)textViewDidBeginEditing:(DXCustomerTextView *)textView
{
    DXCustomerTextView *tView = (DXCustomerTextView *)textView;
    if ([self.delegate respondsToSelector:@selector(textViewBeginEdit:)]) {
        [self.delegate textViewBeginEdit:tView];
    }
}

-(BOOL)textView:(DXCustomerTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ((textView.text.length + text.length) > DESCTEXTMAXLENGTH) {
        if ([self.delegate respondsToSelector:@selector(textLengthBeyound:)]) {
            [self.delegate textLengthBeyound:DESCTEXTMAXLENGTH];
        }
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;        
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(DXCustomerTextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewEndEdit:)]) {
        [self.delegate textViewEndEdit:textView];
    }
}

-(void)setMovingView:(UITableView *)movingView
{
    _movingView = movingView;
    self.descTextView.kbMoving.kbMovingView = movingView;
    self.descTextView.kbMoving.offset = 0;
}
@end
