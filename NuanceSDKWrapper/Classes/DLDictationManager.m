//
//  DLNuanceDictationManager.m
//  MySDKWrapperLibrary
//
//  Created by Krishna Lolage on 13/01/25.
//

#import "DLDictationManager.h"
#import <DragonMedicalSpeechKit/DragonMedicalSpeechKit.h>

@interface DLNuanceDictationManager ()
@property (nonatomic, strong)NUSAVuiController *vuiController;
@end

@implementation DLNuanceDictationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)openSession {
    NSString* partnerGuid = @"30462619-908d-4685-bd64-6389b4d6b368";
    NSString* licenseGuid = @"D2321493-FC8B-4D2B-89F8-E4A7582EF687";
    
    [[NUSASession sharedSession] setServerURL: @"https://sas-qaq1.nuancehce.com"];
    
    [[NUSASession sharedSession] openForApplication:@"testcocoapodapp" partnerGuid:partnerGuid licenseGuid:licenseGuid userId:@"testuser"];
    NSLog(@"Open Session");
}

-(void)initVUI:(UIView *)vw {
    self.vuiController = [[NUSAVuiController alloc] initWithView:vw];
    [_vuiController open];
    NSLog(@"Init VUI");
}

@end
