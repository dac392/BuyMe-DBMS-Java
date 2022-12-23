
Admin Credentials:

	Username: Admin
	Password: 

(there is no password)

Default Customer Representative Credentials:

	Username: Customer Rep
	Password: password

---------------------------

Note that src/main/java/com/buyme/Database.java is where the SQL connector is made, and includes a preset username and password respectively on line 33. Change this to fit your local system's context instead.


---------------------------

A thing about the search query system, used in both the browsing system and the alerts system. (Also applies to that query on the Admin page)

To use it, create "terms" akin to the examples given below.

There's singleton some terms:
	open
	closed
	tops
	jeans
	grey
	
...or any other category, subcategory, or color.

There's also comparison operators (=, >, <, >=, <=), which can also be used. Note that these are REQUIRED when filtering for price or seller. Note that any term (so far) cannot have a space, as those separate different terms.

	price<45
	seller=Jose
	size>=M
 
Due to taking things and putting them straight into SQL without second thought, it is strongly advised not to add ANY quotes whatsoever into most text fields. However, spaces are supported, but require you to surround the relevant area with single quotes in filter queries. See below:

	seller='Jack Saul'

By combing terms and putting them into the relevant text box, one can create a good variety of search queries and alert filters, such as the string below:

	shoes size<M7 black seller='Bob Star'

Put the above into the search bar, and you would get black shoes smaller than size M7/W9 sold by someone with the account username "Bob Star".

(I am fully aware this system is a security breach waiting to happen, but I doubt this project's going anywhere.)