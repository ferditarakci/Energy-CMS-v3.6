<!--#include file="header.asp"-->
		<style type="text/css">
			/*body { overflow:auto !important; }*/

			#mapCanvas {
				float:left;
				width:50%;
				height:270px;
			}

			#markerStatus {
				color:#f00;
				padding-bottom:15px;
			}

			#infoPanel {
				float:right;
				width:48%;
				margin-left:10px;
			}

			#infoPanel div {
				margin-bottom:5px;
			}
		</style>

		<!-- Google Maps -->
		<script type="text/javascript" src="//maps.google.com/maps/api/js?sensor=false"></script>
		<script type="text/javascript">
		var geocoder = new google.maps.Geocoder();

		function insertFrame() {
			var globalFrame = "";
			globalFrame = ''
			globalFrame += '<iframe src="http://www.google.com/maps?q=' + document.getElementById('address').innerHTML +'@' + document.getElementById('info').value +'&amp;z=11&amp;t=k&amp;ie=UTF8&amp;output=embed&amp;iwloc=near" width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>'
			globalFrame += '<br />'
			globalFrame += '<small>'
			globalFrame += '	<a href="http://www.google.com/maps?q=The%20Oslo%20School%20of%20Architecture%20And%20Design@59.924183,10.750693&amp;z=17&amp;t=k&amp;ie=UTF8&amp;iwloc=near" style="color:#0000ff; text-align:left;">Daha Büyük Görüntüle</a>'
			globalFrame += '</small>'
			document.getElementById('snippetarea').innerHTML = globalFrame;
		}

		function geocodePosition(pos) {
		  geocoder.geocode({
			latLng: pos
		  }, function(responses) {
			if (responses && responses.length > 0) {
			  updateMarkerAddress(responses[0].formatted_address);
			} else {
			  updateMarkerAddress('Bu yerde herhangi bir adres bulunamadı.');
			}
		  });
		}

		function updateMarkerStatus(str) {
		  document.getElementById('markerStatus').innerHTML = str;
		}

		function updateMarkerPosition(latLng) {
		  document.getElementById('info').value = [
			latLng.lat(),
			latLng.lng() 
		  ].join(', ');
		}

		function updateMarkerAddress(str) {
			document.getElementById('address').innerHTML = str;
			insertFrame()
			//alert(getZoom())
		}

		function initialize() {
		  var latLng = new google.maps.LatLng(41.01272127343645, 29.02673786261016);
		  var map = new google.maps.Map(document.getElementById('mapCanvas'), {
			zoom: 11,
			center: latLng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		  });
		  var marker = new google.maps.Marker({
			position: latLng,
			title: 'Energy Web Yazılım',
			map: map,
			//icon: 'images/logo-icon.png',
			draggable: true
		  });

		  // Update current position info.
		  updateMarkerPosition(latLng);
		  geocodePosition(latLng);
		  
		  // Add dragging event listeners.
		  google.maps.event.addListener(marker, 'dragstart', function() {
			updateMarkerAddress('İşaretleyici farklı konuma taşınıyor...');
		  });
		  
		  google.maps.event.addListener(marker, 'drag', function() {
			updateMarkerStatus('İşaretleyici farklı konuma taşınıyor...');
			updateMarkerPosition(marker.getPosition());
		  });
		  
		  google.maps.event.addListener(marker, 'dragend', function() {
			updateMarkerStatus('Drag ended');
			geocodePosition(marker.getPosition());
		  });

		}

		// Onload handler to fire off the app.
		google.maps.event.addDomListener(window, 'load', initialize);
		</script>
		<!-- End Google Maps -->
</head>
<body>
<div class="maincolumn" style="margin-right:0px">
	<div class="maincolumn-body" style="margin-right:0px">

		<div class="m_box clearfix">
			<div class="title"><span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span><h3 class="box-title">Google Haritalar</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">

					<div class="clearfix" id="infoPanel">
						<label style="font-weight:bold;">İşaretleyici durumu:</label>
						<br /><br />
						<div id="markerStatus">İşaretleyici sürükleyerek farklı konum seçiniz...</div>
						
						<br />
						<label for="info" style="font-weight:bold;">Şu anki konum:</label>
						<div><input onclick="iSelected(this.id);" id="info" class="inputbox" style="width:370px; margin-top:5px;" type="text" /></div>
						
						<br />
						<label for="address" style="font-weight:bold;">Eşleşen konum adresi:</label>
						<br /><br />
						<div><textarea onclick="iSelected(this.id);" id="address" class="inputbox" style="width:370px; height:70px; margin-top:5px; resize:none;"></textarea></div>

						<label for="snippetarea" style="font-weight:bold;">Eşleşen konum adresi:</label>
						<div><textarea onclick="iSelected(this.id);" id="snippetarea" class="inputbox" style="width:100%; height:120px; margin-top:5px; resize:none;"></textarea></div>
					</div>
					<div id="mapCanvas"></div>
					<div class="clr"></div>
				</div>
			</div>
		</div>

	</div>
</div>

<!--
<iframe src="http://www.google.com/maps?q=The%20Oslo%20School%20of%20Architecture%20And%20Design@59.924183,10.750693&amp;z=17&amp;t=k&amp;ie=UTF8&amp;output=embed&amp;iwloc=near" width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
<br />
<small>
	<a href="http://www.google.com/maps?q=The%20Oslo%20School%20of%20Architecture%20And%20Design@59.924183,10.750693&amp;z=17&amp;t=k&amp;ie=UTF8&amp;iwloc=near"style="color:#0000ff; text-align:left;">Daha Büyük Görüntüle</a>
</small>
-->
</body>
</html>
