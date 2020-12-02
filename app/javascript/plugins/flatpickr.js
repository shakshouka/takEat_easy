import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
 // Note this is important!

const initFlatpickr = () => {
  flatpickr(".flatpickr", {
      inline: true,
      "locale": French,
  });
};

export { initFlatpickr };
