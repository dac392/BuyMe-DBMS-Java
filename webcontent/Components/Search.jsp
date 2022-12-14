<%@ page import ="java.io.*,java.util.*,java.sql.*,com.buyme.*"%>


<div class="search-bar">
	<form method="get" action="searchResults.jsp" id="search-form" class="search-bar">
		<input type="text" id="search" name="search">
		<a onclick="document.getElementById('search-form').submit()"><img id="seach-btn" src="Assets/icn-search.svg" alt="search"></a>
	</form>
</div>