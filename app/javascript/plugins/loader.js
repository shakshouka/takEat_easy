const loader = () => {
  if (document.querySelector("#loader")){
    setTimeout(function(){
      window.location.replace("http://www.takeateasy.club/weeks/1")
    }, 2000)}
};

export { loader }
