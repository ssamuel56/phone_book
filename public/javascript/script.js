let table = document.getElementById("modalTable");
let counter = 0;

function addContact() {
  let tableRow = document.createElement("tr");
  tableRow.id = "table" + counter;

  ["name", "number", "address", "comment"].forEach(function(i) {
    let tableHeader = document.createElement("th");
    let input = document.createElement("input");
    input.name = i + "[]";
    input.required = "true";
    input.pattern = "[a-zA-Z0-9 /s -]{3,20}";
    tableHeader.appendChild(input);
    tableRow.appendChild(tableHeader);
  });

  let deleteButton = document.createElement('button');
  deleteButton.innerHTML = "X";
  deleteButton.onclick = function(){
    tableRow.parentNode.removeChild(tableRow);
  };

  tableRow.appendChild(deleteButton);
  table.appendChild(tableRow);
  counter++;
};


let modal = document.getElementById('myModal');
let btn = document.getElementById("modalButton");
let span = document.getElementsByClassName("close")[0];

btn.onclick = function() {
  modal.style.display = "block";
};

span.onclick = function() {
  modal.style.display = "none";
};
