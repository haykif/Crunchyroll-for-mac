document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("openBtn");
  btn?.addEventListener("click", () => {
    chrome.tabs.create({ url: "https://www.crunchyroll.com" });
  });
});
