//
//  UrlZoneViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utenti.h"
#import "Syncronizer.h"

@interface UrlZoneViewController : UIViewController<UIWebViewDelegate>



@property (nonatomic, retain) NSString * urlZone;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIButton *btnChiudi;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView * spinner;

@end
