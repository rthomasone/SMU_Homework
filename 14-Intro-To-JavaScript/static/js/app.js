//global
var tableData = data;

// $(document).ready executes JavaScript once HTML finishes loading
$(document).ready(function() {
    //Initial Load: Populate Filter & DataTable
    populateStateFilter();
    populateCountryFilter();
    populateShapeFilter();
    buildTable();

    //Event Listeners on "Filter Table" Button Click
    //Prevent page from refreshing
    $('#filter-btn').on("click", function(event) {
        event.preventDefault();
        buildTable();
    });
    //Event Listeners on pressing Enter
    $('#form').on("submit", function(event) {
        event.preventDefault();
        buildTable();
    });
    //Event Listeners making selection from Dropdown buttons
    $('#stateFilter, #countryFilter, #shapeFilter').on("change", function(event) {
        event.preventDefault();
        buildTable();
    });
});

//Create Dynamic Filters
function populateStateFilter() {
    //Parse dataset for unique values. Create List.
    var states = [...new Set(tableData.map(x => x.state))];
    states.sort();

    //Loop through list & append items to dropdown
    states.forEach(function(state) {
        let selection = `<option>${state}</option>`
        $('#stateFilter').append(selection);
    });
}

function populateCountryFilter() {
    var countries = [...new Set(tableData.map(x => x.country))];
    countries.sort();

    countries.forEach(function(country) {
        let selection = `<option>${country}</option>`
        $('#countryFilter').append(selection);
    });
}

function populateShapeFilter() {
    var shapes = [...new Set(tableData.map(x => x.shape))];
    shapes.sort();

    shapes.forEach(function(shape) {
        let selection = `<option>${shape}</option>`
        $('#shapeFilter').append(selection);
    });
}


function buildTable() {
    //Capture user input. Set Filters.
    var inputValue = $('#datetime').val();
    var stateFilter = $('#stateFilter').val();
    var countryFilter = $('#countryFilter').val();
    var shapeFilter = $('#shapeFilter').val();

    // Use the form input to filter the data by blood type
    var sub_data = tableData;
    if (inputValue !== "") {
        sub_data = tableData.filter(x => Date.parse(x.datetime) === Date.parse(inputValue));
    }
    if (stateFilter != "All") {
        sub_data = sub_data.filter(x => x.state === stateFilter);
    }
    if (countryFilter != "All") {
        sub_data = sub_data.filter(x => x.country === countryFilter);
    }
    if (shapeFilter != "All") {
        sub_data = sub_data.filter(x => x.shape === shapeFilter);
    }

    //Empty table before populating with new rows
    //Build table with DataTables
    $('#ufo-table').DataTable().clear().destroy();
    $('#ufo-table tbody').empty();
    // Dynamically build table
    sub_data.forEach(function(thing) {
        let row = "<tr>"
        Object.entries(thing).forEach(function([key, value]) {
            row += `<td>${value}</td>`;
        });
        row += "</tr>";
        $('#ufo-table tbody').append(row);
    });
    $('#ufo-table').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'csvHtml5',
            ]
        }) //rebuild it

}