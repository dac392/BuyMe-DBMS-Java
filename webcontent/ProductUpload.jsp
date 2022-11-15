<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>

	<title>BuyMe | Sell</title>
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/form-styles.css">
</head>
<body>
	<%@ include file="Components/Header.jsp" %>
	
	<form method="post" action="ValidateProduct.jsp">
		<fieldset>
	     	<legend><h1>List an Item</h1></legend>
	     	<label for="min-price">Minimum Price:</label>
	       	<input type="text" id="min-price" name="min-price"/> <br/>
	       	
	       	<label for="amount">Starting price:</label>
	       	<input type="text" id="amount" name="amount"/> <br/>
	       	
	       	<label for="bid-increment">Bid increment:</label>
	       	<input type="text" id="bid-increment" name="bid-increment"/> <br/>
	       	
	       	<label for="end-date">Closing date:</label>
	       	<input type="date" id="end-date" name="end-date"/> <br/>
	       	
<!-- 	       	<label for="category">Category:</label>
	       	<input type="text" id="category" name="category"/> <br/> -->
	      
	      <label for="category">Category</label><br>
          <select id="category" name="category">
            <option hidden>Select category</option>
            <option value="tops">Tops</option>
            <option value="bottoms">Bottoms</option>
            <option value="shoes">Shoes</option>  
          </select> 
	       	
	      <label for="sub-category">Sub Category</label><br>
          <select id="sub-category" name="sub-category">
            <option hidden>Select type</option>
            <option value="hoodie">Hoodie</option>
            <option value="crewneck">Crewneck</option>
            <option value="zipup">Zipup</option>  
            <option value="fleece">Fleece</option>  
          </select> 
	       	
	       	
			<label for="specification">Color</label><br>
			<select id="specification" name="specification">
			  <option hidden>Select color</option>
			  <option value="black">Black</option>
			  <option value="brown">Brown</option>
			  <option value="grey">Grey</option>  
			  <option value="green">Green</option>  
			</select> 
	       	
	       	<input type="submit" value="Submit"/>
     	</fieldset>
	</form>
	
	<!-- <script type="text/javascript" src="Scripts/dropdown.js"></script> -->
</body>
</html>