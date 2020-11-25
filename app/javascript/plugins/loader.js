const loader = () => {
  setTimeout(function(){
    const body = document.querySelector("body");
    body.classList.add("loaded");
  }, 3000);
};

export { loader }
