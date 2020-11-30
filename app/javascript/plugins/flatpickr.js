import flatpickr from "flatpickr";
 // Note this is important!

const initFlatpickr = () => {
  flatpickr(".flatpickr", {
      inline: true
  });
};

export { initFlatpickr };
