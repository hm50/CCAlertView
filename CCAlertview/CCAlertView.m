//
//  CCAlertView.m
//
//
//  Created by Harvey Mills on 6/30/13.
//  Copyright 2013 Muzago. All rights reserved.
//  www.muzago.com

/*
 Copyright (c) 2013 Muzago
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CCAlertView.h"

@implementation CCAlertView

@synthesize _delegate;



-(id) initWithTitle:(NSString*)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle  {
	
    if(self == [super init])
		
    {
        self._delegate = delegate;
        
        BOOL isIPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;

        CGSize size = CGSizeMake(287, 139);
        NSString *fontStyle = @"HelveticaNeue-Bold";
        NSString *altImg = @"redalertview.png"; if (isIPAD) altImg = @"redalertview-hd.png";
        NSString *rlb = @"redlightButton.png"; if (isIPAD) rlb = @"redlightButton-hd.png";
        NSString *rdb = @"reddarkButton.png"; if (isIPAD) rdb = @"reddarkButton-hd.png";
        float fnt1 = 18, fnt2 = 14;
        float padding = 10; // distance between buttons
        float menuPos = 30; // buttons vertical alignment offset
        float titleHtDif = 20; //height of title label
        float msgHtDif = 50; //height of messgae label
        
		alertViewSprite = [CCSprite spriteWithFile:altImg];
		[self addChild:alertViewSprite z:-1];
		// 287X139
		
		self.anchorPoint = ccp(0,0);
        
        if (title == nil || [title isEqualToString:@""]){
            title = @"Alert Title";
        }
        if (message == nil || [message isEqualToString:@""]){
            message = @"Message Here";
        }
        if (otherButtonTitle == nil || [otherButtonTitle isEqualToString:@""]){
            otherButtonTitle = @"";
        }
        if (cancelButtonTitle == nil || [cancelButtonTitle isEqualToString:@""]){
            cancelButtonTitle = @"OK";
        }
        
        CCMenuItemImage *OK = [CCMenuItemImage itemWithNormalImage:rdb selectedImage:rlb target:self selector:@selector(otherButtonPressed:)];
		CCMenuItemImage *Cancel = [CCMenuItemImage itemWithNormalImage:rdb selectedImage:rlb target:self selector:@selector(cancelButtonPressed:)];
        CCMenu *alertMenu;
        if (otherButtonTitle == nil || [otherButtonTitle isEqualToString:@""]){
            alertMenu = [CCMenu menuWithItems:Cancel, nil];
        }else{
            alertMenu = [CCMenu menuWithItems:OK, Cancel, nil];
            [alertMenu alignItemsHorizontallyWithPadding:padding];
        }
		
		alertMenu.position = ccp(size.width * .5, (size.height * .5) - menuPos);
		[alertViewSprite addChild:alertMenu];
		
		CCLabelTTF *TitleLabel = [CCLabelTTF labelWithString:title fontName:fontStyle fontSize:fnt1];
		TitleLabel.position = ccp(alertViewSprite.contentSize.width * .5, alertViewSprite.contentSize.height-titleHtDif);
		[alertViewSprite addChild:TitleLabel];
    
        CCLabelTTF *MessageLabel = [CCLabelTTF labelWithString:message fontName:fontStyle fontSize:fnt2 dimensions:CGSizeMake(alertViewSprite.contentSize.width - 10, fnt2*3) hAlignment:kCCTextAlignmentCenter vAlignment:kCCVerticalTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap];
		MessageLabel.position = ccp(alertViewSprite.contentSize.width * .5, alertViewSprite.contentSize.height-msgHtDif);
		[alertViewSprite addChild:MessageLabel];
		
		CCLabelTTF *OKlabel = [CCLabelTTF labelWithString:otherButtonTitle fontName:fontStyle fontSize:fnt1];
		OKlabel.position = ccp(OK.contentSize.width * .5, OK.contentSize.height * .5);
		[OK addChild:OKlabel];
		
		CCLabelTTF *cancellabel = [CCLabelTTF labelWithString:cancelButtonTitle fontName:fontStyle fontSize:fnt1];
		cancellabel.position = ccp(Cancel.contentSize.width * .5, Cancel.contentSize.height * .5);
		[Cancel addChild:cancellabel];
		
		alertViewSprite.scale = .6;
		alertViewSprite.opacity = 150;
	}
	
    return self;
}

-(void)showAV {
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.position = ccp(size.width * .5, size.height * .5);
    [scene addChild:self];
    
    id fadeIn = [CCFadeIn actionWithDuration:0.1];
    id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
    id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
    id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
    id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
    
    [alertViewSprite runAction:pulse];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"alert.caf"];
}

-(void) otherButtonPressed:(id) sender {
    [self._delegate CCAlertView:self indexSelected:1];
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}
-(void) cancelButtonPressed:(id) sender {
	[self._delegate CCAlertView:self indexSelected:0];
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}



@end
