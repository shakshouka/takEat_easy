const loader = () => {
  if (document.querySelector("#loader")){
    setTimeout(function(){
      window.location.replace("http://google.com")
    }, 4000)}
};

export { loader }
