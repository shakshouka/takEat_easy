import { swiper } from "../plugins/swiper";

const changeday = () => {

  let active = document.querySelector(".day-active");
  if (active) {

    let days = document.querySelectorAll(".jourdelasemaine");
    days.forEach((day) => {
      day.addEventListener("click", (event) => {
        event.preventDefault();
        let active = document.querySelector(".day-active");
        active.classList.remove("day-active");
        day.classList.add("day-active");

        if (day.classList.contains("mon")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".mon")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("tue")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".tue")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("wed")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".wed")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("thu")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".thu")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("fri")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".fri")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("sat")){
          let swipers = document.querySelectorAll(".repas");
          let rightones = document.querySelectorAll(".sat")
          swipers.forEach( (swiper) => {
            swiper.classList.add("hidden");
          });
          rightones.forEach( (rightone) => {
            rightone.classList.remove("hidden");
          })
        };

        if (day.classList.contains("sun")){
          let swipers = document.querySelectorAll(".repas");
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



