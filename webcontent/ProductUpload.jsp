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
	       	
	       	<label for="category">Category:</label>
	       	<input type="text" id="category" name="category"/> <br/>
	       	
	       	<div class="select-group">
		       	<label for="dropdown-trigger">Sub-category</label>
		       	<button class="trigger" id="dropdown-trigger">
		       	    <span id="select-label">- please select one -</span>
          			<div id="arrow" class="arrow"></div>
		       	</button>
		       	
		       	<div id="dropdown" class="dropdown hidden">
		       		<label class="select-item" for="tops">Tops</label>
		       		<input type="radio" class="option" id="tops"  name="sub-category" value="tops">
		       		
		       		<label class="select-item" for="bottoms">Bottoms</label>
		       		<input type="radio" class="option" id="bottoms" name="sub-category" value="botttoms">
		       		
		       		<label class="select-item" for="shoes">Shoes</label>
		       		<input type="radio" class="option" id="shoes" name="sub-category" value="shoes">
		       	</div>
	       	</div>
	       	
	       	<label for="specification">Specification:</label>
	       	<input type="text" id="specification" name="specification"/> <br/>
	       	
	       	<input type="submit" value="Submit"/>
     	</fieldset>
	</form>
	
	<script type="text/javascript" src="Scripts/dropdown.js"></script>
</body>
</html>