let table = document.querySelector("table");
let counter = 0;

function addContact() {
  let tableRow = document.createElement("tr");
  tableRow.id = "table" + counter;

  ["name", "number", "address", "comment"].forEach(function(i) {
    let tableHeader = document.createElement("th");
    let input = document.createElement("input");
    input.name = i + "[]";
    input.required = "true";
    tableHeader.appendChild(input);
    tableRow.appendChild(tableHeader);
  });

  let deleteButton = document.createElement('button')
  deleteButton.innerHTML = "X";
  deleteButton.onclick = function(){
    tableRow.parentNode.removeChild(tableRow)
  };

  tableRow.appendChild(deleteButton);
  table.appendChild(tableRow);
  counter++;
};
