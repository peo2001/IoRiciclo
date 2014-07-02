//
//  SocialLoginViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/05/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "SocialLoginViewController.h"
#import "MyApplicationSingleton.h"

@interface SocialLoginViewController ()


@property (strong, nonatomic) IBOutlet FBLoginView *loginView;


@end

@implementation SocialLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Facebook
    
    _loginView =  [[FBLoginView alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES ];
    
    
    self.loginView.readPermissions = @[@"public_profile", @"email"];
    
    self.loginView.loginBehavior=FBSessionLoginBehaviorForcingWebView;
    
    _loginView.delegate = self;
    
   
    
    [self.subView addSubview:_loginView];
     _loginView.center = [_loginView.superview convertPoint:self.subView.center fromView:self.subView];
    
    //fine facebook
    
    [_btnIndietro addTarget:self
               action:@selector(goToMain)forControlEvents:UIControlEventTouchDown];
    
    if (_comune != nil)
    {
        _lblDescrizione.text = [NSString stringWithFormat:@"Il Comune di %@ non è attualmente gestito in Io Riciclo. Se hai a cuore il tuo ambiente e buoi partecipare a diffondere il calendario della raccolta differenziata del tuo Comune, iscriviti ad Io Riciclo tramite Facebook e diventa tu il gestore del Comune di %@", _comune.comune, _comune.comune];
    }
    
    if ([[[MyApplicationSingleton sharedInstance] utente] IsUserLogged ])
    {
        _lblDescrizione.text = [NSString stringWithFormat:@"Ciao %@ \n sei un membro della Community di Io Riciclo.", [[[MyApplicationSingleton sharedInstance] utente]nomeutente]];
    }
    
}

-(void) goToMain

{
    [self performSegueWithIdentifier: @"goToMain" sender: self];
}

//FB
// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
   // NSLog(@" active session login: %@",[FBSession activeSession] );
    
    // self.statusLabel.text = @"You're logged in as";
    
}
// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
   // NSLog(@" active session logout: %@",[FBSession activeSession]);
    
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* facebookCookies = [cookies cookiesForURL:[NSURL URLWithString:@"http://login.facebook.com"]];
    
    for (NSHTTPCookie* cookie in facebookCookies) {
        [cookies deleteCookie:cookie];
    }
    
    
    
    [[[MyApplicationSingleton sharedInstance] utente] logoff];
    
    _lblDescrizione.text = [NSString stringWithFormat:@"Entra anche tu a far parte della Community di Io Riciclo.Accedi subito con Facebook"];
    
    
}
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    [[[MyApplicationSingleton sharedInstance] utente] login :user];
     _lblDescrizione.text = [NSString stringWithFormat:@"Ciao %@ \n sei un membro della Community di Io Riciclo.", [[[MyApplicationSingleton sharedInstance] utente]nomeutente]];
}

//fine FB



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
