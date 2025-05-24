chrome.action.onClicked.addListener((tab) => {
    chrome.tabs.create({ url: "https://www.crunchyroll.com" });
});

chrome.tabs.onRemoved.addListener((tabId, removeInfo) => {
    console.log("🧪 Onglet fermé → vérification en cours...");
    chrome.tabs.query({}, (tabs) => {
        console.log("📄 Onglets restants :", tabs.map(t => t.url));
        const crunchyStillOpen = tabs.some(tab => tab.url?.includes("crunchyroll.com"));
        if (!crunchyStillOpen) {
            console.log("🔻 Crunchyroll fermé. Envoi signal à l'app macOS.");
            fetch("http://localhost:5555/quit").catch(err => {
                console.error("❌ Impossible de contacter l'app :", err);
            });
        } else {
            console.log("🟠 Crunchyroll encore ouvert quelque part.");
        }
    });
});
