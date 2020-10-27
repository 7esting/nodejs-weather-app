#!/bin/bash

#set -e
export ECS_METADATA_URI=':51678/v1/metadata'
export CONTAINER_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
export ECS_CLUSTER_METADATA=$CONTAINER_IP$ECS_METADATA_URI
curl -s $ECS_CLUSTER_METADATA

cat <<EOF > views/about.ejs
<!DOCTYPE html>
<html>
  <head><title>About</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/css/nav-footer.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <div class="topnav" id="myTopnav">
      <!-- Navigation menu -->
      <%- include('templates/nav') %>
      <a href="javascript:void(0);" class="icon" onclick="myFunction()">
        <i class="fa fa-bars"></i>
      </a>
    </div>

    <div style="padding-left:16px">
      <h2>About</h2>
      
      <div class="container">
        <p><a href="https://nodejs.org/en/docs/guides/" target="_blank">Node.js</a> application, using <a href="https://www.npmjs.com/package/express" target="_blank">Express</a> web framework and <a href="https://www.npmjs.com/package/ejs" target="_blank">Embedded JavaScript templates</a>.</p>
        <p><h2>AWS ECS container metadata for this instance</h2></p>
EOF
		echo "<pre>" >> views/about.ejs
		curl -s $ECS_CLUSTER_METADATA | jq '.' >> views/about.ejs
		echo "</pre>" >> /usr/src/app/views/about.ejs
cat <<EOF >> views/about.ejs
	  </div>
    </div>

    <script>
    function myFunction() {
      var x = document.getElementById("myTopnav");
      if (x.className === "topnav") {
        x.className += " responsive";
      } else {
        x.className = "topnav";
      }
    }
    </script>

    <!-- Footer  -->
    <%- include('templates/footer') %>
  </body>
</html>
EOF
