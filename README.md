# This is our project report
# Rate My Landlord

Renting a house or apartment for living can be very challenging when someone just moved in a new city or do not have any idea about the landlords of the city. It is very important to research the landlord before moving in to make the living experience regretless. Our "RATE MY LANDLORD" app will help your research on the landlord easier. You can check the tenant's review for a specific address who is living there or used to live there. You can also post a review for your previous addresses to help others to choose the right place to rent.

You can read our initial propsal of this project [here](https://github.com/UPEI-Android/groupproject-t3m/blob/mr-report/documents/proposal/proposal.md).

# App UI and Business & Logic

Let's go through each page of our app one by one and explore what is happening.

One thing we should mention very early is that, we use [Google Firebase](https://firebase.google.com/) for our app backend.

## Authentication

We have used [Google Firebase](https://firebase.google.com/) for storing user information and authenticate themselves. It comes with all the helper method to accomplish that.

## Data Storage

We have used Firebase Realtime Database for storing all sorts of data we required to store.
Our database looks like this:

```bash
├── landlord
│   ├── id
│   │   ├── email
│   │   ├── firstName
│   │   ├── lastName
│   │   ├── rating
├── tenants
│   ├── id
│   │   ├── email
│   │   ├── firstName
│   │   ├── lastName
│   │   ├── rating
├── ratings
│   ├── email
│   │   ├── id
│   │   │   ├── comment
│   │   │   ├── date
│   │   │   ├── postByUserName
│   │   │   ├── rating
└──
```

### Storing User Information

When a user signup, we store the details in Firebase's built-in authentication storage. And at the same time, if the user chooses to be 'Tenant', we add his details in tenants table/collection too, same for if the user chooses type 'Landlord'.


### Tenant and Landlord Collection

Tenants and Landlord table/collection holds all the user who are Tenants and Landlord respectively, and also store their ratings.

### Rating Collection

Rating Collection store any users ratings in details such as comments, who rated and how many stars the use recieved. It was indexed with the user email. So, if we want to fetch any particular user rating, we go the Rating table, and search by his email address. We will get an list of object which is all of the users ratings.
## **LOGIN PAGE**

![LoginPage](./draft%20design/Log%20in%20page%20.png)

This the login page. Very basic. As mentioned earlier, Google firabase takes care of the authentication process. It also linked to the SignUp page, if the user has no account with our already.


## **SIGNUP PAGE**

![SignupPage](./draft%20design/Signup%20Page.png)

Again, nothing extraordinary. Google firabase takes care of the signup process. **Every time user sign up as a *Tenant*, we added a new entry in Tenant collection. for if the user chooses type *Landlord*.**

## **HOME PAGE**

![HomePage](./draft%20design/Home%20Page.png)

This is the first page user will see after signing in. This page will list the most rated address or houses from the database

## **SEARCH PAGE**
![SearchPage](./draft%20design/Search(Tenant)%20Page.png)

Search page shows the list of all the landlords, tenants and addresses. The user can search by any name. We have three buttons, the user can filter the results with his preference. The user can also tap into one of the result, that will take them to a new details page where they can learn more about that specific search result.


## **DETAILS PAGE**

![details page](./draft%20design/AddressDetails%20Page.png)

This page shows all the information about each specific object(Tenant, Landloard, Address). We use a Cubit that tracks the currently selected object and when user go to this page, the page retrieves the data from the cubit and renders the page based on the type of object. They can also leave a **RATING** from that page.
## **POST REVIEW PAGE**

![Post review page](./draft%20design/final_post_review.png)

This page allow you to post a review to a specific Tenants, landlords or address.

## **PROFILE PAGE**

![PROFILE PAGE](./draft%20design/profile_new.png)

This is the profile page of our app. The user can see their details such as their rating, who left a rating to him and also chance to logout of the app if they wish to.

## **CONTRIBUTION** 

### *MOHAMMED AMAAN*
```
He designed the Signup page, and implemented the Login page. He worked on writign the test code for this project.
```
### *MAMNOON AHMED*
```
He designed all the pages of the app using Figma except Signup page. He worked on implementing several pages such as profle page, home page, details page, search page.
```
### *ESSAYAS KASSA*
```
He worked on implementing the entire applications backend. This includes login, signup, fetch data, update data, error handling, creating different model and many more.
```
### *MOSHIUR RAHMAN*
```
He implemented the signup page, info page, the bottom navigation bar, all the cubit of the app. He also contributed to the design choices of our databse and managing the github repository and project.
```

## Dependencies

Here is our all dependencies of the app. We might have some unsued dependencies that we initially thought were gonna use, but ended up not using them.


```
firebase_core: ^1.13.1
firebase_analytics: ^9.1.2
firebase_auth: ^3.3.9
cloud_firestore: ^3.1.10
mockito: ^5.1.0
flutter_svg: ^1.0.3
font_awesome_flutter: ^10.1.0
carousel_slider: ^4.0.0-nullsafety.0
smooth_page_indicator: ^1.0.0+2
flutter_rating_bar: ^4.0.0
google_fonts: ^2.3.1
firebase_database: ^9.0.8
equatable:

cupertino_icons: ^1.0.2

google_maps_flutter: ^2.1.1
animations: ^2.0.2
flutter_bloc: ^8.0.1
bloc: ^8.0.3
url_launcher: ^6.0.20
```