const menu = () => {
var items = document.querySelectorAll('.circle a');
let menu = document.querySelector(".menu-button");
  if (menu) {
    items.forEach((item, index) => {
      item.style.left = (10 - 35*Math.cos(-0.5 * Math.PI - 2*(1/items.length)*index*Math.PI)).toFixed(4) + "%";

      item.style.top = (10 + 100*Math.sin(-0.5 * Math.PI - 2*(1/items.length)*index*Math.PI)).toFixed(4) + "%";
    })
    document.querySelector('.menu-button').onclick = function(e) {
       e.preventDefault(); document.querySelector('.circle').classList.toggle('open');
    }
  }
}

export { menu }
