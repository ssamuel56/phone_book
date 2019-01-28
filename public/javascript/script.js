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

  let deleteButton = document.createElement("button");
  deleteButton.innerHTML = "X";
  deleteButton.onclick = function(){
    tableRow.parentNode.removeChild(tableRow);
  };

  tableRow.appendChild(deleteButton);
  table.appendChild(tableRow);
  counter++;
};


let modal = document.getElementById("myModal");
let btn = document.getElementById("modalButton");
let span1 = document.getElementsByClassName("close1")[0];

btn.onclick = function() {
  modal.style.display = "block";
};

span1.onclick = function() {
  modal.style.display = "none";
};



function edit(array) {
  let ary = array.split(",");
  let editModal = document.getElementById("editModal");
  let span2 = document.getElementsByClassName("close2")[0];
  let editContact = document.getElementById("editContact");

  while (editContact.firstChild) {
    editContact.removeChild(editContact.firstChild);
  };

  editModal.style.display = "block";

  span2.onclick = function() {
    editModal.style.display = "none";
  };

  let field = document.createElement("input");
  field.name = "toChange[]";
  field.type = "hidden";
  field.value = ary[0];
  editContact.appendChild(field);

  ary.forEach(function(i){
    let field = document.createElement("input");
    field.name = "toChange[]";
    field.value = i;
    editContact.appendChild(field);
  });
};
