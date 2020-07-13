// from data.js
var tableData = data;

// Select the button
var button = d3.select("#filter-btn");

// Select the form
var form = d3.select("#form");

//Create Event Listeners
//Trigger on hitting "Filter Table" Button OR pressing Enter
button.on("click", runEnter);
form.on("submit", runEnter);

//On initial load of page, show all data
runEnter();

// Complete the event handler function for the form
function runEnter() {

    // Prevent the page from refreshing
    if (d3.event) {
        d3.event.preventDefault();
    }

    // Select the input element and get the raw HTML node
    var inputElement = d3.select("#datetime");

    // Get the value property of the input element
    var inputValue = inputElement.property("value");

    //Only filter if User Input is provided
    var sub_data = tableData;
    if (inputValue !== "") {
        sub_data = tableData.filter(x => x.datetime === inputValue);
    }

    //Dynamically Build Table with D3
    //Empty table before populating with new rows
    var table = d3.select("#ufo-table");
    //Loop through dataset
    table.select('tbody').html("");
    sub_data.forEach(function(ufo) {
        let newRow = table.select("tbody").append("tr");
        Object.entries(ufo).forEach(function([key, value]) {
            newRow.append("td").text(value);
        });
    });
};