# BuyMe

> Project 01 for 01:198:336

An online auction system using a java based client and MySQL database.

## Current Status

Thus far, I the front end works decently well with the login/logout requirements, however I used my description for the db that I had made prior to joining the group. You can find my schema under docs/ if you would like to test it out as is. I will try to update it to adhere to the schema I saw posted on canvas at a later time.

## Set up

1. Once you clone the repository you can choose: > File > New > Dynamic Web Project
1. Rather than using the default location, uncheck that option and browse your machine for the correct repository and give it a name. ![Step 1](/docs/step1.png)
1. From there click next twice, and once you reach the "Web Module" section, rather than keeping the default "src/main/webapp" content directory, simply rename it to "webcontent" and click finish. ![Step 2](/docs/step2.png)

Lastly, you'll need to set up the tomcat and db that it needs to connect to before being able to run it as server.

## DB & Testing

In theory, the only thing needed for the project to be set up is to make a "BuyMe" db with a single "Enduser" table in the form of

| username | name     | email          | password | isstaff | isadministrative | username | isbuyer |
| -------- | -------- | -------------- | -------- | ------- | ---------------- | -------- | ------- |
| John642  | John Doe | john@gmail.com | 1234     | null    | null             | null     | null    |

Note that as is, the connection does not require a password meaning that to form a connection:

```java
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "");
```
