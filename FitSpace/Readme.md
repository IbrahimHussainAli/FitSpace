# FitSpace

FitSpace is a fitness application built on iOS. It is a tool to be used to allow for the tracking of the amount of steps taken by the phone user, as well as showing the distance taken by those steps and the number of floors ascended. The number of steps data uses an apple framework 'Core Motion', using a main thread queue within the application the number of steps updates live while walking and this updates the progress bar. This information may be used by an individual who wants to be more active, the user can also set a goal target for that day and the circular progress bar on the home page will show how far away the user is from that goal target. The application also allows for users to review the number of steps that they have done, to do this a query is used to gain data from the pedometer data of the  framework. 

A feature of the application is the ability to create an account of the database. To create an account you sign up using your given name, email address and password. This authorisation system was created using the Firebase NOSQL database, allowing for a user to log into the system, log out and if their password is forgotten, the application has a feature that the user can enter the email address that was used to sign up and a reset link will be sent. The email and password has been coded for validation so the email is a valid email address and the password has more than 8 characters, a number and a special character. The forgot password feature allows user to get sent a reset password link to the email that was used to sign up to the FitSpace app.

## Structure

The structure that I have chosen to use is a Model View Controller approach. The model which includes folders such as Helpers and Application Delegate have been made separately. The view is the user interface, within XCode this is in the form of storyboards which allows you to design the user interface in a graphical way so this was used to create the main user interface and in this project they are contained in the View folder. The controllers are the glue which allows for the UI to work, this is where the frameworks come into play and all the contollers are included within the controller folder. A feature of XCode is when frameworks and/or libraries are used it creates a 'xcworkspace' file where you continue to work once frameworks are used, this doesn't affect the project. 

As mentioned, the main user interface was created in the storyboard, this includes the buttons and labels. The user interface was then connected to the code through the controllers. The controllers have been separated by which view it is connected to so for each screen there is a controller e.g the forgot password screen UI design was created in the storyboard and has it's own controller.

## Technical

The frameworks that have been used within this project includes: 
UIKit - This is used in most iOS developing application and is used to define the main User Interface components such as labels and buttons.
Core Motion - Used for the main feature in the application, core motion reports the motion and enivronment related data using hardware which is built into iOS devices. This was used for the pedometer, FitSpace uses core motion to count the number of steps, measure the distance that has been travelled and the number of floors that have been ascended. To use core motion it first takes a boolean statement on whether or not step count is available, when a user first signs up and uses the app a pop up alert asks if they want to allow the Motion and Fitness tracking data from their device to be used within the app. 
Firebase - The firebase framework is one of the connections that allows for the application to make it's link to the database. The database was used for the log in and sign up feature.
Charts - This framework allows for the use of charts within the iOS application.
IQKeyboardManagerSwift - Ensures that if a text field input is covered by the keyboard then it allows for the user to move to the next field or press Done so the keyboard goes away. 
MBCircularProgressBar - Used to create a circular progress bar. 

The Firebase, Charts, KeyboardManager and ProgressBar was put into the project through CocoaPods which is a dependency manager and allows management for libraries to be much easier. These are all located within the 'Pods' folder. 

## Design

The User interface was designed by myself including colour scheme. Fonts used were from google fonts: https://fonts.google.com/
The logo and icon was also designed by myself using the software, Figma. 

## Author 
Ibrahim Hussain, P17176232.

