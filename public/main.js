import { env } from "./env.js";

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js", {
        type: "module",
      })
      .then((registration) => {
        console.log(
          "ServiceWorker registration successful with scope: ",
          registration.scope
        );
      })
      .catch((error) => {
        console.log("ServiceWorker registration failed: ", error);
      });
  });
}

document.addEventListener("DOMContentLoaded", () => {
  const showMeButton = document.getElementById("show-me");

  showMeButton.addEventListener("click", (e) => {
    e.preventDefault();
    // Get random card from deck
    const randomCard =
      env.deckFiles[Math.floor(Math.random() * env.deckFiles.length)];
    // Create and show image
    const img = document.createElement("img");
    img.src = `/deck/${randomCard}`;
    img.alt = "Random card";

    // Create new card section
    const newCard = document.createElement("section");
    newCard.className = "card";
    newCard.appendChild(img);

    // Append to main
    document.querySelector("main").appendChild(newCard);
  });
});
