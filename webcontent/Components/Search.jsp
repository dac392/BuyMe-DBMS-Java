<%@ page import ="java.io.*,java.util.*,java.sql.*,com.buyme.*"%>


<div class="search-bar">
	<form method="get" action="searchResults.jsp" id="search-form" class="search-bar">
		<input type="text" id="search" name="search">
		<a onclick="document.getElementById('search-form').submit()"><img id="seach-btn" src="Assets/icn-search.svg" alt="search"></a></br>
		<select id="search-sort" name="search-sort" >
          <option value="id">Sort By Post Order</option>
          <option value="deadline">Sort By Deadline</option>
          <option value="price">Sort By Price</option>
        </select> 
        <select id="search-sort-order" name="search-sort-order" >
          <option value="desc">Decending</option>
          <option value="asc">Ascending</option>
        </select> 
	</form>
</div>