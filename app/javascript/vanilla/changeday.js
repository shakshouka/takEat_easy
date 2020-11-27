import { swiper } from "../plugins/swiper";

const changeday = () => {

  let active = document.querySelector(".week-icon-active");
  if (active) {

    let icons = document.querySelectorAll(".fa-circle");
    icons.forEach((icon) => {
      icon.addEventListener("click", (event) => {
        event.preventDefault();
        let active = document.querySelector(".week-icon-active");
        active.classList.remove("week-icon-active");
        icon.classList.add("week-icon-active");

        if (icon.classList.contains("mon")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".mon")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("tue")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".tue")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("wed")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".wed")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("thu")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".thu")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("fri")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".fri")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("sat")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".sat")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (icon.classList.contains("sun")){
          let swipers = document.querySelectorAll(".swiper-container");
          let rightones = document.querySelectorAll(".sun")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };
        swiper();


      })})};
  };

export { changeday };



