$(document).ready(function() {
    let fullURL = $('#timeFilter').val();
    makeMap(fullURL);

    //Event Listener on Dropdown Change
    $('#timeFilter').change(function() {
        let fullURL = $('#timeFilter').val();
        let vizText = $("#timeFilter opetion:selected").text();
        $('#vizTitle').text(`Earthquake in the ${vizText}`)
        makeMap(fullURL);
    });
});

function makeMap(fullURL) {
    //Clear Map
    $('#mapParent').empty();
    $('#mapParent').append('<div style="height:700px" id="map"></div>');

    // Adding Tile Layer to Map
    var street = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
        attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
        tileSize: 512,
        maxZoom: 18,
        zoomOffset: -1,
        id: "mapbox/streets-v11",
        accessToken: API_KEY
    });

    var satellite = L.tileLayer("https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
        attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
        maxZoom: 18,
        id: "satellite-streets-v11",
        accessToken: API_KEY
    });

    var light = L.tileLayer("https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
        attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
        maxZoom: 18,
        id: "light-v10",
        accessToken: API_KEY
    });

    var watermelon = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
        attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
        tileSize: 512,
        maxZoom: 18,
        zoomOffset: -1,
        id: "rthomas-one/ckd6tk4yl0afs1imhdggz4273",
        accessToken: API_KEY
    });

    var blue = L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
        attribution: "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> <strong><a href='https://www.mapbox.com/map-feedback/' target='_blank'>Improve this map</a></strong>",
        tileSize: 512,
        maxZoom: 18,
        zoomOffset: -1,
        id: "rthomas-one/ckd6txg5b0aqn1ik9fbvutk62",
        accessToken: API_KEY
    });


    // URL captured from HTML Dropdown
    d3.json(fullURL).then(function(response) {

        //Variables for Marker Cluster, Heatmap & Circles
        var markers = L.markerClusterGroup();
        var heatArray = [];
        var circles = [];

        var earthquakes = response.features;

        earthquakes.forEach(function(earthquake) {
            if ((earthquake.geometry.coordinates[1]) && (earthquake.geometry.coordinates[0])) {
                //Create Markers for Cluster
                let temp = L.marker([+earthquake.geometry.coordinates[1], +earthquake.geometry.coordinates[0]]).bindPopup(`<h5>${earthquake.properties.place}</h5><hr><p><b>Magitude:</b> ${earthquake.properties.mag}<br><b>Time:</b> ${new Date(earthquake.properties.time)}<br><b>Latitude:</b> ${earthquake.geometry.coordinates[1]}<br><b>Longitude:</b> ${earthquake.geometry.coordinates[0]}<br><a href="${earthquake.properties.url}" target="_blank">Link to earthquake details</a></p>`);
                markers.addLayer(temp);

                //Store Heatmap Points
                heatArray.push([+earthquake.geometry.coordinates[1], +earthquake.geometry.coordinates[0]]);

                //Generate Cirles
                let circle = L.circle([+earthquake.geometry.coordinates[1], +earthquake.geometry.coordinates[0]], {
                    fillOpacity: 0.75,
                    fillColor: getCircleColor(earthquake.properties.mag),
                    color: getLineColor(earthquake.properties.mag),
                    radius: getMarkerSize(earthquake.properties.mag)
                }).bindPopup(`<h5>${earthquake.properties.place}</h5><hr><p><b>Magitude:</b> ${earthquake.properties.mag}<br><b>Time:</b> ${new Date(earthquake.properties.time)}<br><b>Latitude:</b> ${earthquake.geometry.coordinates[1]}<br><b>Longitude:</b> ${earthquake.geometry.coordinates[0]}<br><a href="${earthquake.properties.url}" target="_blank">Link to earthquake details</a></p>`);

                circles.push(circle);
            }
        });

        var tectonicPlatesURL = "https://raw.githubusercontent.com/fraxen/tectonicplates/master/GeoJSON/PB2002_boundaries.json";
        d3.json(tectonicPlatesURL).then(function(plates) {
            let plateLayer = L.geoJSON(plates, {
                style: function(feature) {
                    return {
                        color: "orange",
                        weight: 1.5
                    };
                }
            });


            //Create Heatmap Layer
            var heat = L.heatLayer(heatArray, {
                radius: 20,
                blur: 15
            });

            //create Circle Layer
            var circleLayer = L.layerGroup(circles);

            // Create a baseMaps object to contain the streetmap and darkmap
            var baseMaps = {
                "Street": street,
                "Satellite": satellite,
                "Light": light,
                "Watermelon": watermelon,
                "Blue": blue

            };

            // Create an overlayMaps object here to contain the "State Population" and "City Population" layers
            var overlayMaps = {
                "Fault Lines": plateLayer,
                "Heatmap": heat,
                "Markers": markers,
                "Magnitude": circleLayer
            };

            // Creating map object
            var myMap = L.map("map", {
                center: [39.8283, -98.5795],
                zoom: 5,
                layers: [satellite, circleLayer, plateLayer]
            });

            // Create a layer control, containing our baseMaps and overlayMaps, and add them to the map
            // myMap.addLayer(markers);
            L.control.layers(baseMaps, overlayMaps).addTo(myMap);

            // Create a legend
            var legend = L.control({ position: 'bottomleft' });
            legend.onAdd = function() {
                var div = L.DomUtil.create("div", "info legend");

                //create HTML for legend (has to be i tags)
                div.innerHTML += "<p>Magnitude</p>";
                div.innerHTML += '<i style="background: forestgreen"></i><span>0-1</span><br>';
                div.innerHTML += '<i style="background: goldenrod"></i><span>1-3</span><br>';
                div.innerHTML += '<i style="background: dodgerblue"></i><span>3-5</span><br>';
                div.innerHTML += '<i style="background: mediumvioletred"></i><span>5+</span><br>';

                return div;
            }
            legend.addTo(myMap);


        });
    });
}

//Dynamically determine markerSize
function getMarkerSize(magnitude) {
    let radius = 5000;
    if (magnitude > 0) {
        radius = magnitude * 10000;
    }
    return radius;
}

//Dynamically determine fillColor
function getCircleColor(magnitude) {
    let color = "";
    if (magnitude > 5) {
        color = "mediumvioletred";
    } else if (magnitude > 3) {
        color = "dodgerblue";
    } else if (magnitude > 1) {
        color = "goldenrod";
    } else {
        color = "forestgreen";
    }
    return color;
}

//Dynamically determine lineColor
function getLineColor(magnitude) {
    let color = "";
    if (magnitude > 5) {
        color = "deeppink";
    } else if (magnitude > 3) {
        color = "aqua";
    } else if (magnitude > 1) {
        color = "gold";
    } else {
        color = "greenyellow";
    }
    return color;
}