//
//  CustomerLounge.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Google Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import "CustomerLounge.h"
#import "PaymentGateway.h"
#import "ProductList.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MMDrawerController.h"

@interface CustomerLounge () {
    NSArray *pizzaName;
    NSArray *pizzaPrice;
}

@end

@implementation CustomerLounge

- (void)viewDidLoad {
    [super viewDidLoad];
    //corner radius
    self.profileImage.layer.cornerRadius = 41;
    self.profileImage.clipsToBounds = true;
    self.profileImage.userInteractionEnabled = true;
    
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageChange:)];
    touch.numberOfTapsRequired = 1;
    self.profileImage.userInteractionEnabled = YES;
    [self.profileImage addGestureRecognizer:touch];

    [self gettingSQLInformation];
    [self customerPurchaseHistory];
    [self receiveCustomerDatabaseProductDetails];
    
    //set setting
    [self parametersOfView];
    

}
#pragma mark - view settings
-(void)parametersOfView{
    
    //mine editing
    UIImageView* background = [[UIImageView alloc]initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"pizza_loadingScreen.jpg"];
    tableView.backgroundColor = [UIColor clearColor];
    
    //navigation bar style edite
    self.navigationItem.title = @"Stash";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    UIColor* colore = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    NSDictionary* dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:colore, NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Profile Image View Change

-(void)profileImageChange:(UITapGestureRecognizer *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImage.image = chosenImage;
    
    NSData* data = UIImageJPEGRepresentation(self.profileImage.image, 0.95f);
    PFFile *imageFile = [PFFile fileWithName:@"profile_image.jpg" data:data];
    
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *userPhoto = [PFQuery queryWithClassName:@"_User"];
    [userPhoto getObjectInBackgroundWithId:currentUser.objectId
                                     block:^(PFObject *userPhoto, NSError *error) {
                                         userPhoto[@"profileImage"] = imageFile;
                                         [userPhoto saveInBackground];
                                     }];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Download information from Google SQL

- (void)receiveCustomerDatabaseProductDetails {
    PFQuery *query = [PFQuery queryWithClassName:@"FFHistory"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *musicLibrary, NSError *error) {
        if (!error) {
            pizzaName = [musicLibrary valueForKey:@"productName"];
            pizzaPrice = [musicLibrary valueForKey:@"productPrice"];
            [tableView reloadData];
            NSLog(@"%@", musicLibrary);
        }
    }];
}

#pragma mark - UITableView initial controller

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pizzaName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *staticCellForTable = @"pizzaItemSQL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:staticCellForTable];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:staticCellForTable];
    }
    
    cell.textLabel.text = [pizzaName objectAtIndex:indexPath.row];
   // cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [[pizzaPrice objectAtIndex:indexPath.row] stringValue];
    //cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Universal DB connection for data loading

- (void)gettingSQLInformation {
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *customerDB, NSError *error) {
        self.firstName.text = customerDB[@"firstName"];
        self.lastName.text = customerDB[@"lastName"];
        self.creditValue.text = [NSString stringWithFormat:@"%@ ₽", customerDB[@"dinnersCredit"]];
        
        PFFile *imageFile = [customerDB objectForKey:@"profileImage"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                self.profileImage.image = [UIImage imageWithData:data];
            }
        }];
        
        NSLog(@"%@", customerDB);
    }];
}

- (void)customerPurchaseHistory {
    PFQuery *query = [PFQuery queryWithClassName:@"Invoice"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.purchaseStack = [NSArray arrayWithArray:objects];
            NSLog(@"Stack: %@", objects.objectEnumerator);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Payment processing gateway for Stripe and Authorize.net

- (IBAction)paymentGateway:(id)sender {
    PaymentGateway *paymentViewController = [[PaymentGateway alloc] initWithNibName:@"PaymentGateway" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:paymentViewController];
    [self presentViewController:nav animated:true completion:nil];
}

- (IBAction)listOfDinners:(id)sender {

}



- (IBAction)infoAction:(UIButton *)sender {
}

- (IBAction)callAction:(UIButton *)sender {
    NSString *phoneNumber = @"1157558";
    NSURL *phoneUrl = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phoneNumber]];
    NSURL *phoneFallbackUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    
    if ([UIApplication.sharedApplication canOpenURL:phoneUrl]) {
        [UIApplication.sharedApplication openURL:phoneUrl];
    } else if ([UIApplication.sharedApplication canOpenURL:phoneFallbackUrl]) {
        [UIApplication.sharedApplication openURL:phoneFallbackUrl];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Your device can not do phone calls" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)dealloc{
    NSLog(@"Castomer dealocated");
}
@end
