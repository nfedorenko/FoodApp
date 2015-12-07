//
//  LeftMenuViewController.m
//  Easy Food
//
//  Created by Nikita on 18.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"
#import "MMDrawerController.h"
#import <Parse/Parse.h>


@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.cornerRadius = 50;
    self.profileImage.userInteractionEnabled = true;
    
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageChange:)];
    touch.numberOfTapsRequired = 1;
    self.profileImage.userInteractionEnabled = YES;
    [self.profileImage addGestureRecognizer:touch];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self gettingSQLInformation];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Universal DB connection for data loading

- (void)gettingSQLInformation {
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *customerDB, NSError *error) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", customerDB[@"firstName"],customerDB[@"lastName"]];
        self.creditLabel.text = [NSString stringWithFormat:@"%@ ₽", customerDB[@"dinnersCredit"]];
        
        PFFile *imageFile = [customerDB objectForKey:@"profileImage"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                self.profileImage.image = [UIImage imageWithData:data];
            }
        }];
        
        NSLog(@"%@", customerDB);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView registerNib:[UINib nibWithNibName:@"LeftMenuCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
   
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.row) {
        case 0:
            cell.label.text = @"Menu";
            break;
        case 1:
            cell.label.text = @"Profile";
            break;
        case 2:
            cell.label.text = @"Info";
            break;
        case 4:
            cell.label.text = @"Log Out";
            break;
            
        default:
            break;
    }

    return cell;
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3 || indexPath.row == 4) {
        return 200;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self presenteMenuController];
            break;
        case 1:
            [self presenteProfileController];

            break;
        case 2:
            [self presenteAboutUsController];

        case 4:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - myMethods

-(void)presenteMenuController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"productList"];
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *lvc = [storyboard1 instantiateViewControllerWithIdentifier:@"id"];
    MMDrawerController* vc = [[MMDrawerController alloc]initWithCenterViewController:cvc leftDrawerViewController:lvc];
    vc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.maximumLeftDrawerWidth = 280;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)presenteAboutUsController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsController"];
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *lvc = [storyboard1 instantiateViewControllerWithIdentifier:@"id"];
    MMDrawerController* vc = [[MMDrawerController alloc]initWithCenterViewController:cvc leftDrawerViewController:lvc];
    vc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.maximumLeftDrawerWidth = 280;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)presenteProfileController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomerLounge" bundle:nil];
    UIViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"CustomerPortal"];
    //[self presentViewController:vc animated:true completion:nil];
    
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *lvc = [storyboard1 instantiateViewControllerWithIdentifier:@"id"];
    MMDrawerController* vc = [[MMDrawerController alloc]initWithCenterViewController:cvc leftDrawerViewController:lvc];
    vc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.maximumLeftDrawerWidth = 280;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
