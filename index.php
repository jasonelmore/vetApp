<?php
// Connect to the database
$servername = "localhost";  // change this if your database is hosted elsewhere
$username = "root";         // change this to your MySQL username
$password = "";             // change this to your MySQL password
$dbname = "vetclinic";     // change this to your MySQL database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query the database and fetch results
$sql = "SELECT * FROM vetClinic.Clinic";
$result = $conn->query($sql);

// Display the results in a table
if ($result->num_rows > 0) {
    echo "<table>";
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["column1"] . "</td><td>" . $row["column2"] . "</td></tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}

// Close the database connection
$conn->close();
?>



<html lang="en">
<html>
  <head>
	  <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
	  
    <title>Example Website</title>
    <style>
      /* CSS for the header */
      .header {
        background-color: #333;
        color: #fff;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      
      /* CSS for the logo */
      .logo {
        display: flex;
        width: 100px;
        height: auto;
      }
      /* CSS for the content section */
      .content {
        display: flex;
        width: auto;
        height: auto;
      }
      /* CSS for the navigation menu */
      .menu {
        display: inline;
        list-style: none;
        margin: 0;
        padding: 25;
		
      }
      
      .menu li {
        display: inline;
        margin-right: 20px;
      }
      
      .menu li:last-child {
        margin-right: 0;
      }
      
      .menu a {
        color: #fff;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <div class="header">
      <img src="logo.png" alt="Logo" class="logo">
      <ul class="menu">
        <li><a href="#">Home</a></li>
        <li><a href="#">Accounts</a></li>
        <li><a href="#">Pets</a></li>
        <li><a href="#">Appointments</a></li>
        <li><a href="#">Billing</a></li>
		<li><a href="#">Pens</a></li>
        <li><a href="#">Pharmacy</a></li>
		<li><a href="#">Billing</a></li>
		<li><a href="#">Supplies</a></li>
		<li><a href="#">Vets</a></li>
      </ul>
    </div>
	  
	
	
	<div class="content">
		
	  </div>
    <!-- rest of the website content here -->
  </body>
</html>