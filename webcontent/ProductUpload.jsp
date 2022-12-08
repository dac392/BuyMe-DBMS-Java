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
	<script>
    	function updateForm(category){
    		console.log(category);
    		if (category === "tops"){
    			document.getElementById("tops").style.display = 'block';
    		} else {
    			document.getElementById("tops").style.display = 'none';
    		}
    		if (category === "bottoms"){
    			document.getElementById("bottoms").style.display = 'block';
    		} else {
    			document.getElementById("bottoms").style.display = 'none';
    		}
    		if (category === "shoes"){
    			document.getElementById("shoes").style.display = 'block';
    		} else {
    			document.getElementById("shoes").style.display = 'none';
    		}
    		
    	}
    </script>
	<form method="post" action="ValidateProduct.jsp" id="optionForm">
		<fieldset>
	     	<legend><h1>List an Item</h1></legend>
	     	<label for="auction-name">Product Title:</label>
	       	<input type="text" id="auction-name" name="auction-name"/> <br/>
	     	
	     	<label for="min-price">Minimum Price:</label>
	       	<input type="text" id="min-price" name="min-price"/> <br/>
	       	
	       	<label for="amount">Starting price:</label>
	       	<input type="text" id="amount" name="amount"/> <br/>
	       	
	       	<label for="bid-increment">Bid increment:</label>
	       	<input type="text" id="bid-increment" name="bid-increment"/> <br/>
	       	
	       	<label for="end-date">Closing date:</label>
	       	<input type="date" id="end-date" name="end-date"/> <br/>
	      
	      <label for="category">Category</label><br>
          <select id="category" name="category" onchange="updateForm(this.value)">
            <option>Select category</option>
            <option value="tops">Tops</option>
            <option value="bottoms">Bottoms</option>
            <option value="shoes">Shoes</option>  
          </select> 
	       	
	      <div id="tops"  style="display:none">
		      <label for="t-sub-category">Type</label><br>
	          <select id="t-sub-category" name="t-sub-category" >
	            <option >Select type</option>
	            <option value="hoodie">Hoodie</option>
	            <option value="crewneck">Crewneck</option>
	            <option value="zipup">Zipup</option>  
	            <option value="fleece">Fleece</option>
	          </select> 
	          
	          <label for="t-size">Size</label><br>
	          <select id="t-size" name="t-size">
	          	<option >Select size</option>
	          	<option value="XS">XS</option>
	          	<option value="S">S</option>
	          	<option value="M">M</option>
	          	<option value="L">L</option>
	          	<option value="XL">XL</option>
	          </select>
          </div>
          <div id="bottoms" style="display:none">
		      <label for="b-sub-category">Type</label><br>
	          <select id="b-sub-category" name="b-sub-category" >
	            <option >Select type</option>
	            <option value="jeans">Jeans</option>
	            <option value="sweatpants">Sweatpants</option>
	          </select> 
	          
	          <label for="b-size-1">Size</label><br>
	          <select id="b-size-1" name="b-size-1" style="display:inline; width:30%">
	          	<option >Select size</option>
	          	<option value="26">26</option>
	          	<option value="28">28</option>
	          	<option value="29">29</option>
	          	<option value="30">30</option>
	          	<option value="31">31</option>
	          	<option value="32">32</option>
	          	<option value="33">33</option>
	          </select>
	          X
	          <select id="b-size-2" name="b-size-2" style="display:inline; width:30%">
	          	<option >Select size</option>
	          	<option value="28">28</option>
	          	<option value="30">30</option>
	          	<option value="32">32</option>
	          	<option value="34">34</option>
	          	<option value="36">36</option>
	          </select>    
          </div>
          <div id="shoes"  style="display:none">
		      <label for="s-sub-category">Type</label><br>
	          <select id="s-sub-category" name="s-sub-category" >
	            <option >Select type</option>
	            <option value="boots">Boots</option>
	            <option value="sneakers">Sneakers</option>
	            <option value="slides">Slides</option>
	          </select> 
	          
	          <label for="s-size">Size</label><br>
	          <select id="s-size" name="s-size">
	          	<option >Select size</option>
	          	<option value="4">M4/W6</option>
	          	<option value="5">M5/W7</option>
	          	<option value="6">M6/W8</option>
	          	<option value="7">M7/W9</option>
	          	<option value="8">M8/W10</option>
	          	<option value="9">M9/W11</option>
	          	<option value="10">M10/W12</option>
	          	<option value="11">M11/W13</option>
	          	<option value="12">M12/W14</option>
	          </select>
          </div>
		<label for="color">Color</label><br>
		<select id="color" name="color">
          	<option value="black">black</option>
          	<option value="brown">brown</option>
          	<option value="grey">grey</option>
          	<option value="green">green</option>
          	<option value="blue">blue</option>
          	<option value="other">other</option>
		</select>
	       	
	    <input type="submit" id="submit" value="Submit"/>
     	</fieldset>
	</form>
	
	<script type="text/javascript" src="Scripts/dropdown.js"></script>
</body>
</html>