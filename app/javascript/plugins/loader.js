const loader = () => {
  const host = window.location.host
  if (document.querySelector("#loader")){
    setTimeout(function(){
      window.location.replace("http://" + host + "/weeks/1")
    }, 2000)}
};

export { loader }
