//
//  CCAlertView.m
//  
//
//  Created by Harvey Mills on 2/16/11.
//  Copyright 2011 __2BPM Software__. All rights reserved.
//

#import "CCAlertView.h"




@implementation CCAlertView

@synthesize Message, SubMessage, Button1, Button2, procede;

-(id) init  {
	
    if((self == [super init]))
		
    {
		
        self.isTouchEnabled = YES;
        CGSize size = CGSizeMake(287, 139);
        NSString *altImg = @"redalertview.png";
        NSString *rlb = @"redlightButton.png";
        NSString *rdb = @"reddarkButton.png";
        int fnt1 = 18;
        int fnt2 = 14;
        int num1 = 20;
        int num2 = 30;
        int num3 = 50;
        int num4 = 10;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            altImg = @"redalertview-hd.png";
            rlb = @"redlightButton-hd.png";
            rdb = @"reddarkButton-hd.png";
            fnt1 = 36;
            fnt2 = 28;
            num1 = 40;
            num2 = 60;
            num3 = 100;
            num4 = 20;
            size = CGSizeMake(574, 278);
        }
		CCSprite *alertViewSprite = [CCSprite spriteWithFile:altImg];
		[self addChild:alertViewSprite z:-1];
		// 287X139
		
		self.anchorPoint = ccp(0,0);
		
        procede = 0;
		Message = @"Device is in Silent Mode!";
		SubMessage = @"You will be unable to hear words.";
		Button1 = @"OK";
		Button2 = @"Cancel";
		
		CCMenuItemImage *OK = [CCMenuItemImage itemFromNormalImage:rlb selectedImage:rdb target:self selector:@selector(resume:)];
		CCMenuItemImage *Cancel = [CCMenuItemImage itemFromNormalImage:rdb selectedImage:rlb target:self selector:@selector(cancel:)];
		CCMenu *alertMenu = [CCMenu menuWithItems:Cancel, OK, nil];
		//alertMenu.anchorPoint = ccp(0,0);
		[alertMenu alignItemsHorizontallyWithPadding:num4];
		alertMenu.position = ccp(size.width/2, size.height/2-num2);
		[alertViewSprite addChild:alertMenu];
		
		CCLabelTTF *MessageLabel = [CCLabelTTF labelWithString:Message fontName:@"HelveticaNeue-Bold" fontSize:fnt1];
		MessageLabel.position = ccp(alertViewSprite.contentSize.width/2, alertViewSprite.contentSize.height-num1);
		[alertViewSprite addChild:MessageLabel];
		
		CCLabelTTF *SubMessageLabel = [CCLabelTTF labelWithString:SubMessage fontName:@"HelveticaNeue-Bold" fontSize:fnt2];
		SubMessageLabel.position = ccp(alertViewSprite.contentSize.width/2, alertViewSprite.contentSize.height-num3);
		[alertViewSprite addChild:SubMessageLabel];
		
		CCLabelTTF *OKlabel = [CCLabelTTF labelWithString:Button1 fontName:@"HelveticaNeue-Bold" fontSize:fnt1];
		OKlabel.position = ccp(OK.contentSize.width/2, OK.contentSize.height/2);
		[OK addChild:OKlabel];
		
		CCLabelTTF *cancellabel = [CCLabelTTF labelWithString:Button2 fontName:@"HelveticaNeue-Bold" fontSize:fnt1];
		cancellabel.position = ccp(Cancel.contentSize.width/2, Cancel.contentSize.height/2);
		[Cancel addChild:cancellabel];
		
		alertViewSprite.scale = .6;
		alertViewSprite.opacity = 150;
		
		id fadeIn = [CCFadeIn actionWithDuration:0.1];
		id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
		id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
		id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
		id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
		
		[alertViewSprite runAction:pulse];
		
		[[SimpleAudioEngine sharedEngine] playEffect:@"alert.caf"];
		
    }
	
    return self;
}

-(void) resume:(id) sender
{
	//[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0 scene: [Game scene] withColor:ccBLACK]];
    procede = 1;
    CCLOG(@"procede = %d",procede);
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}
-(void) cancel:(id) sender
{
	procede = 2;
    CCLOG(@"procede = %d",procede);
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}



@end
