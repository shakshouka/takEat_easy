const loader = () => {
  if (document.querySelector("#loader")){
    setTimeout(function(){
      window.location.replace("http://localhost:3000/weeks/1")
    }, 4000)}
};

export { loader }
