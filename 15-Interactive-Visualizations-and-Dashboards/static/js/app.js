$(document).ready(function() {
    populateIDFilter();
});

function populateIDFilter() {
    //Import local dataset with Ajax
    $.ajax({
        type: 'GET',
        url: "static/data/samples.json",
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            console.log(data);
            //Cycle through names list
            data["names"].forEach(function(id) {
                //Dynamically build dropdown menu
                let option = `<option>${id}</option>`;
                //Reference "selDataset" ID in HTML
                $('#selDataset').append(option);
            });

            let initID = data["names"][0]

            optionChanged(initID);
        }
    });
}

//Execute functions with the Dropdown Menu is selected
//Associated with "optionChanged" ID in HTML
function optionChanged(id) {
    loadMetaData(id);
    makeBarPlot(id);
    makeBubblePlot(id);
    makeGaugePlot(id);
}

function loadMetaData(id) {
    //Import local dataset with Ajax
    $.ajax({
        type: 'GET',
        url: "static/data/samples.json",
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            //Filter for MetaData that matches the corresponding Test Subject ID
            let metaData = data["metadata"].filter(x => x.id == id)[0];
            console.log(metaData);

            //Clear the MetaData Summary
            $('#sample-metadata').empty();

            //For each key/value pair in the MetaData Object
            //Output key/value pair
            Object.entries(metaData).forEach(function([key, value]) {
                let info = `<p><b>${key.toUpperCase()}</b> : ${value} </p>`;
                //Reference "sample-metadata" ID in HTML
                $('#sample-metadata').append(info);
            });
        }
    });
}

function makeBarPlot(id) {
    //Import local dataset with Ajax
    $.ajax({
        type: 'GET',
        url: "static/data/samples.json",
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            // Filter for SampleData that matches the corresponding Test Subject ID
            let sampleData = data["samples"].filter(x => x.id == id)[0];

            //https://stackoverflow.com/questions/22015684/how-do-i-zip-two-arrays-in-javascript
            //Merge two "otu_ids" and "sample_values" to create (x,y) pairs
            // Plotly graph can be then be created to render graph
            let plotData = sampleData["otu_ids"].map(function(e, i) {
                return [e, sampleData["sample_values"][i]];
            });

            //Sort by "sample_values"
            let plotData_Sorted = plotData.sort((a, b) => b[1] - a[1]);
            //x-axis: Assign top 10 values
            x = plotData_Sorted.map(x => x[1]).slice(0, 10).reverse()
                //y-axis: Assign top 10 categories
            y = plotData_Sorted.map(x => "OTU " + x[0]).slice(0, 10).reverse()


            var traces = [{
                type: 'bar',
                x: x,
                y: y,
                orientation: 'h',
                marker: {
                    colorscale: 'YlGnBu'
                }
            }];

            var layout = {
                title: 'OTU Ids to Values'
            };
            //Reference "bar" ID in HTML
            Plotly.newPlot('bar', traces, layout);
        }
    });
}

function makeBubblePlot(id) {
    //Import local dataset with Ajax
    $.ajax({
        type: 'GET',
        url: "static/data/samples.json",
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            // Filter for SampleData that matches the corresponding Test Subject ID
            let sampleData = data["samples"].filter(x => x.id == id)[0];

            var trace1 = {
                x: sampleData["otu_ids"],
                y: sampleData["sample_values"],
                mode: 'markers',
                marker: {
                    colorscale: 'YlGnBu',
                    size: sampleData["sample_values"]
                }
            };

            var data = [trace1];

            var layout = {
                title: 'OTU Ids to Values',
                showlegend: false,
            };
            //Reference "bubble" ID in HTML
            Plotly.newPlot('bubble', data, layout);
        }
    });
}

function makeGaugePlot(id) {
    //Import local dataset with Ajax
    $.ajax({
        type: 'GET',
        url: "static/data/samples.json",
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            // Filter for MetaData that matches the corresponding Test Subject ID
            let sampleData = data["metadata"].filter(x => x.id == id)[0];

            let all_wfreq = data['metadata'].map(x => x.wfreq);
            all_wfreq = all_wfreq.filter(function(e1) {
                return e1 != null;
            });

            // Calculate average
            let average = (array) => array.reduce((a, b) => a + b) / array.length;

            var trace1 = {
                type: "indicator",
                mode: "gauge+number+delta",
                value: sampleData.wfreq,
                delta: { reference: average(all_wfreq), increasing: { color: "RebeccaPurple" } },
                gauge: {
                    axis: { range: [Math.min(...all_wfreq), Math.max(...all_wfreq)], tickwidth: 1, tickcolor: "darkblue" },
                    bar: { color: "darkorange" },
                    bgcolor: "white",
                    borderwidth: 2,
                    bordercolor: "gray",
                    steps: [
                        { range: [Math.min(...all_wfreq), Math.max(...all_wfreq)], color: "antiquewhite" }
                    ],
                    threshold: {
                        line: { color: "red", width: 4 },
                        thickness: 0.75,
                        value: sampleData.wfreq
                    }
                }
            }

            var data = [trace1];

            var layout = {
                title: "Belly Button Wash Frequency"
            };
            //Reference "gauge" ID in HTML
            Plotly.newPlot('gauge', data, layout);
        }
    });
}