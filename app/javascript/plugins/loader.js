const loader = () => {
  if (document.querySelector("#loader")){
    setTimeout(function(){
      window.location.replace("http://takeateasy.club/weeks/1")
    }, 4000)}
};

export { loader }
