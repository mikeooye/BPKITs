//
//  BPSecureAlertView.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPSecureAlertView.h"
#import "BPLine.h"

@interface BPSecureAlertView ()<UITextFieldDelegate>{
    
    IBOutlet UITextField *_codeTextField;
    
    IBOutlet UILabel *_titleLabel;
    IBOutlet UIButton *_closeBtn;
    IBOutlet UILabel *_subTitleLabel;
    IBOutlet UILabel *_detailTextLabel;
    IBOutletCollection(UIImageView) NSArray *_placeHolderViews;
    IBOutlet UIButton *_placeHolderCoverBtn;
}
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;

- (IBAction)toBeginEnterCode:(id)sender;
- (IBAction)toClose:(id)sender;
@end

@implementation BPSecureAlertView

+ (BPSecureAlertView *)secureAlertViewFromNib
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"BPSecureAlertView" owner:self options:nil];
    BPSecureAlertView *aView = [nibViews firstObject];
//    aView.translatesAutoresizingMaskIntoConstraints = NO;
    return aView;
}

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailText:(NSString *)detailText note:(NSString *)note
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 300, 200)]) {
        
        self.title = title;
        self.subTitle = subTitle;
        self.detailText = detailText;
        self.note = note;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [_placeHolderViews enumerateObjectsUsingBlock:^(UIImageView *imgV, NSUInteger idx, BOOL *stop) {
        imgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imgV.layer.borderWidth = 1.0f;
    }];
    
    _titleLabel.text = _title;
    _subTitleLabel.text = _subTitle;
    _detailTextLabel.text = _detailText;
    _codeTextField.text = nil;
    _noteLabel.text = _note;
    [self textFieldEditingChanged:_codeTextField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (BOOL)becomeFirstResponder
{
    [_codeTextField becomeFirstResponder];
    return [super becomeFirstResponder];
}

- (IBAction)toBeginEnterCode:(id)sender {
    
    [_codeTextField becomeFirstResponder];
}

- (IBAction)toClose:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(secureAlertViewDidClickClose:)]) {
        [self.delegate secureAlertViewDidClickClose:self];
    }
}

- (IBAction)textFieldEditingChanged:(UITextField *)tf {
    
//    UIColor *redColorWithAlpha = [[UIColor redColor] colorWithAlphaComponent:tf.text.length / 6.0];
//    
//    [_placeHolderCoverBtn setBackgroundColor:redColorWithAlpha];
    
    [_placeHolderViews enumerateObjectsUsingBlock:^(UIImageView *imgV, NSUInteger idx, BOOL *stop) {
        
        if (idx < tf.text.length) {
            
//            imgV.backgroundColor = [UIColor redColor];
            [imgV setImage:[UIImage imageNamed:@"MyCard_Blackdot"]];
        }else{
            
//            imgV.backgroundColor = [UIColor clearColor];
            [imgV setImage:nil];
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(secureAlertView:didEnterCode:)]) {
        [self.delegate secureAlertView:self didEnterCode:tf.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *willBeText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"text: %@", willBeText);
    if (willBeText.length > 6) {
        return NO;
    }
    return YES;
}

@end
