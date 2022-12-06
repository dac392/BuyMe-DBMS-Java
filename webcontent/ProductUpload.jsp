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
            <option category="tops" value="hoodie">Hoodie</option>
            <option category="tops" value="crewneck">Crewneck</option>
            <option category="tops" value="zipup">Zipup</option>  
            <option category="tops" value="fleece">Fleece</option>
            
            <option category="bottoms" value="jeans">Jeans</option>
            <option category="bottoms" value="joggers">Joggers</option>
            <option category="bottoms" value="sweatpants">Sweatpants</option>
            
            <option category="shoes" value="boots">Boots</option>
            <option category="shoes" value="sneakers">Sneakers</option>
            <option category="shoes" value="Slides">Slides</option>
            <option category="shoes" value="Slippers">Slippers</option>
          </select> 
          
          <label for="size">Size</label><br>
          <select id="size" name="size">
          	<option hidden>Select size</option>
          	<option category="tops" value="XS">XS</option>
          	<option category="tops" value="S">S</option>
          	<option category="tops" value="M">M</option>
          	<option category="tops" value="L">L</option>
          	<option category="tops" value="XL">XL</option>
          	
          	<option category="bottoms" value="26X28">26 X 28</option>
          	<option category="bottoms" value="26X30">26 X 30</option>
          	<option category="bottoms" value="28X28">28 X 28</option>
          	<option category="bottoms" value="28X30">28 X 30</option>
          	<option category="bottoms" value="28X32">28 X 32</option>
          	<option category="bottoms" value="28X34">28 X 34</option>
          	<option category="bottoms" value="29X30">29 X 30</option>
          	<option category="bottoms" value="29X32">29 X 32</option>
          	<option category="bottoms" value="29X34">29 X 34</option>
          	<option category="bottoms" value="30X30">30 X 30</option>
          	<option category="bottoms" value="30X32">30 X 32</option>
          	<option category="bottoms" value="30X34">30 X 34</option>
          	<option category="bottoms" value="30X36">30 X 36</option>
          	<option category="bottoms" value="31X30">31 X 30</option>
          	<option category="bottoms" value="31X32">31 X 32</option>
          	<option category="bottoms" value="31X34">31 X 34</option>
          	<option category="bottoms" value="31X36">31 X 36</option>
          	<option category="bottoms" value="32X30">32 X 30</option>
          	<option category="bottoms" value="32X32">32 X 32</option>
          	<option category="bottoms" value="32X34">32 X 34</option>
          	<option category="bottoms" value="32X36">32 X 36</option>
          	<option category="bottoms" value="33X30">33 X 30</option>
          	<option category="bottoms" value="33X32">33 X 32</option>
          	<option category="bottoms" value="33X34">33 X 34</option>
          	<option category="bottoms" value="33X36">33 X 36</option>
          	
          	<option category="shoes" value="M4/W6">M4/W6</option>
          	<option category="shoes" value="M5/W7">M5/W7</option>
          	<option category="shoes" value="M6/W8">M6/W8</option>
          	<option category="shoes" value="M7/W9">M7/W9</option>
          	<option category="shoes" value="M8/W10">M8/W10</option>
          	<option category="shoes" value="M9/W11">M9/W11</option>
          	<option category="shoes" value="M10/W12">M10/W12</option>
          	<option category="shoes" value="M11/W13">M11/W13</option>
          	<option category="shoes" value="M12/W14">M12/W14</option>
          </select>
	       	
	       	
		<label for="color">Color</label><br>
		<input type="text" id="color" name="color">
	       	
	    <input type="submit" value="Submit"/>
     	</fieldset>
	</form>
	
	<script type="text/javascript" src="Scripts/dropdown.js"></script>
</body>
</html>