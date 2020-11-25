const loader = () => {
  setTimeout(function(){
    const body = document.querySelector("body");
    body.classList.add("loaded");
  }, 4000);
};

export { loader }
