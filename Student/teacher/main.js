﻿
let list = document.querySelectorAll(".navigation ul li");

function activeLink() {
    list.forEach((item) => {
        item.classList.remove("hovered");
    });
    this.classList.add("hovered");
}

list.forEach((item) => item.addEventListener("mouseover", activeLink));


let toggle = document.querySelector(".toggel");
let navigation = document.querySelector(".navigation");
let main = document.querySelector(".main");


toggle.onclick = function () {
    navigation.classList.toggle("active");
    main.classList.toggle("active");
}