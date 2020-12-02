const calendarbtn = () => {
  if (document.querySelector(".btn-calendar-off")) {
    let dayContainer = document.querySelector(".dayContainer");
    let btn = document.querySelector(".btn-calendar-off");
    dayContainer.addEventListener("click", (event) => {
      btn.classList.remove("btn-calendar-off");
      btn.classList.add("btn-calendar");
    })
  };
}


export { calendarbtn }
