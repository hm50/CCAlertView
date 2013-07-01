//
//  CCAlertView.h
//  grubbles
//
//  Created by Harvey Mills on 2/16/11.
//  Copyright 2011 __2BPM Software__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface CCAlertView : CCLayer {
	NSString *Message;
	NSString *SubMessage;
	NSString *Button1;
	NSString *Button2;
    int procede;
}

@property (nonatomic) int procede;
@property (nonatomic, retain) NSString *Message;
@property (nonatomic, retain) NSString *SubMessage;
@property (nonatomic, retain) NSString *Button1;
@property (nonatomic, retain) NSString *Button2;


@end
