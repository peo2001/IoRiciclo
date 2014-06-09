//
//  SocialLoginViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/05/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FacebookSDK/FacebookSDK.h>
#import "Comuni.h"


@interface SocialLoginViewController : UIViewController<FBLoginViewDelegate>
{
    
}

@property(nonatomic,retain)IBOutlet UIButton* btnIndietro;
@property(nonatomic,retain)IBOutlet UIView* subView;
@property(nonatomic,retain)IBOutlet UILabel* lblDescrizione;

@property(nonatomic,retain) Comuni * comune;


@end
