//
//  TPMAlertController.m
//  TPM
//
//  Created by HongSang bo on 2016. 2. 12..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "TPMAlertController.h"

@interface TPMAlertController ()

@end

@implementation TPMAlertController

+(instancetype)initCustomAlertController:(NSString *)title message:(NSString *) message{
    return [TPMAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
}


+(instancetype)initFollowCancelAlertController{
    return [TPMAlertController alertControllerWithTitle:@"팔로우 취소" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
}

+(instancetype)initInCorrectAccountInfoAlertController{
    return [TPMAlertController alertControllerWithTitle:@"계정정보가 일치하지 않습니다." message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addActionWithYes:(void (^) (void)) blk{
    [self addAction:[UIAlertAction actionWithTitle:@"승인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        blk();
    }]];
}

-(void) addActionWithNo:(void (^) (void)) blk{
    [self addAction:[UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        blk();
    }]];
}

@end
