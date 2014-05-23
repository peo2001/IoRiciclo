//
//  ViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Comuni.h"
#import "Zone.h"
#import "GiorniRiciclo.h"
#import "TipiRiciclo.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"
#import "DateHelper.h"
#import <iAd/iAd.h>


@interface RicicloViewController : UIViewController <ADBannerViewDelegate,UITableViewDelegate,UIAlertViewDelegate>
{
    NSDate *currentDate;
    NSMutableArray *GiorniRiciclaggio;
    NSMutableArray *GiorniRiciclaggioDomani;
    NSMutableArray *GiorniRiciclaggioDopodomani;
    NSMutableArray *GiorniRiciclaggio3Giorni;
    UIDatePicker *datePicker;
    UIView * newDatePickerView ;
    UIBarButtonItem *alarm;
    Comuni * comune;
    BOOL alarmViewReady;
    //iad
    ADBannerView *adBannerView;
    UIView *contentView;
    NSDate *dataoraMax;
    NSDate *dataoraMin;
    
}

@property (strong, nonatomic) IBOutlet UILabel *lblData;
@property (strong, nonatomic) IBOutlet UILabel *lblTipoRiciclo;
@property (strong, nonatomic) IBOutlet UILabel *lblTipoRiciclo2;
@property (strong, nonatomic) IBOutlet UILabel *lblDomani;
@property (strong, nonatomic) IBOutlet UILabel *lblDopodomani;
@property (strong, nonatomic) IBOutlet UILabel *lblTreGiorni;

@property (strong, nonatomic) IBOutlet UILabel *lblTipoRicicloDomani;
@property (strong, nonatomic) IBOutlet UILabel *lblTipoRicicloDopodomani;
@property (strong, nonatomic) IBOutlet UILabel *lblTipoRicicloTreGiorni;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewBackground;

@property (strong, nonatomic) IBOutlet UIButton *btnOggi;
@property (strong, nonatomic) IBOutlet UIButton *btnOggi2;
@property (strong, nonatomic) IBOutlet UIButton *btnDomani;
@property (strong, nonatomic) IBOutlet UIButton *btnDopodomani;
@property (strong, nonatomic) IBOutlet UIButton *btnTreGiorni;
@property (strong, nonatomic) IBOutlet UIButton *btnDomani2;
@property (strong, nonatomic) IBOutlet UIButton *btnDopodomani2;
@property (strong, nonatomic) IBOutlet UIButton *btnTreGiorni2;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;

@property (strong, nonatomic) IBOutlet UITableView *tbl;

@property (strong, nonatomic) IBOutlet UITableView *tvOggi;
@property (strong, nonatomic) IBOutlet UITableView *tvDomani;
@property (strong, nonatomic) IBOutlet UITableView *tvDopoDomani;
@property (strong, nonatomic) IBOutlet UITableView *tv3Giorni;

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;


@property (strong, nonatomic) IBOutlet UIButton *btnCassonetti;
@property (strong, nonatomic) IBOutlet UIButton *btnCentriRaccolta;
@property (strong, nonatomic) IBOutlet UIButton *btnAvvisi;
//@property (nonatomic, retain) ADBannerView *adBannerView;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *giorniFuturiView;



//- (void) createAdBannerView;
//- (void) adjustBannerView;

@end
