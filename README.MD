# BuyMe

> Project 01 for 01:198:336

An online auction system using a java based client and MySQL database.

## Current Status

Thus far, I the front end works decently well with the login/logout requirements, however I used my description for the db that I had made prior to joining the group. You can find my schema under docs/ if you would like to test it out as is. I will try to update it to adhere to the schema I saw posted on canvas at a later time.

## Testing

In theory, the only thing needed for the project to be set up is to make a "BuyMe" db with a single "Enduser" table in the form of

| username | name          	| email     	| password     	| isstaff     | isadministrative | username | isbuyer |
| -------- | -------------- | -------------- | ------------	| ----------- | ---------------- | -------- | ------- |
| John642  | John Doe 		| john@gmail.com | 1234			| null		  | null			 | null     | null    |

Note that as is, the connection does not require a password meaning that to form a connection:

``` java
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "");
```

