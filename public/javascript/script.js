let table = document.getElementById("modalTable");
let counter = 0;

function addContact() {
  let tableRow = document.createElement("tr");
  tableRow.id = "table" + counter;

  ["name", "number", "address", "comment"].forEach(function(i) {
    let tableHeader = document.createElement("th");
    let input = document.createElement("input");
    input.type = "text";
    input.name = i + "[]";
    input.required = "true";
    input.pattern = "[a-zA-Z0-9 /s -]{3,35}";
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
let span2 = document.getElementsByClassName("close2")[0];
let hidden = document.getElementById("hidden")

btn.onclick = function() {
  modal.style.display = "block";
  hidden.style.visibility = "hidden";
  addContact();
};

span1.onclick = function() {
  modal.style.display = "none";
  hidden.style.visibility = "visible";
};

span2.onclick = function() {
  editModal.style.display = "none";
  hidden.style.visibility = "visible";
};


function edit(array) {
  let ary = array.split(",");
  let editModal = document.getElementById("editModal");
  let editContact = document.getElementById("editContact");
  let hidden = document.getElementById("hidden")

  while (editContact.firstChild) {
    editContact.removeChild(editContact.firstChild);
  };

  editModal.style.display = "block";
  hidden.style.visibility = "hidden";

  let input = document.createElement("input");
  input.name = "toChange[]";
  input.type = "hidden";
  input.value = ary[0];
  editContact.appendChild(input);

  ary.forEach(function(i){
    let input = document.createElement("input");
    let header = document.createElement("th");
    input.type = "text";
    input.name = "toChange[]";
    input.value = i;
    input.required = "true";
    input.pattern = "[a-zA-Z0-9 /s -]{3,35}";
    header.appendChild(input);
    editContact.appendChild(header);
  });
};
