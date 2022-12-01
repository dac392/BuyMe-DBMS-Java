# BuyMe

> Project 01 for 01:198:336

An online auction system using a java based client and MySQL database.

## Current Status

- [x] login/logout
- [x] List an item for sale (will probably need to come back to this one later on)
- [x] updated schema definition found under docs/quickstart.sql

Thus far, I've managed to make login/logout work successfully and since I don't think the next part of the project has been released, I've just been adding things that either might be required (to an extent) or will just make the site a little nicer.

I was able to set up (more or less) the functionality for a user to list an item for sale and as an added touch, the site will display the 10 newest items listed for sale on the home page. The functionality that I added is definitely not perfect but thus far works ok-ish.

Additionally, to make the site look better I added a very rudimentary image/thumbnail feature for each item. I could not wuite figure out how to allow the user to upload their own picture if they wished, so I made a table in the databse to keep track of the pictures that I have access to (found in webcontent/Assets) to choose an appropriate picture based on the category/sub-category/specification of the item being listed. I don't think this method is all that perfect and will probably need to be reworked depending on how the group decides to proceed with th project but its nice to look at for right now :)

## Set up

1. Once you clone the repository you can choose: > File > New > Dynamic Web Project
1. Rather than using the default location, uncheck that option and browse your machine for the correct repository and give it a name. ![Step 1](/docs/step1.png)
1. From there click next twice, and once you reach the "Web Module" section, rather than keeping the default "src/main/webapp" content directory, simply rename it to "webcontent" and click finish. ![Step 2](/docs/step2.png)

Lastly, you'll need to set up the tomcat and db that it needs to connect to before being able to run it as server.

## DB & Testing

You should be able to just use the quickstart.sql script found under docs/ to help you set up the db. Note that the tb and the tables will probably change often enough as for right now they are just enough to make project work but probably not enough to meet future benchmarks.

In theory, the only thing needed for the project to be set up is to make a "BuyMe" db with a single "Enduser" table in the form of

| username | name     | email          | password | isstaff | isadministrative |
| -------- | -------- | -------------- | -------- | ------- | ---------------- |
| John642  | John Doe | john@gmail.com | 1234     | null    | null             |

Note that as is, the connection does not require a password meaning that to form a connection:

```java
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "");
```

# The state of the website so far

I had some spare time so I tried to implement the product listing feature, or at least start on what it might look like, but since the next part of the project has not been released so far I took some liberties with it. This ofcourse is not the final product and instead was just a quick way to throw something up that looks and works pretty well.

So far the site can only really handle

1. tops/crewneck
1. tops/hoodie
1. tops/zipup
1. tops/fleece

as I'm not sure on the specifics for the next bench mark and did not want to implement the entire system if it was wrong.

For right now products are divided into

1. categories
   1. tops
   1. bottoms
   1. shoes
1. subcateglries
   1. crewneck
   1. hoodie
   1. zipup
   1. fleece
1. specifiaction
   1. black
   1. brown
   1. grey
   1. green

Note that so far, users can at most list items for sale and all other functionality is yet to be implemented.

## Project flow

Quick overview of files

1. main files (usable routes):
   1. index.jsp - home page
   1. Login.jsp - static form for loging in
   1. LoginDetail.jsp - makes a call to the db to check if there is a user with the information provided in the log in form
   1. Logout.jsp - invalidates the session and redirects to the login screen
   1. ProductUpload.jsp - static form for the ProductListing
   1. ValidateProduct.jsp - after uploading the product, the seller is redirected here to view their new listing (somewhat of a successful upload verification)
   1. ProductListing.jsp - inserts into the Sellsproduct table values provided in the ProductListing form as well as calls the db to find a link from the Assets table that matches the product description for thumbnail purposes
   1. SellerListing.jsp - INCOMPLETE
   1. Signup.jsp - register form. Does not redirect to something useful rn (i think)
   1. Success.jsp - login successful screen
   1. RegisterUser.jsp - inserts new user infor into the db
   1. ShowEndUsers.jsp (Mostly for debugging) - for debugging, shows list of all current users
1. Components (some components separated for shareability or ease of housekeeping)
   1. ContentView.jsp - thumbnails in index.jsp
   1. Header.jsp
1. css
   1. global.css (should prob be included in all main jsp files)
   1. form-styles.css (for form styling)
   1. listing.css (styles for a specific product overview i.e. ProductListing)
   1. thumbnail.css (styles index.jsp's thumbnails);
1. Scripts (js scripts to handle some front end things on the client)
   1. dropdown.js [probably deprecated]
   1. slider.js [image functionality]
1. Assets (product images used as thumbnails to make the project look nicer)
   1. Assets/crewneck/black
   1. Assets/crewneck/brown
   1. Assets/crewneck/grey
   1. Assets/crewneck/green
   1. Assets/hoodie/black
   1. Assets/hoodie/brown
   1. Assets/hoodie/grey
   1. Assets/hoodie/green
   1. Assets/zipup/black
   1. Assets/zipup/brown
   1. Assets/zipup/grey
   1. Assets/zipup/green
   1. Assets/fleece/black
   1. Assets/fleece/brown
   1. Assets/fleece/grey
   1. Assets/fleece/green
